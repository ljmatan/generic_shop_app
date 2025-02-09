import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_data/data.dart';
import 'package:generic_shop_app_services/services.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GsaWidgetText(
          widget.displayName,
        ),
      ),
      body: ListView(
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
          const GsaWidgetText(
            'A selection of your hand-picked favorites, waiting for the perfect moment. '
            'Keep track of what inspires you, and be the first to know about restocks, exclusive offers, and price drops.',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          const Divider(height: 32),
          if (GsaServiceBookmarks.instance.bookmarks.isEmpty)
            const Text(
              'No items found.',
              style: TextStyle(
                color: Colors.grey,
              ),
            )
          else
            for (final bookmarkId in GsaServiceBookmarks.instance.bookmarks)
              Builder(
                builder: (context) {
                  final item = GsaDataSaleItems.instance.products.firstWhereOrNull((saleItem) => saleItem.id == bookmarkId);
                  if (item == null) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 20,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (item.imageUrls?.isNotEmpty == true)
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).colorScheme.tertiary,
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
                            if (item.name != null)
                              Text(
                                item.name!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
        ],
      ),
    );
  }
}
