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
  State<_WidgetHeader> createState() => __WidgetHeaderState();
}

class __WidgetHeaderState extends State<_WidgetHeader> {
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
      GsaRouteCart().push();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade100,
            ),
          ),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: MediaQuery.of(context).size.width < 1000
                  ? [
                      SizedBox(height: MediaQuery.of(context).padding.top),
                      SizedBox(
                        height: kToolbarHeight,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            GsaWidgetLogo(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.menu,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(maxWidth: 36, maxHeight: 36),
                                  onPressed: () => _openDrawer(),
                                ),
                                IconButton(
                                  icon: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Icon(
                                          Icons.shopping_cart,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(maxWidth: 36, maxHeight: 36),
                                  onPressed: () => _openCartPage(),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: ValueListenableBuilder(
                                valueListenable: GsaDataCheckout.instance.notifierCartUpdate,
                                builder: (context, cartItemCount, child) {
                                  if (cartItemCount == 0) return const SizedBox();
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black12,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Text(
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 14),
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
                    ]
                  : [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
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
                                    circularCorners: true,
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                IconButton.outlined(
                                  icon: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      children: [
                                        GsaWidgetText(
                                          'Cart',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () => _openCartPage,
                                ),
                                const SizedBox(width: 16),
                                IconButton.outlined(
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
                    ],
            ),
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
            child: Text(
              'No items added to the cart.',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
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
                child: Text('OK'),
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
