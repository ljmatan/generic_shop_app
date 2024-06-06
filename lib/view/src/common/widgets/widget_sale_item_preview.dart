import 'package:flutter/material.dart';
import 'package:generic_shop_app/config.dart';
import 'package:generic_shop_app/data/data.dart';
import 'package:generic_shop_app/services/services.dart';
import 'package:generic_shop_app/view/src/common/widgets/overlays/widget_overlay_sale_item.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_image.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_text.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';

/// Visual element specified for product details preview.
///
class GsaWidgetSaleItemPreview extends StatefulWidget {
  // ignore: public_member_api_docs
  const GsaWidgetSaleItemPreview(
    this.saleItem, {
    super.key,
  });

  /// The model represented in this widget preview.
  ///
  final GsaaModelSaleItem saleItem;

  /// Specified widget preview height.
  ///
  static const previewHeight = 270.0;

  @override
  State<GsaWidgetSaleItemPreview> createState() => _GsaWidgetSaleItemPreviewState();
}

class _GsaWidgetSaleItemPreviewState extends State<GsaWidgetSaleItemPreview> {
  late int _cartCount;

  void _setCartCount() {
    _cartCount = GsaDataCheckout.instance.itemCount(widget.saleItem) ?? 0;
  }

  void _onCartCountUpdate() {
    setState(() => _setCartCount());
  }

  late bool _favorited;

  @override
  void initState() {
    super.initState();
    _setCartCount();
    GsaDataCheckout.instance.notifierCartUpdate.addListener(_onCartCountUpdate);
    _favorited = GsaServiceBookmarks.instance.isFavorited(widget.saleItem.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          Card(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2 > 400 ? 400 : MediaQuery.of(context).size.width / 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 16, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: widget.saleItem.imageUrl != null
                                    ? GsaWidgetImage.network(
                                        widget.saleItem.thumbnailUrl!,
                                        width: MediaQuery.of(context).size.width,
                                        height: 100,
                                      )
                                    : GsaWidgetImage.placeholder(
                                        width: MediaQuery.of(context).size.width,
                                        height: 100,
                                      ),
                              ),
                              const Positioned(
                                right: 0,
                                bottom: 0,
                                child: GsaWidgetText(
                                  'Product may differ.',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (widget.saleItem.price?.discount?.eurCents != null)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Text(
                                    '${widget.saleItem.price!.discount!.formatted()} EUR',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.secondary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.saleItem.amountMeasureFormatted != null)
                          GsaWidgetText.rich(
                            [
                              GsaWidgetTextSpan(
                                widget.saleItem.amountMeasureFormatted!,
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        Row(
                          children: [
                            if (widget.saleItem.price?.eurCents != null)
                              Expanded(
                                child: Text(
                                  '${widget.saleItem.price!.formatted()} ${GsaConfig.currency.code}' +
                                      (widget.saleItem.price?.discount?.eurCents != null
                                          ? ' ${widget.saleItem.price!.discount!.formatted()}'
                                          : ''),
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Text(
                          widget.saleItem.name ?? 'N/A',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: OutlinedButton(
                        style: ButtonStyle(
                          side: MaterialStatePropertyAll(
                            BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        child: SizedBox(
                          width: 60,
                          child: widget.saleItem.price == null
                              ? const GsaWidgetText(
                                  'INQUIRE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.shopping_cart),
                                    if (_cartCount > 0)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context).primaryColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '$_cartCount',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                        ),
                        onPressed: () async {
                          GsaDataCheckout.instance.addItem(widget.saleItem);
                          GsaWidgetOverlaySaleItem.open(context, widget.saleItem);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              icon: _favorited
                  ? Icon(
                      Icons.favorite,
                      color: Theme.of(context).primaryColor,
                    )
                  : const Icon(
                      Icons.favorite_outline,
                      color: Colors.grey,
                    ),
              onPressed: () async {
                if (_favorited) {
                  await GsaServiceBookmarks.instance.removeBookmark(widget.saleItem.id ?? '');
                } else {
                  await GsaServiceBookmarks.instance.addBookmark(widget.saleItem.id ?? '');
                }
                setState(() => _favorited = !_favorited);
              },
            ),
          ),
        ],
      ),
      onTap: () async {
        await GsaWidgetOverlaySaleItem.open(context, widget.saleItem);
      },
    );
  }

  @override
  void dispose() {
    GsaDataCheckout.instance.notifierCartUpdate.removeListener(_onCartCountUpdate);
    super.dispose();
  }
}
