import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

/// Route displaying the sale item details, also providing related checkout / cart mechanisms.
///
class GsaRouteSaleItemDetails extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  GsaRouteSaleItemDetails(
    this.saleItem, {
    super.key,
  }) {
    GsaRouteSaleItemDetails.selectedSaleItem = saleItem;
  }

  /// Sale item visually represented by this route.
  ///
  final GsaModelSaleItem? saleItem;

  /// Sale item information propagated via static property.
  ///
  static GsaModelSaleItem? selectedSaleItem;

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
