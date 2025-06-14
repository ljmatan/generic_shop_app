import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// Route for displaying of the payment status after the checkout process has been completed.
///
class GsaRoutePaymentStatus extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRoutePaymentStatus({super.key});

  @override
  State<GsaRoutePaymentStatus> createState() => _GsaRoutePaymentStatusState();
}

class _GsaRoutePaymentStatusState extends GsaRouteState<GsaRoutePaymentStatus> {
  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GsaWidgetAppBar(
            label: widget.displayName,
          ),
          const Expanded(
            child: GsaWidgetWebContent(
              'https://example.org',
            ),
          ),
        ],
      ),
    );
  }
}
