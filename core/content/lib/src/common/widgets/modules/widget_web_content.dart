import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Widget integrating system WebView components for web content display.
///
class GsaWidgetWebContent extends StatefulWidget {
  // ignore: public_member_api_docs
  const GsaWidgetWebContent(
    this.url, {
    super.key,
  });

  /// Web resource location.
  ///
  final String url;

  @override
  State<GsaWidgetWebContent> createState() => _GsaWidgetWebContentState();
}

class _GsaWidgetWebContentState extends State<GsaWidgetWebContent> {
  late WebViewController _controller;

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() => _loading = false);
          },
          onWebResourceError: (WebResourceError error) {
            setState(() => _loading = false);
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
            child: GsaWidgetLoadingIndicator(),
          )
        : WebViewWidget(controller: _controller);
  }
}
