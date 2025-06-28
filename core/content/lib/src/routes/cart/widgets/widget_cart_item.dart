part of '../route_cart.dart';

class _WidgetCartItem extends StatefulWidget {
  const _WidgetCartItem(
    this.cartItem, {
    super.key,
  });

  final GsaModelSaleItem cartItem;

  @override
  State<_WidgetCartItem> createState() => _WidgetCartItemState();
}

class _WidgetCartItemState extends State<_WidgetCartItem> {
  late int _cartCount;

  void _setCartCount() {
    _cartCount = GsaDataCheckout.instance.orderDraft.getItemCount(widget.cartItem) ?? 0;
  }

  void _onCartCountUpdate() {
    setState(() => _setCartCount());
  }

  @override
  void initState() {
    super.initState();
    _setCartCount();
    GsaDataCheckout.instance.notifierCartUpdate.addListener(_onCartCountUpdate);
  }

  Future<void> _removeItem() async {
    final confirmed = await GsaWidgetOverlayConfirmation(
      'Remove "${widget.cartItem.name}" from cart?',
    ).openDialog();
    if (confirmed == true) {
      GsaDataCheckout.instance.orderDraft.removeItem(widget.cartItem);
      if (GsaDataCheckout.instance.orderDraft.items.isEmpty) {
        Navigator.pop(GsaRoute.navigatorKey.currentContext ?? context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.cartItem.imageUrls?.isNotEmpty == true) ...[
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.cartItem.imageUrls![0],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GsaWidgetText(
                      widget.cartItem.name ?? 'N/A',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    if (widget.cartItem.productCode != null) ...[
                      const SizedBox(height: 4),
                      GsaWidgetText.rich(
                        [
                          GsaWidgetTextSpan(
                            switch (GsaConfig.plugin.client) {
                              GsaClient.froddoB2b => 'Size ',
                              _ => '',
                            },
                          ),
                          GsaWidgetTextSpan(
                            widget.cartItem.productCode!,
                          ),
                        ],
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ],
                    if (widget.cartItem.amountMeasureFormatted != null) ...[
                      const SizedBox(height: 4),
                      GsaWidgetText(
                        widget.cartItem.amountMeasureFormatted!,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(
                child: InkWell(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () async {
                    await _removeItem();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: widget.cartItem.price?.centum != null
                    ? DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GsaWidgetText(
                                '$_cartCount x ${widget.cartItem.price!.formatted()} '
                                '${GsaConfig.currency.code}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              GsaWidgetText(
                                '${(widget.cartItem.price!.unity! * _cartCount).toStringAsFixed(2)} '
                                '${GsaConfig.currency.code}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < 3; i++)
                    i == 1
                        ? SizedBox(
                            width: 40,
                            child: GsaWidgetText(
                              '$_cartCount',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          )
                        : InkWell(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Icon(
                                  i == 0 ? Icons.remove : Icons.add_circle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            onTap: i == 0
                                ? () async {
                                    if (_cartCount > 1) {
                                      GsaDataCheckout.instance.orderDraft.decreaseItemCount(
                                        widget.cartItem,
                                      );
                                    } else {
                                      await _removeItem();
                                    }
                                  }
                                : () {
                                    GsaDataCheckout.instance.orderDraft.addItem(
                                      widget.cartItem,
                                    );
                                  },
                          ),
                ],
              ),
            ],
          ),
        ],
      ),
      onTap: () {
        GsaWidgetOverlaySaleItem(
          widget.cartItem,
          displayedFromCart: true,
        ).openBottomSheet();
      },
    );
  }

  @override
  void dispose() {
    GsaDataCheckout.instance.notifierCartUpdate.removeListener(_onCartCountUpdate);
    super.dispose();
  }
}
