part of '../route_shop.dart';

class _WidgetSearchSuggestions extends StatefulWidget {
  const _WidgetSearchSuggestions({
    required this.updateSearchTerm,
  });

  final Function(String value) updateSearchTerm;

  @override
  State<_WidgetSearchSuggestions> createState() => _WidgetSearchSuggestionsState();
}

class _WidgetSearchSuggestionsState extends State<_WidgetSearchSuggestions> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GsaWidgetText(
            'Minimum of 3 characters required for search.',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
        if (GsaPlugin.of(context).features.bookmarks) ...[
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              child: Card(
                child: Padding(
                  padding: GsaTheme.of(context).paddings.card(),
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
        ],
        if (GsaDataSaleItems.instance.categories.isNotEmpty) ...[
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GsaWidgetText(
                  'Filter products by categories',
                  style: const TextStyle(
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
                        child: GsaWidgetButton.filled(
                          label: category.$2.name ?? 'N/A',
                          onTap: () {
                            // TODO.
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GsaWidgetHeadline('Search History'),
                if ((GsaServiceCacheEntry.shopSearchHistory.value as Iterable?)?.isNotEmpty != true)
                  GsaWidgetText(
                    'No search history',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  )
                else
                  for (final searchHistoryEntry in (GsaServiceCacheEntry.shopSearchHistory.value as Iterable).indexed) ...[
                    InkWell(
                      child: Row(
                        children: [
                          Expanded(
                            child: GsaWidgetText(
                              searchHistoryEntry.$2,
                            ),
                          ),
                          GsaWidgetButton.icon(
                            icon: Icons.close,
                            onTap: () async {
                              final searchTerms = (GsaServiceCacheEntry.shopSearchHistory.value as Iterable).toList();
                              searchTerms.remove(searchHistoryEntry.$2);
                              try {
                                await GsaServiceCacheEntry.shopSearchHistory.setValue(
                                  searchTerms.toSet(),
                                );
                              } catch (e) {
                                GsaServiceLogging.instance.logError(
                                  'Couldn\'t update search term history:\n$e',
                                );
                              }
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        widget.updateSearchTerm(searchHistoryEntry.$2);
                      },
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
