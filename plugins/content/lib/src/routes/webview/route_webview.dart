import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Route designed for displaying of the cookie policy and related consent mechanisms.
///
class GsaRouteWebView extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteWebView({
    super.key,
    required this.url,
    required this.urlPath,
    required this.title,
  });

  /// Address of the web content for display.
  ///
  final String url;

  /// The navigation path appended to the host address.
  ///
  final String urlPath;

  /// Label for display at the app bar / header location.
  ///
  final String title;

  @override
  State<GsaRouteWebView> createState() => _GsaRouteWebViewState();
}

class _GsaRouteWebViewState extends GsaRouteState<GsaRouteWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
      body: GsaWidgetWebContent(widget.url),
    );
  }
}
