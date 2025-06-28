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
  State<_WidgetHeader> createState() => _WidgetHeaderState();
}

class _WidgetHeaderState extends State<_WidgetHeader> {
  void _openDrawer() {
    if (MediaQuery.of(context).size.width < 1000) {
      Scaffold.of(context).openDrawer();
    } else {
      Scaffold.of(context).openEndDrawer();
    }
  }

  void _openCartPage() {
    if (GsaDataCheckout.instance.orderDraft.items.isEmpty) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (context) {
          return const _WidgetHeaderOverlayEmptyCart();
        },
      );
    } else {
      const GsaRouteCart().push();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: GsaWidgetAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: MediaQuery.of(context).size.width < 1000
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
                            IconButton.filled(
                              icon: Icon(
                                Navigator.of(context).canPop() ? Icons.chevron_left : Icons.menu,
                                color: Theme.of(context).primaryColor,
                              ),
                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.white,
                                ),
                              ),
                              onPressed: Navigator.of(context).canPop()
                                  ? () {
                                      Navigator.pop(context);
                                    }
                                  : () {
                                      _openDrawer();
                                    },
                            ),
                            IconButton.filled(
                              icon: Icon(
                                GsaConfig.cartEnabled ? Icons.shopping_cart : Icons.favorite,
                                color: Theme.of(context).primaryColor,
                              ),
                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.white,
                                ),
                              ),
                              onPressed: GsaConfig.cartEnabled
                                  ? () {
                                      _openCartPage();
                                    }
                                  : () {
                                      const GsaRouteBookmarks().push();
                                    },
                            ),
                          ],
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: ValueListenableBuilder(
                            valueListenable: GsaConfig.cartEnabled
                                ? GsaDataCheckout.instance.notifierCartUpdate
                                : GsaServiceBookmarks.instance.notifierBookmarkCount,
                            builder: (context, cartItemCount, child) {
                              if (cartItemCount == 0) return const SizedBox();
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black12,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: GsaWidgetText(
                                    '$cartItemCount',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.secondary,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GsaWidgetTextField(
                      controller: widget.searchTermController,
                      focusNode: widget.searchTermFocusNode,
                      hintText: 'Search'.translated(context),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
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
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey,
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
                                    hintText: 'Search'.translated(context),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                IconButton.filled(
                                  icon: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      children: [
                                        const GsaWidgetText(
                                          'Cart',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Icon(
                                          GsaConfig.cartEnabled ? Icons.shopping_cart : Icons.favorite,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: GsaConfig.cartEnabled
                                      ? () {
                                          _openCartPage();
                                        }
                                      : () {
                                          const GsaRouteBookmarks().push();
                                        },
                                ),
                                const SizedBox(width: 16),
                                IconButton.filled(
                                  icon: const Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => _openDrawer(),
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

class _WidgetHeaderOverlayEmptyCart extends StatelessWidget {
  const _WidgetHeaderOverlayEmptyCart();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(26, 0, 26, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Flexible(
            child: GsaWidgetText(
              'No items added to the cart.',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 20),
          GsaWidgetText(
            'Your cart is looking a bit empty right now. Take your time browsing through our selection '
            'and when you find something you love, just click "Add to Cart" to bring a little joy '
            'into your shopping experience!',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: OutlinedButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GsaWidgetText('OK'),
              ),
              onPressed: () => Navigator.pop(context),
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
