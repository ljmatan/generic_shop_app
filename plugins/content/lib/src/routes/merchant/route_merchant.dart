import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: GsaWidgetText(widget.displayName)));
  }
}
