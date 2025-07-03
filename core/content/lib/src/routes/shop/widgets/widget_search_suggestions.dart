part of '../route_shop.dart';

class _WidgetSearchSuggestions extends StatefulWidget {
  const _WidgetSearchSuggestions();

  @override
  State<_WidgetSearchSuggestions> createState() => _WidgetSearchSuggestionsState();
}

class _WidgetSearchSuggestionsState extends State<_WidgetSearchSuggestions> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: GsaWidgetText(
            'Minimum of 3 characters required for search',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: InkWell(
            child: Card(
              child: Padding(
                padding: Theme.of(context).cardPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: GsaWidgetText(
                        'View Your Favorites',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              const GsaRouteBookmarks().push(
                context: context,
              );
            },
          ),
        ),
        if (GsaDataSaleItems.instance.categories.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GsaWidgetText(
                    'Filter products by categories',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 48,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      for (final category in GsaDataSaleItems.instance.categories.indexed)
                        Padding(
                          padding: category.$1 == 0 ? EdgeInsets.zero : const EdgeInsets.only(left: 10),
                          child: FilledButton(
                            child: GsaWidgetText(
                              category.$2.name ?? 'N/A',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: Colors.grey.withOpacity(.2),
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GsaWidgetHeadline('Search History'),
                if ((GsaServiceCacheEntry.shopSearchHistory.value as Iterable?)?.isNotEmpty != true)
                  const GsaWidgetText(
                    'No search history',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                else
                  for (final searchHistoryEntry in (GsaServiceCacheEntry.shopSearchHistory.value as Iterable).indexed) ...[
                    Row(
                      children: [
                        Expanded(
                          child: GsaWidgetText(
                            searchHistoryEntry.$2,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            // TODO
                          },
                        ),
                      ],
                    ),
                  ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
