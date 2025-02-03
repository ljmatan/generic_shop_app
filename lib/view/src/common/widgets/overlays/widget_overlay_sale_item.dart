import 'package:flutter/material.dart';
import 'package:generic_shop_app/config.dart';
import 'package:generic_shop_app/data/data.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_image.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_text.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_ivancica/view/view.dart';

/// Overlay view displaying sale item details and containing associated cart functionalities.
///
class GsaWidgetOverlaySaleItem extends StatefulWidget {
  const GsaWidgetOverlaySaleItem._(
    this.saleItem, {
    this.displayedFromCart = false,
  });

  /// The sale item represented by this widget.
  ///
  final GsaaModelSaleItem saleItem;

  /// Whether the overlay was displayed from the cart screen.
  ///
  /// If the value is true, the overlay will pop instead of open the cart screen with the cart button.
  ///
  final bool displayedFromCart;

  /// Displays the [GsaWidgetOverlaySaleItem] widget by using the Material [showModalBottomSheet] method.
  ///
  static Future<void> open(
    BuildContext context,
    GsaaModelSaleItem saleItem, {
    bool displayedFromCart = false,
  }) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return GsaWidgetOverlaySaleItem._(
          saleItem,
          displayedFromCart: displayedFromCart,
        );
      },
    );
  }

  @override
  State<GsaWidgetOverlaySaleItem> createState() => _GsaWidgetOverlaySaleItemState();
}

class _GsaWidgetOverlaySaleItemState extends State<GsaWidgetOverlaySaleItem> {
  /// Amount of [this] saleItem in the cart.
  ///
  late int _cartCount;

  @override
  void initState() {
    super.initState();
    _cartCount = GsaDataCheckout.instance.itemCount(widget.saleItem) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(26, 0, 26, 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                widget.saleItem.name ?? 'saleItem Details',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (widget.saleItem.imageUrls?.isNotEmpty == true)
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Center(
                  child: GsaWidgetImage.network(
                    widget.saleItem.imageUrls![0],
                    height: MediaQuery.of(context).size.width * .3,
                  ),
                ),
              ),
            if (widget.saleItem.amountMeasureFormatted != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GsaWidgetText(
                  widget.saleItem.amountMeasureFormatted!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            if (widget.saleItem.description != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Text(
                  widget.saleItem.description!,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  child: const Text(
                    'Additional Info',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    (switch (GsaConfig.provider) {
                      GsaConfigProvider.ivancica => GivRouteSaleItemDetails(widget.saleItem),
                      _ => GsaRouteSaleItemDetails(widget.saleItem),
                    })
                        .push();
                  },
                ),
              ),
            ),
            Row(
              children: [
                if (_cartCount > 0)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: OutlinedButton(
                      child: const Icon(
                        Icons.remove_circle,
                        size: 18,
                      ),
                      onPressed: () {
                        // Set checkout data.
                        GsaDataCheckout.instance.decreaseItemCount(widget.saleItem);
                        // Update the overlay state.
                        setState(() => _cartCount--);
                        // If the cart is empty and cart page is visible,
                        // pop all previously pushed routes.
                        if (GsaDataCheckout.instance.totalItemCount == 0 && widget.displayedFromCart) {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        }
                      },
                    ),
                  ),
                Expanded(
                  child: OutlinedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const GsaWidgetText(
                          'Add to Cart',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        if (_cartCount > 0)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  '$_cartCount',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    onPressed: () {
                      GsaDataCheckout.instance.addItem(widget.saleItem);
                      setState(() => _cartCount++);
                    },
                  ),
                ),
                if (_cartCount > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: OutlinedButton(
                      child: const Icon(
                        Icons.shopping_cart,
                        size: 18,
                      ),
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        if (!widget.displayedFromCart) {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushNamed(context, 'cart');
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
