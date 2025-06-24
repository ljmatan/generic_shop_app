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
        ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: widget.results.length,
          itemBuilder: (context, index) {
            final saleItem = widget.results[index];
            final cartCount = GsaDataCheckout.instance.itemCount(saleItem);
            return Padding(
              padding: index == 0 ? EdgeInsets.zero : const EdgeInsets.only(top: 12),
              child: InkWell(
                child: Card(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (saleItem.imageUrls?.isNotEmpty == true)
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: GsaWidgetImage.network(
                                    saleItem.imageUrls![0],
                                    width: 60,
                                    height: 70,
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
                                      saleItem.name ?? 'N/A',
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (saleItem.amountMeasureFormatted != null)
                                          GsaWidgetText(
                                            saleItem.amountMeasureFormatted!,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                            ),
                                          ),
                                        GsaWidgetText(
                                          saleItem.price?.formatted() ?? 'N/A',
                                          maxLines: 2,
                                          style: const TextStyle(
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
                      ),
                      Positioned(
                        right: 4,
                        bottom: 4,
                        child: TextButton(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.shopping_cart,
                                size: 18,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: cartCount != null && cartCount > 0
                                    ? DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: GsaWidgetText(
                                            '$cartCount',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      )
                                    : GsaWidgetText(
                                        'ADD',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            if (GsaConfig.plugin.addToCart != null) {
                              await GsaConfig.plugin.addToCart!(
                                context,
                                item: saleItem,
                              );
                            } else {
                              debugPrint('GsaConfig.plugin.addToCart not defined.');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  GsaWidgetOverlaySaleItem(saleItem).openBottomSheet(context);
                },
              ),
            );
          },
        ),
        Positioned(
          right: 16,
          bottom: 16 + MediaQuery.of(context).padding.bottom,
          child: FloatingActionButton.extended(
            heroTag: null,
            label: const Icon(Icons.tune),
            icon: const GsaWidgetText('Filters'),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              FocusScope.of(context).unfocus();
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                showDragHandle: true,
                builder: (context) {
                  return const Padding(
                    padding: EdgeInsets.fromLTRB(26, 0, 26, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: GsaWidgetText(
                            'Filters',
                            style: TextStyle(
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
