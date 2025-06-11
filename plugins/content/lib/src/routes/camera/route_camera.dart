import 'package:camera/camera.dart' as camera;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// Screen providing camera photo capture and scanner functionalities.
///
class GsaRouteCamera extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteCamera({
    super.key,
    this.cameraLensDirection = camera.CameraLensDirection.back,
  });

  final camera.CameraLensDirection cameraLensDirection;

  @override
  State<GsaRouteCamera> createState() => _GsaRouteCameraState();
}

class _GsaRouteCameraState extends GsaRouteState<GsaRouteCamera> with WidgetsBindingObserver {
  camera.CameraController? _cameraController;

  Key _cameraInitFutureKey = UniqueKey();

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
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (_cameraController == null || _cameraController?.value.isInitialized != true) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _cameraController?.dispose();
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

                return Column(
                  children: [],
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
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
