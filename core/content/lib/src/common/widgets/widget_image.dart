import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// The image file type specified for image file byte display with the [GsaWidgetImage]
///
enum GsaWidgetImageByteType {
  /// Standard file types (e.g. PNG, JPEG) supported for display by the Flutter framework.
  ///
  standard,

  /// For use with JPG string images.
  ///
  jpg,

  /// Format specified for SVG graphics, whose display is implemented with a 3rd-party library.
  ///
  svg,
}

/// The default element used for image viewing in various formats (e.g., svg or jpg),
/// and from various sources (e.g., network or asset) or directly from image file bytes.
///
class GsaWidgetImage extends StatefulWidget {
  /// Used with asset images referenced from the pubspec.yaml file.
  ///
  const GsaWidgetImage.asset(
    this.path, {
    this.type = GsaWidgetImageByteType.standard,
    super.key,
    this.width,
    this.height,
    this.colorFilter,
    this.shadows,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
  })  : networkImage = false,
        inputString = null,
        bytes = const [];

  /// Used for loading images from web.
  ///
  const GsaWidgetImage.network(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.colorFilter,
    this.shadows,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
  })  : type = GsaWidgetImageByteType.standard,
        networkImage = true,
        inputString = null,
        bytes = const [];

  /// Used for display of image file bytes.
  ///
  /// The required [imageType] parameter specifies whether the image is in SVG format,
  /// or whether it can be directly handled by the SDK.
  ///
  const GsaWidgetImage.bytes(
    this.bytes, {
    super.key,
    this.inputString,
    required this.type,
    this.width,
    this.height,
    this.colorFilter,
    this.shadows,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
  })  : path = '',
        networkImage = false;

  /// Used for displaying SVG files directly from [String] values, or for loading base64-encoded images.
  ///
  /// The [inputString] parameter specifies the input value, while the [type] parameter specifies the file type (SVG string or base64 image).
  ///
  const GsaWidgetImage.string(
    this.inputString, {
    super.key,
    this.bytes = const <int>[],
    this.width,
    this.height,
    this.colorFilter,
    this.shadows,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
  })  : type = GsaWidgetImageByteType.svg,
        path = '',
        networkImage = false;

  static const _placeholderAssetPath = 'assets/svg/placeholder.svg';

  /// Used for displaying of the placeholder image.
  ///
  const GsaWidgetImage.placeholder({
    super.key,
    this.inputString,
    this.bytes = const <int>[],
    this.type = GsaWidgetImageByteType.svg,
    this.width,
    this.height,
    this.colorFilter,
    this.shadows,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
  })  : path = _placeholderAssetPath,
        networkImage = false;

  /// The asset image path or network image URL.
  ///
  final String path;

  /// An optional way of providing the image to constructors in form of a [String] value.
  ///
  final String? inputString;

  /// Image file bytes.
  ///
  final List<int> bytes;

  /// Image file type, specified for images provided in the [List<int>] format.
  ///
  final GsaWidgetImageByteType type;

  /// Specified render box dimensions.
  ///
  final double? width, height;

  /// The overlay color applied to the displayed image.
  ///
  final Color? colorFilter;

  /// Optional [BoxDecoration.boxShadows] parameter.
  ///
  final List<BoxShadow>? shadows;

  /// Defines how the image fits into the given render box space.
  ///
  final BoxFit fit;

  /// The alignment aligns the given position in the image to the
  /// given position in the layout bounds.
  ///
  final AlignmentGeometry alignment;

  /// Defines whether the image is a network image.
  ///
  final bool networkImage;

  @override
  State<GsaWidgetImage> createState() => _GsaWidgetImageState();
}

class _GsaWidgetImageState extends State<GsaWidgetImage> {
  Widget get _imageProvider {
    return widget.inputString != null
        ? widget.type == GsaWidgetImageByteType.standard
            ? Image.memory(
                base64Decode(widget.inputString!),
                width: widget.width,
                height: widget.height,
                color: widget.colorFilter,
                fit: widget.fit,
                alignment: widget.alignment,
              )
            : SvgPicture.string(
                widget.inputString!,
                width: widget.width,
                height: widget.height,
                colorFilter: widget.colorFilter == null
                    ? null
                    : ColorFilter.mode(
                        widget.colorFilter!,
                        BlendMode.srcIn,
                      ),
                fit: widget.fit,
                alignment: widget.alignment,
              )
        : widget.bytes.isNotEmpty == true
            ? widget.type == GsaWidgetImageByteType.standard
                ? Image.memory(
                    Uint8List.fromList(widget.bytes),
                    width: widget.width,
                    height: widget.height,
                    color: widget.colorFilter,
                    fit: widget.fit,
                    alignment: widget.alignment,
                  )
                : SvgPicture.memory(
                    Uint8List.fromList(widget.bytes),
                    width: widget.width,
                    height: widget.height,
                    colorFilter: widget.colorFilter == null
                        ? null
                        : ColorFilter.mode(
                            widget.colorFilter!,
                            BlendMode.srcIn,
                          ),
                    fit: widget.fit,
                    alignment: widget.alignment,
                  )
            : widget.path.endsWith('.svg')
                ? widget.networkImage == true
                    ? SvgPicture.network(
                        widget.path,
                        width: widget.width,
                        height: widget.height,
                        colorFilter: widget.colorFilter == null
                            ? null
                            : ColorFilter.mode(
                                widget.colorFilter!,
                                BlendMode.srcIn,
                              ),
                        fit: widget.fit,
                        alignment: widget.alignment,
                      )
                    : widget.path == GsaWidgetImage._placeholderAssetPath
                        ? SizedBox(
                            width: widget.width,
                            height: widget.height,
                            child: Center(
                              child: Icon(
                                Icons.broken_image_outlined,
                                color: Colors.grey,
                                size: (((widget.width ?? 0) > (widget.height ?? 0) ? widget.height : widget.width) ?? 0) / 1.5,
                              ),
                            ),
                          )
                        : SvgPicture.asset(
                            widget.path,
                            width: widget.width,
                            height: widget.height,
                            colorFilter: widget.colorFilter == null
                                ? null
                                : ColorFilter.mode(
                                    widget.colorFilter!,
                                    BlendMode.srcIn,
                                  ),
                            fit: widget.fit,
                            alignment: widget.alignment,
                          )
                : widget.networkImage == true
                    ? Image.network(
                        widget.path,
                        width: widget.width,
                        height: widget.height,
                        color: widget.colorFilter,
                        fit: widget.fit,
                        alignment: widget.alignment,
                      )
                    : Image.asset(
                        widget.path,
                        width: widget.width,
                        height: widget.height,
                        color: widget.colorFilter,
                        fit: widget.fit,
                        alignment: widget.alignment,
                      );
  }

  @override
  Widget build(BuildContext context) {
    try {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: widget.shadows != null
            ? DecoratedBox(
                decoration: BoxDecoration(boxShadow: widget.shadows),
                child: _imageProvider,
              )
            : _imageProvider,
      );
    } catch (e) {
      debugPrint('$e');
      return SizedBox(width: widget.width, height: widget.height);
    }
  }
}
