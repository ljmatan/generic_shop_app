import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_text.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Route displaying the merchant / vendor information.
///
class GsaRouteMerchant extends GsaRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteMerchant({super.key});

  @override
  State<GsaRouteMerchant> createState() => _GsaRouteMerchantState();
}

class _GsaRouteMerchantState extends GsarRouteState<GsaRouteMerchant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: GsaWidgetText(widget.displayName)));
  }
}
