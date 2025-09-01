import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:generic_shop_app_services/services.dart';

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
  })  : _networkImage = false,
        cached = false,
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
    this.cached = false,
  })  : type = GsaWidgetImageByteType.standard,
        _networkImage = true,
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
        _networkImage = false,
        cached = false;

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
        _networkImage = false,
        cached = false;

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
        _networkImage = false,
        cached = false;

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
  final bool _networkImage;

  /// Defines whether this image will get saved to device memory.
  ///
  /// Applicable only to network images.
  ///
  final bool cached;

  @override
  State<GsaWidgetImage> createState() => _GsaWidgetImageState();
}

class _GsaWidgetImageState extends State<GsaWidgetImage> {
  @override
  Widget build(BuildContext context) {
    try {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: widget.shadows != null
            ? DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: widget.shadows,
                ),
                child: _GsaWidgetImageBuilder(
                  widget: widget,
                ),
              )
            : _GsaWidgetImageBuilder(
                widget: widget,
              ),
      );
    } catch (e) {
      GsaServiceLogging.instance.logError('$e');
      return SizedBox(
        width: widget.width,
        height: widget.height,
      );
    }
  }
}

class _GsaWidgetImageBuilder extends StatelessWidget {
  const _GsaWidgetImageBuilder({
    required this.widget,
  });

  final GsaWidgetImage widget;

  @override
  Widget build(BuildContext context) {
    if (widget.inputString != null) {
      if (widget.type == GsaWidgetImageByteType.standard) {
        return Image.memory(
          base64Decode(widget.inputString!),
          width: widget.width,
          height: widget.height,
          color: widget.colorFilter,
          fit: widget.fit,
          alignment: widget.alignment,
        );
      } else {
        return SvgPicture.string(
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
        );
      }
    }
    if (widget.bytes.isNotEmpty) {
      if (widget.type == GsaWidgetImageByteType.standard) {
        return Image.memory(
          Uint8List.fromList(widget.bytes),
          width: widget.width,
          height: widget.height,
          color: widget.colorFilter,
          fit: widget.fit,
          alignment: widget.alignment,
        );
      } else {
        return SvgPicture.memory(
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
        );
      }
    }
    if (widget.path.isNotEmpty) {
      if (widget.path.endsWith('.svg')) {
        if (widget._networkImage) {
          return SvgPicture.network(
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
          );
        } else if (widget.path == GsaWidgetImage._placeholderAssetPath) {
          return SizedBox(
            width: widget.width,
            height: widget.height,
            child: Center(
              child: Icon(
                Icons.broken_image_outlined,
                color: Colors.grey,
                size: (((widget.width ?? 0) > (widget.height ?? 0) ? widget.height : widget.width) ?? 0) / 1.5,
              ),
            ),
          );
        } else {
          return SvgPicture.asset(
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
          );
        }
      }
      if (widget._networkImage == true) {
        if (widget.cached) {
          return CachedNetworkImage(
            imageUrl: widget.path,
            width: widget.width,
            height: widget.height,
            color: widget.colorFilter,
            fit: widget.fit,
            alignment: widget.alignment as Alignment,
          );
        } else {
          Image.network(
            widget.path,
            width: widget.width,
            height: widget.height,
            color: widget.colorFilter,
            fit: widget.fit,
            alignment: widget.alignment,
          );
        }
      }
    } else {
      return Image.asset(
        widget.path,
        width: widget.width,
        height: widget.height,
        color: widget.colorFilter,
        fit: widget.fit,
        alignment: widget.alignment,
      );
    }
    return SizedBox(
      width: widget.width,
      height: widget.height,
    );
  }
}
