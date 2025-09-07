import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

/// Route displaying the merchant / vendor information.
///
class GsaRouteMerchant extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteMerchant({super.key});

  @override
  State<GsaRouteMerchant> createState() => _GsaRouteMerchantState();
}

class _GsaRouteMerchantState extends GsaRouteState<GsaRouteMerchant> {
  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GsaWidgetAppBar(
            label: widget.displayName,
          ),
        ],
      ),
    );
  }
}
