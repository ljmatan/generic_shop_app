part of '../route_shop.dart';

class _WidgetSearchResults extends StatefulWidget {
  const _WidgetSearchResults(this.results);

  final List<GsaModelSaleItem> results;

  @override
  State<_WidgetSearchResults> createState() => _WidgetSearchResultsState();
}

class _WidgetSearchResultsState extends State<_WidgetSearchResults> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (Theme.of(context).dimensions.smallScreen)
          ListView.builder(
            padding: Theme.of(context).paddings.listView(),
            itemCount: widget.results.length,
            itemBuilder: (context, index) {
              final saleItem = widget.results[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (index != 0) const SizedBox(height: 12),
                  _WidgetSearchResultsEntry(
                    saleItem: saleItem,
                  ),
                ],
              );
            },
          )
        else
          GridView.builder(
            padding: Theme.of(context).paddings.listView(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width < 1400 ? 3 : 4,
              mainAxisExtent: 160,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: widget.results.length,
            itemBuilder: (context, index) {
              final saleItem = widget.results[index];
              return _WidgetSearchResultsEntry(
                saleItem: saleItem,
              );
            },
          ),
        Positioned(
          right: 16,
          bottom: 16 + MediaQuery.of(context).padding.bottom,
          child: GsaWidgetButton.filled(
            label: 'Filters',
            icon: Icons.tune,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              FocusScope.of(context).unfocus();
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                showDragHandle: true,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(26, 0, 26, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: GsaWidgetText(
                            'Filters',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _WidgetSearchResultsEntry extends StatefulWidget {
  const _WidgetSearchResultsEntry({
    required this.saleItem,
  });

  final GsaModelSaleItem saleItem;

  @override
  State<_WidgetSearchResultsEntry> createState() => _WidgetSearchResultsEntryState();
}

class _WidgetSearchResultsEntryState extends State<_WidgetSearchResultsEntry> {
  late int? _cartCount;

  @override
  void initState() {
    super.initState();
    _cartCount = widget.saleItem.cartCountWithOptions();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.saleItem.imageUrls?.isNotEmpty == true)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: GsaWidgetImage.network(
                          widget.saleItem.imageUrls![0],
                          width: 60,
                          height: 70,
                          cached: true,
                        ),
                      ),
                    ),
                  Flexible(
                    child: SizedBox(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GsaWidgetText(
                            widget.saleItem.name ?? 'N/A',
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.saleItem.amountMeasureFormatted != null)
                                GsaWidgetText(
                                  widget.saleItem.amountMeasureFormatted!,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              if (widget.saleItem.price?.formatted != null || widget.saleItem.startingOptionPriceFormatted() != null)
                                GsaWidgetText(
                                  widget.saleItem.price?.formatted ?? widget.saleItem.startingOptionPriceFormatted()!,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: widget.saleItem.price?.formatted == null ? Colors.grey : null,
                                    fontSize: 12,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 48,
                child: GsaWidgetButton.filled(
                  label: 'Add to Cart' + (_cartCount != null && _cartCount! > 0 ? ' ($_cartCount)' : ''),
                  icon: Icons.shopping_cart,
                  onTap: () async {
                    if (GsaPlugin.of(context).api?.addToCart != null) {
                      await GsaPlugin.of(context).api!.addToCart!(
                        context,
                        item: widget.saleItem,
                      );
                    } else {
                      debugPrint('GsaPlugin.of(context).addToCart not defined.');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        GsaWidgetOverlaySaleItem(widget.saleItem).openBottomSheet();
      },
    );
  }
}
