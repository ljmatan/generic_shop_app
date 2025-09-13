part of '../route_shop.dart';

class _WidgetHeader extends StatefulWidget {
  const _WidgetHeader({
    required this.searchTermController,
    required this.searchTermFocusNode,
    required this.clearSearchFilters,
  });

  final TextEditingController searchTermController;

  final FocusNode searchTermFocusNode;

  final Function clearSearchFilters;

  @override
  State<_WidgetHeader> createState() {
    return _WidgetHeaderState();
  }
}

class _WidgetHeaderState extends State<_WidgetHeader> {
  bool? _canPop;

  void _openDrawer() {
    if (GsaTheme.of(context).dimensions.smallScreen) {
      Scaffold.of(context).openDrawer();
    } else {
      Scaffold.of(context).openEndDrawer();
    }
  }

  void _openCartPage() {
    if (GsaDataCheckout.instance.orderDraft.items.isEmpty) {
      const _WidgetHeaderOverlayEmptyCart().openBottomSheet();
    } else {
      const GsaRouteCart().push();
    }
  }

  @override
  Widget build(BuildContext context) {
    _canPop ??= Navigator.of(context).canPop();
    return InkWell(
      child: GsaWidgetAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: GsaTheme.of(context).dimensions.smallScreen
                ? [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        GsaWidgetLogo(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GsaWidgetButton.filled(
                              icon: _canPop == true ? Icons.chevron_left : Icons.menu,
                              backgroundColor: Colors.white,
                              foregroundColor: Theme.of(context).primaryColor,
                              onTap: _canPop == true
                                  ? () {
                                      Navigator.pop(context);
                                    }
                                  : () {
                                      _openDrawer();
                                    },
                            ),
                            GsaWidgetButton.filled(
                              icon: GsaPlugin.of(context).features.cart ? Icons.shopping_cart : Icons.favorite,
                              backgroundColor: Colors.white,
                              foregroundColor: Theme.of(context).primaryColor,
                              onTap: GsaPlugin.of(context).features.cart
                                  ? () {
                                      _openCartPage();
                                    }
                                  : () {
                                      const GsaRouteBookmarks().push();
                                    },
                            ),
                          ],
                        ),
                        const _WidgetHeaderCartButtonCount(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GsaWidgetTextField(
                      controller: widget.searchTermController,
                      focusNode: widget.searchTermFocusNode,
                      hintText: 'Search',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).brightness == Brightness.light ? Theme.of(context).primaryColor : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 14),
                  ]
                : [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            if (_canPop == true) ...[
                              GsaWidgetButton.filled(
                                icon: Icons.chevron_left,
                                backgroundColor: Colors.white,
                                foregroundColor: Theme.of(context).primaryColor,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              const SizedBox(width: 10),
                            ],
                            if (!<GsaPluginClient>{
                              GsaPluginClient.froddoB2b,
                            }.contains(GsaPlugin.of(context).client))
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            const Spacer(),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: GsaWidgetTextField(
                                    controller: widget.searchTermController,
                                    focusNode: widget.searchTermFocusNode,
                                    hintText: 'Search',
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color:
                                          Theme.of(context).brightness == Brightness.light ? Theme.of(context).primaryColor : Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    GsaWidgetButton.filled(
                                      label: 'Cart',
                                      icon: GsaPlugin.of(context).features.cart ? Icons.shopping_cart : Icons.favorite,
                                      backgroundColor: Colors.white,
                                      foregroundColor: Theme.of(context).primaryColor,
                                      onTap: GsaPlugin.of(context).features.cart
                                          ? () {
                                              _openCartPage();
                                            }
                                          : () {
                                              const GsaRouteBookmarks().push();
                                            },
                                    ),
                                    const _WidgetHeaderCartButtonCount(),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                GsaWidgetButton.filled(
                                  icon: Icons.menu,
                                  foregroundColor: Colors.white,
                                  onTap: () {
                                    _openDrawer();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
          ),
        ),
      ),
      onTap: () => widget.clearSearchFilters(),
    );
  }
}

class _WidgetHeaderCartButtonCount extends StatelessWidget {
  const _WidgetHeaderCartButtonCount();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: IgnorePointer(
        child: ValueListenableBuilder(
          valueListenable: GsaPlugin.of(context).features.cart
              ? GsaDataCheckout.instance.notifierCartUpdate
              : GsaServiceBookmarks.instance.notifierBookmarkCount,
          builder: (context, cartItemCount, child) {
            if (cartItemCount == 0) return const SizedBox();
            return Transform.translate(
              offset: const Offset(5, -10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  child: GsaWidgetText(
                    '$cartItemCount',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WidgetHeaderOverlayEmptyCart extends GsaWidgetOverlay {
  const _WidgetHeaderOverlayEmptyCart();

  @override
  bool get isScrollControlled => true;

  @override
  State<_WidgetHeaderOverlayEmptyCart> createState() {
    return _WidgetHeaderOverlayEmptyCartState();
  }
}

class _WidgetHeaderOverlayEmptyCartState extends State<_WidgetHeaderOverlayEmptyCart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(26, 20, 26, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: GsaWidgetText(
              'No items added to the cart.',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 20),
          GsaWidgetText(
            'Your cart is looking a bit empty right now. '
            'Take your time browsing through our selection '
            'and when you find something you love, '
            'just click "Add to Cart" to bring a little joy '
            'into your shopping experience!',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: GsaWidgetButton.outlined(
              label: 'OK',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }
}
