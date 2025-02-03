import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_web_content.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Route displaying the sale item details, also providing related checkout / cart mechanisms.
///
class GsaRouteSaleItemDetails extends GsaRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteSaleItemDetails(
    this.saleItem, {
    super.key,
  });

  /// Sale item visually represented by this route.
  ///
  final GsaaModelSaleItem? saleItem;

  @override
  State<GsaRouteSaleItemDetails> createState() => _GsaRouteSaleItemDetailsState();
}

class _GsaRouteSaleItemDetailsState extends GsarRouteState<GsaRouteSaleItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.displayName,
        ),
      ),
      body: widget.saleItem?.originUrl != null
          ? GsaWidgetWebContent(
              widget.saleItem!.originUrl!,
            )
          : ListView(
              children: [],
            ),
    );
  }
}
