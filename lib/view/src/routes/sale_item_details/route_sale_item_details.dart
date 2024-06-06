import 'package:flutter/material.dart';
import 'package:generic_shop_app_api/src/models/models.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_web_content.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';

/// Route displaying the sale item details, also providing related checkout / cart mechanisms.
///
class GsaRouteProductDetails extends GsaRoute {
  // ignore: public_member_api_docs
  const GsaRouteProductDetails({
    super.key,
    this.saleItem,
  });

  /// Sale item visually represented by this route.
  ///
  final GsaaModelSaleItem? saleItem;

  @override
  State<GsaRouteProductDetails> createState() => _GsaRouteProductDetailsState();

  @override
  String get routeId => 'sale-item';

  @override
  String get displayName => 'Item Details';
}

class _GsaRouteProductDetailsState extends GsaRouteState<GsaRouteProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
      body: widget.saleItem?.originUrl != null
          ? GsaWidgetWebContent(widget.saleItem!.originUrl!)
          : ListView(
              children: [],
            ),
    );
  }
}
