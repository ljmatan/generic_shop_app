import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_api/api.dart';

/// Route displaying the sale item details, also providing related checkout / cart mechanisms.
///
class GsaRouteSaleItemDetails extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteSaleItemDetails(
    this.saleItem, {
    super.key,
  });

  /// Sale item visually represented by this route.
  ///
  final GsaModelSaleItem? saleItem;

  @override
  State<GsaRouteSaleItemDetails> createState() => _GsaRouteSaleItemDetailsState();
}

class _GsaRouteSaleItemDetailsState extends GsaRouteState<GsaRouteSaleItemDetails> {
  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GsaWidgetAppBar(
            label: widget.displayName,
          ),
          Expanded(
            child: widget.saleItem?.originUrl != null
                ? GsaWidgetWebContent(
                    widget.saleItem!.originUrl!,
                  )
                : ListView(
                    children: [],
                  ),
          ),
        ],
      ),
    );
  }
}
