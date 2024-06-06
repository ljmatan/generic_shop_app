part of '../route_cart.dart';

class _WidgetCartItem extends StatefulWidget {
  const _WidgetCartItem(
    this.cartItem, {
    super.key,
  });

  final GsaaModelSaleItem cartItem;

  @override
  State<_WidgetCartItem> createState() => __WidgetCartItemState();
}

class __WidgetCartItemState extends State<_WidgetCartItem> {
  late int _cartCount;

  void _setCartCount() {
    _cartCount = GsaDataCheckout.instance.itemCount(widget.cartItem) ?? 0;
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
    final confirmed = await GsaWidgetOverlayConfirmation.open(
      context,
      'Remove ${widget.cartItem.name} from cart?',
    );
    if (confirmed) {
      setState(() => GsaDataCheckout.instance.removeItem(widget.cartItem));
      if (GsaDataCheckout.instance.orderDraft.items.isEmpty) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.cartItem.imageUrl != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.cartItem.imageUrl!,
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
                    if (widget.cartItem.amountMeasureFormatted != null)
                      GsaWidgetText(
                        widget.cartItem.amountMeasureFormatted!,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: widget.cartItem.price?.eurCents != null
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
                                '$_cartCount x ${widget.cartItem.price!.formatted()} ${GsaConfig.currency.code}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              GsaWidgetText(
                                '${(widget.cartItem.price!.eur! * _cartCount).toStringAsFixed(2)} ${GsaConfig.currency.code}',
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
                  SizedBox(
                    width: 30,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () async {
                        await _removeItem();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  for (int i = 0; i < 3; i++)
                    i == 1
                        ? SizedBox(
                            width: 20,
                            child: GsaWidgetText(
                              '$_cartCount',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          )
                        : IconButton(
                            icon: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Icon(
                                  i == 0 ? Icons.remove : Icons.add_circle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            onPressed: i == 0
                                ? () async {
                                    if (_cartCount > 1) {
                                      GsaDataCheckout.instance.decreaseItemCount(widget.cartItem);
                                    } else {
                                      await _removeItem();
                                    }
                                  }
                                : () {
                                    GsaDataCheckout.instance.addItem(widget.cartItem);
                                  },
                          ),
                ],
              ),
            ],
          ),
        ],
      ),
      onTap: () {
        GsaWidgetOverlaySaleItem.open(
          context,
          widget.cartItem,
          displayedFromCart: true,
        );
      },
    );
  }

  @override
  void dispose() {
    GsaDataCheckout.instance.notifierCartUpdate.removeListener(_onCartCountUpdate);
    super.dispose();
  }
}
