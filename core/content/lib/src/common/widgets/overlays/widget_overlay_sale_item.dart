import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

/// Overlay view displaying sale item details and containing associated cart functionalities.
///
class GsaWidgetOverlaySaleItem extends GsaWidgetOverlay {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetOverlaySaleItem(
    this.saleItem, {
    super.key,
    this.displayedFromCart = false,
  });

  /// The sale item represented by this widget.
  ///
  final GsaModelSaleItem saleItem;

  /// Whether the overlay was displayed from the cart screen.
  ///
  /// If the value is true, the overlay will pop instead of open the cart screen with the cart button.
  ///
  final bool displayedFromCart;

  @override
  bool get isScrollControlled => true;

  @override
  bool get showDragHandle => true;

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
    _cartCount = GsaDataCheckout.instance.orderDraft.getItemCount(widget.saleItem) ?? 0;
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
              child: GsaWidgetText.rich(
                [
                  if (widget.saleItem.name != null)
                    GsaWidgetTextSpan(
                      widget.saleItem.name!,
                      interpolated: true,
                    )
                  else
                    const GsaWidgetTextSpan(
                      'Sale Item Details',
                    ),
                ],
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (widget.saleItem.imageUrls?.isNotEmpty == true) ...[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: GsaWidgetImage.network(
                    widget.saleItem.imageUrls![0],
                    height: MediaQuery.of(context).size.width * .3,
                  ),
                ),
              ),
              const SizedBox(height: 14),
            ],
            if (widget.saleItem.amountMeasureFormatted != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GsaWidgetText(
                  widget.saleItem.amountMeasureFormatted!,
                  isInterpolated: true,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            if (widget.saleItem.description != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: GsaWidgetText(
                  widget.saleItem.description!.length > 500
                      ? widget.saleItem.description!.substring(0, 500) + '...'
                      : widget.saleItem.description!,
                  isInterpolated: true,
                ),
              ),
            if (GsaConfig.cartEnabled && widget.saleItem.price != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: GsaWidgetButton.text(
                    label: 'Additional Info',
                    onTap: () {
                      Navigator.pop(context);
                      GsaRouteSaleItemDetails(widget.saleItem).push();
                    },
                  ),
                ),
              ),
            if (GsaConfig.cartEnabled && widget.saleItem.price != null)
              Row(
                children: [
                  if (_cartCount > 0)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GsaWidgetButton.outlined(
                        icon: Icons.remove_circle,
                        elementSize: 18,
                        onTap: () {
                          // Set checkout data.
                          GsaDataCheckout.instance.orderDraft.decreaseItemCount(widget.saleItem);
                          // Update the overlay state.
                          setState(() => _cartCount--);
                          // If the cart is empty and cart page is visible,
                          // pop all previously pushed routes.
                          if (GsaDataCheckout.instance.orderDraft.totalItemCount == 0 && widget.displayedFromCart) {
                            Navigator.popUntil(context, (route) => route.isFirst);
                          }
                        },
                      ),
                    ),
                  Expanded(
                    child: GsaWidgetButton.outlined(
                      labelWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GsaWidgetText(
                            'Add to Cart',
                            style: const TextStyle(
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
                                  child: GsaWidgetText(
                                    '$_cartCount',
                                    isInterpolated: true,
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
                      onTap: () {
                        GsaDataCheckout.instance.orderDraft.addItem(
                          saleItem: widget.saleItem,
                        );
                        setState(() => _cartCount++);
                      },
                    ),
                  ),
                  if (_cartCount > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GsaWidgetButton.outlined(
                        icon: Icons.shopping_cart,
                        elementSize: 18,
                        onTap: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          if (!widget.displayedFromCart) {
                            Navigator.popUntil(context, (route) => route.isFirst);
                            const GsaRouteCart().push(context: context);
                          } else {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                ],
              )
            else ...[
              if (GsaConfig.plugin.client == GsaPluginClient.froddoB2c)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Builder(
                    builder: (context) {
                      final sortedOptions = List.from(widget.saleItem.options!)
                        ..sort(
                          (a, b) => (a.price?.centum ?? double.infinity).compareTo(
                            b.price?.centum ?? double.infinity,
                          ),
                        );
                      sortedOptions.removeWhere(
                        (saleItemOption) => saleItemOption.price == null || saleItemOption.name == null,
                      );
                      if (sortedOptions.isEmpty) return const SizedBox();
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: GsaWidgetText.rich(
                              [
                                const GsaWidgetTextSpan(
                                  'Available Sizes',
                                ),
                                const GsaWidgetTextSpan(
                                  ': ',
                                  interpolated: true,
                                ),
                                GsaWidgetTextSpan(
                                  sortedOptions.length > 1
                                      ? '${sortedOptions[0].name!} - ${sortedOptions.last.name}'
                                      : sortedOptions[0].name!,
                                  interpolated: true,
                                ),
                              ],
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: GsaWidgetButton.outlined(
                  label: 'See Available Options',
                  onTap: () {
                    Navigator.pop(context);
                    GsaRouteSaleItemDetails(widget.saleItem).push();
                  },
                ),
              ),
            ],
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
