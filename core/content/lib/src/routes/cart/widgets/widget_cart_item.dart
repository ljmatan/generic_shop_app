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
                      GsaWidgetText(
                        widget.cartItem.productCode!,
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
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        Icons.close,
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
          for (final purchaseOption in <GsaModelSaleItem>{
            widget.cartItem,
            if (widget.cartItem.options?.isNotEmpty == true) ...widget.cartItem.options!,
          }.indexed)
            _WidgetCartItemAmountSpecification(
              index: purchaseOption.$1,
              optionIndex: purchaseOption.$1 == 0 ? null : purchaseOption.$1 - 1,
              cartItem: widget.cartItem,
              saleItem: purchaseOption.$2,
            ),
        ],
      ),
      onTap: () {
        GsaRouteSaleItemDetails(
          widget.cartItem,
        ).push();
      },
    );
  }

  @override
  void dispose() {
    GsaDataCheckout.instance.notifierCartUpdate.removeListener(_onCartCountUpdate);
    super.dispose();
  }
}

class _WidgetCartItemAmountSpecification extends StatefulWidget {
  const _WidgetCartItemAmountSpecification({
    required this.index,
    required this.optionIndex,
    required this.cartItem,
    required this.saleItem,
  });

  final int index;

  final int? optionIndex;

  final GsaModelSaleItem cartItem, saleItem;

  @override
  State<_WidgetCartItemAmountSpecification> createState() {
    return __WidgetCartItemAmountSpecificationState();
  }
}

class __WidgetCartItemAmountSpecificationState extends State<_WidgetCartItemAmountSpecification> {
  int? _cartCount;

  void _setCartCount() {
    _cartCount = widget.saleItem.cartCount();
  }

  void _onCartUpdate() {
    setState(() {
      _setCartCount();
    });
  }

  @override
  void initState() {
    super.initState();
    _setCartCount();
  }

  @override
  Widget build(BuildContext context) {
    if (_cartCount == null) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.index != 0) const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: widget.saleItem.price?.centum != null
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
                              switch (GsaConfig.plugin.client) {
                                    GsaClient.froddoB2b => 'Size ',
                                    _ => '',
                                  } +
                                  '${widget.saleItem.productCode}',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 2),
                            GsaWidgetText(
                              '$_cartCount x ${widget.saleItem.price!.formatted} '
                              '${GsaConfig.currency.code}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            GsaWidgetText(
                              '${(widget.saleItem.price!.unity! * _cartCount!).toStringAsFixed(2)} '
                              '${GsaConfig.currency.code}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
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
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).dividerColor,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: SizedBox(
                                height: 38,
                                child: Center(
                                  child: GsaWidgetText(
                                    '$_cartCount',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
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
                              ),
                            ),
                          ),
                          onTap: i == 0
                              ? () async {
                                  try {
                                    if (widget.optionIndex == null) {
                                      GsaDataCheckout.instance.orderDraft.decreaseItemCount(
                                        widget.cartItem,
                                      );
                                    } else {
                                      GsaDataCheckout.instance.orderDraft.decreaseItemOptionCount(
                                        saleItem: widget.cartItem,
                                        optionIndex: widget.optionIndex!,
                                      );
                                    }
                                    _onCartUpdate();
                                  } catch (e) {
                                    GsaWidgetOverlayAlert(
                                      '$e',
                                    ).openDialog();
                                  }
                                }
                              : () {
                                  try {
                                    if (widget.optionIndex == null) {
                                      GsaDataCheckout.instance.orderDraft.addItem(
                                        saleItem: widget.cartItem,
                                      );
                                    } else {
                                      GsaDataCheckout.instance.orderDraft.addItemOption(
                                        saleItem: widget.cartItem,
                                        optionIndex: widget.optionIndex!,
                                      );
                                    }
                                    _onCartUpdate();
                                  } catch (e) {
                                    GsaWidgetOverlayAlert(
                                      '$e',
                                    ).openDialog();
                                  }
                                },
                        ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
