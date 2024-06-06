import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_web_content.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';

/// Route for displaying of the payment status after the checkout process has been completed.
///
class GsaRoutePaymentStatus extends GsaRoute {
  // ignore: public_member_api_docs
  const GsaRoutePaymentStatus({super.key});

  @override
  State<GsaRoutePaymentStatus> createState() => _GsaRoutePaymentStatusState();

  @override
  String get routeId => 'payment-status';

  @override
  String get displayName => 'Payment Status';
}

class _GsaRoutePaymentStatusState extends GsaRouteState<GsaRoutePaymentStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
      body: const GsaWidgetWebContent('https://example.org'),
    );
  }
}
