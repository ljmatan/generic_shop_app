import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

/// Screen displaying user bookmark list (or wishlist), enabling further processing options.
///
class GsaRouteBookmarks extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteBookmarks({super.key});

  @override
  State<GsaRouteBookmarks> createState() => _GsaRouteBookmarksState();
}

class _GsaRouteBookmarksState extends GsaRouteState<GsaRouteBookmarks> {
  late StreamSubscription _subscriptionBookmarkUpdates;

  @override
  void initState() {
    super.initState();
    _subscriptionBookmarkUpdates = GsaServiceBookmarks.instance.controllerUpdate.stream.listen(
      (_) {
        setState(() {});
      },
    );
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GsaWidgetAppBar(
            label: widget.displayName,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              children: [
                GsaWidgetText(
                  'Your Wishlist',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Divider(height: 32),
                GsaWidgetText(
                  'A selection of your hand-picked favorites, waiting for the perfect moment. '
                  'Keep track of what inspires you, and be the first to know about restocks, exclusive offers, and price drops.',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const Divider(height: 32),
                if (GsaServiceBookmarks.instance.bookmarks.isEmpty)
                  GsaWidgetText(
                    'No items found.',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  )
                else
                  for (final bookmarkId in GsaServiceBookmarks.instance.bookmarks)
                    Builder(
                      builder: (context) {
                        final item = GsaDataSaleItems.instance.collection.firstWhereOrNull((saleItem) => saleItem.id == bookmarkId);
                        if (item == null) return const SizedBox();
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: InkWell(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 18,
                                ),
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        if (item.imageUrls?.isNotEmpty == true)
                                          Padding(
                                            padding: const EdgeInsets.only(right: 10),
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(
                                                  width: 2,
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(2),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: GsaWidgetImage.network(
                                                    item.imageUrls![0],
                                                    width: 80,
                                                    height: 80,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              if (item.name != null)
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 4),
                                                  child: GsaWidgetText(
                                                    item.name!,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              if (GsaConfig.plugin.client == GsaPluginClient.froddoB2c && item.options?.isNotEmpty == true)
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 2),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final sortedOptions = List.from(item.options!)
                                                        ..sort(
                                                          (a, b) => (a.price?.centum ?? double.infinity).compareTo(
                                                            b.price?.centum ?? double.infinity,
                                                          ),
                                                        );
                                                      sortedOptions.removeWhere(
                                                        (saleItemOption) => saleItemOption.price == null || saleItemOption.name == null,
                                                      );
                                                      if (sortedOptions.isEmpty) return const SizedBox();
                                                      return GsaWidgetText(
                                                        'Sizes: ' +
                                                            (sortedOptions.length > 1
                                                                ? '${sortedOptions[0].name!} - ${sortedOptions.last.name}'
                                                                : sortedOptions[0].name!),
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              if (item.price?.centum != null)
                                                GsaWidgetText(
                                                  '${item.price!.formatted}' +
                                                      (item.price?.discount?.centum != null ? ' ${item.price!.discount!.formatted}' : ''),
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                )
                                              else if (item.options?.any((saleItemOption) => saleItemOption.price?.centum != null) == true)
                                                GsaWidgetText.rich(
                                                  [
                                                    const GsaWidgetTextSpan(
                                                      'From ',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    GsaWidgetTextSpan(
                                                      item.startingOptionPriceFormatted() ?? 'N/A',
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: Icon(
                                        Icons.info_outline,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              GsaRouteSaleItemDetails(item).push();
                            },
                          ),
                        );
                      },
                    )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _subscriptionBookmarkUpdates.cancel();
    super.dispose();
  }
}
