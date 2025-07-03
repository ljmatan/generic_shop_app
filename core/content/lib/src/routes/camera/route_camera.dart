import 'package:camera/camera.dart' as camera;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_data/data.dart';
import 'package:generic_shop_app_services/services.dart';
import 'package:image/image.dart' as imglib;
import 'package:zxing2/qrcode.dart' as zxing;

/// Defines the functional mode of the camera within the GSA route flow.
///
/// This is used to distinguish between scanning functionality (e.g., QR or barcode scanning)
/// and image capture functionality (e.g., taking a photo for later upload or verification).
///
enum GsaRouteCameraMode {
  /// Activates the camera in scanning mode.
  ///
  /// This mode is optimized for detecting and reading visual codes (such as QR codes or barcodes),
  /// typically for identification, navigation, or route validation.
  ///
  scan,

  /// Activates the camera in capture mode.
  ///
  /// This mode allows the user to take a photo, usually for documentation, verification,
  /// or later file upload and processing within the route workflow.
  ///
  capture;

  /// User-visible short label for this mode.
  ///
  String get label {
    switch (this) {
      case GsaRouteCameraMode.scan:
        return 'Code Scan';
      case GsaRouteCameraMode.capture:
        return 'Photo Capture';
    }
  }

  /// User-visible descriptive explanation for this mode.
  ///
  /// Can be used in tooltips, onboarding messages, or inline instructions.
  String get description {
    switch (this) {
      case GsaRouteCameraMode.scan:
        return 'Use the camera to scan QR codes or barcodes for identification or navigation.';
      case GsaRouteCameraMode.capture:
        return 'Take a photo to document, verify, or upload as part of your route.';
    }
  }
}

/// Screen providing camera photo capture and scanner functionalities.
///
class GsaRouteCamera extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteCamera({
    super.key,
    required this.mode,
    this.cameraLensDirection = camera.CameraLensDirection.back,
  });

  /// Specified camera recording mode.
  ///
  final GsaRouteCameraMode mode;

  /// Default camera lens direction, to be displayed on screen open.
  ///
  final camera.CameraLensDirection cameraLensDirection;

  @override
  State<GsaRouteCamera> createState() => _GsaRouteCameraState();
}

class _GsaRouteCameraState extends GsaRouteState<GsaRouteCamera> with WidgetsBindingObserver {
  camera.CameraController? _cameraController;

  Key _cameraInitFutureKey = UniqueKey();

  Future<void> _releaseCameraResources() async {
    try {
      await _cameraController?.stopImageStream();
    } catch (e) {
      GsaServiceLogging.instance.logError('$e');
    }
    try {
      await _cameraController?.dispose();
    } catch (e) {
      GsaServiceLogging.instance.logError('$e');
    }
  }

  Future<void> _initialiseCameraController() async {
    final cameras = await camera.availableCameras();
    final specifiedCamera = cameras.firstWhereOrNull(
      (availableCamera) {
        return availableCamera.lensDirection == widget.cameraLensDirection;
      },
    );
    if (specifiedCamera == null) {
      throw 'No camera with lens direction "${widget.cameraLensDirection.name}" found.';
    }
    _cameraController = camera.CameraController(
      specifiedCamera,
      camera.ResolutionPreset.max,
      enableAudio: false,
    );
    await _cameraController!.initialize();
    if (widget.mode == GsaRouteCameraMode.scan) {
      final reader = zxing.QRCodeReader();
      bool processing = false;
      await _cameraController!.startImageStream(
        (cameraImage) async {
          if (!processing) {
            try {
              processing = true;

              imglib.Image imageFromBGRA8888(camera.CameraImage image) {
                return imglib.Image.fromBytes(
                  width: image.width,
                  height: image.height,
                  bytes: image.planes[0].bytes.buffer,
                  order: imglib.ChannelOrder.bgra,
                );
              }

              imglib.Image imageFromYUV420(camera.CameraImage image) {
                final uvRowStride = image.planes[1].bytesPerRow;
                final uvPixelStride = image.planes[1].bytesPerPixel ?? 0;
                final img = imglib.Image(width: image.width, height: image.height);
                for (final p in img) {
                  final x = p.x;
                  final y = p.y;
                  final uvIndex = uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
                  final index = y * uvRowStride + x;
                  final yp = image.planes[0].bytes[index];
                  final up = image.planes[1].bytes[uvIndex];
                  final vp = image.planes[2].bytes[uvIndex];
                  p.r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255).toInt();
                  p.g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91).round().clamp(0, 255).toInt();
                  p.b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255).toInt();
                }

                return img;
              }

              imglib.Image? imageFromCameraImage(camera.CameraImage image) {
                try {
                  imglib.Image img;
                  switch (image.format.group) {
                    case camera.ImageFormatGroup.yuv420:
                      img = imageFromYUV420(image);
                      break;
                    case camera.ImageFormatGroup.bgra8888:
                      img = imageFromBGRA8888(image);
                      break;
                    default:
                      return null;
                  }
                  return img;
                } catch (e) {
                  GsaServiceLogging.instance.logError('$e');
                }
                return null;
              }

              final image = imageFromCameraImage(cameraImage);
              if (image != null) {
                final source = zxing.RGBLuminanceSource(
                  image.width,
                  image.height,
                  image
                      .convert(
                        numChannels: 4,
                      )
                      .getBytes(
                        order: imglib.ChannelOrder.rgba,
                      )
                      .buffer
                      .asInt32List(),
                );
                final bitmap = zxing.BinaryBitmap(
                  zxing.GlobalHistogramBinarizer(source),
                );
                final result = reader.decode(bitmap);
                final code = result.text.trim();
                if (code.isNotEmpty) {
                  GsaServiceLogging.instance.logGeneral(code);
                  switch (GsaConfig.plugin.client) {
                    case GsaClient.froddoB2b:
                      final saleItem = GsaDataSaleItems.instance.collection.firstWhereOrNull(
                        (saleItem) {
                          return saleItem.productCode == code;
                        },
                      );
                      if (saleItem == null) {
                        await GsaWidgetOverlayAlert(
                          'Product $code not found.',
                        ).openDialog();
                      } else {
                        await _releaseCameraResources();
                        Navigator.pop(context);
                        GsaRouteSaleItemDetails(saleItem).push();
                      }
                      break;
                    default:
                    // Not implemented.
                  }
                }
              }
            } catch (e) {
              GsaServiceLogging.instance.logError('$e');
            }
            await Future.delayed(
              const Duration(
                milliseconds: 600,
              ),
            );
            processing = false;
          }
        },
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (_cameraController == null || _cameraController?.value.isInitialized != true) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _releaseCameraResources();
    } else if (state == AppLifecycleState.resumed) {
      setState(() => _cameraInitFutureKey = UniqueKey());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GsaWidgetAppBar(
            label: widget.displayName,
          ),
          Expanded(
            child: FutureBuilder(
              key: _cameraInitFutureKey,
              future: _initialiseCameraController(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: GsaWidgetError(
                      snapshot.error.toString(),
                      retry: () {
                        setState(() => _cameraInitFutureKey = UniqueKey());
                      },
                    ),
                  );
                }

                return ListView(
                  padding: Theme.of(context).listViewPadding,
                  children: [
                    GsaWidgetText(
                      widget.mode.label,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    GsaWidgetText(
                      widget.mode.description,
                    ),
                    const SizedBox(height: 16),
                    AspectRatio(
                      aspectRatio: _cameraController!.value.aspectRatio,
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(12),
                        child: camera.CameraPreview(
                          _cameraController!,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _releaseCameraResources();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
