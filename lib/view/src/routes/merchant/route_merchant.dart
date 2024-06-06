import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_text.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';

/// Route displaying the merchant / vendor information.
///
class GsaRouteMerchant extends GsaRoute {
  // ignore: public_member_api_docs
  const GsaRouteMerchant({super.key});

  @override
  State<GsaRouteMerchant> createState() => _GsaRouteMerchantState();

  @override
  String get routeId => 'merchant';

  @override
  String get displayName => 'Merchant Details';
}

class _GsaRouteMerchantState extends GsaRouteState<GsaRouteMerchant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GsaWidgetText(widget.displayName),
      ),
    );
  }
}
