import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_text.dart';
import 'package:gsa_architecture/gsa_architecture.dart';

/// Route displaying the merchant / vendor information.
///
class GsaRouteMerchant extends GsarRoute {
  // ignore: public_member_api_docs
  const GsaRouteMerchant({super.key});

  @override
  State<GsaRouteMerchant> createState() => _GsaRouteMerchantState();

  @override
  String get routeId => 'merchant';

  @override
  String get displayName => 'Merchant Details';
}

class _GsaRouteMerchantState extends GsarRouteState<GsaRouteMerchant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GsaWidgetText(widget.displayName),
      ),
    );
  }
}
