import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

class GsaWidgetOverlayBuilder extends GsaWidgetOverlay {
  const GsaWidgetOverlayBuilder({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<GsaWidgetOverlayBuilder> createState() => _GsaWidgetOverlayBuilderState();
}

class _GsaWidgetOverlayBuilderState extends State<GsaWidgetOverlayBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
