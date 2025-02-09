import 'package:flutter/material.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_data/data.dart';
import 'package:generic_shop_app_services/services.dart';

/// Visual element specified for product details preview.
///
class GsaWidgetSaleItemPreview extends StatefulWidget {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetSaleItemPreview(
    this.saleItem, {
    super.key,
  });

  /// The model represented in this widget preview.
  ///
  final GsaModelSaleItem saleItem;

  /// Specified widget preview height.
  ///
  static final previewHeight = 270.0 - (GsaConfig.cartEnabled ? 0 : 80);

  @override
  State<GsaWidgetSaleItemPreview> createState() => _GsaWidgetSaleItemPreviewState();
}

class _GsaWidgetSaleItemPreviewState extends State<GsaWidgetSaleItemPreview> {
  late int _cartCount;

  void _setCartCount() {
    _cartCount = GsaDataCheckout.instance.itemCount(widget.saleItem) ?? 0;
  }

  void _onCartCountUpdate() {
    setState(() => _setCartCount());
  }

  late bool _favorited;

  @override
  void initState() {
    super.initState();
    _setCartCount();
    GsaDataCheckout.instance.notifierCartUpdate.addListener(_onCartCountUpdate);
    _favorited = GsaServiceBookmarks.instance.isFavorited(widget.saleItem.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          Card(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2 > 400 ? 400 : MediaQuery.of(context).size.width / 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: widget.saleItem.imageUrls?.isNotEmpty == true || widget.saleItem.thumbnailUrls?.isNotEmpty == true
                                    ? GsaWidgetImage.network(
                                        (widget.saleItem.imageUrls?.isNotEmpty == true
                                            ? widget.saleItem.imageUrls
                                            : widget.saleItem.thumbnailUrls)![0],
                                        width: MediaQuery.of(context).size.width,
                                        height: 100,
                                      )
                                    : GsaWidgetImage.placeholder(
                                        width: MediaQuery.of(context).size.width,
                                        height: 100,
                                      ),
                              ),
                              Positioned(
                                right: 4,
                                bottom: 4,
                                child: GsaWidgetText(
                                  'ILLUSTRATION IMAGE\nActual product may vary.',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                    fontSize: 8,
                                    shadows: [
                                      for (final offset in <Offset>{
                                        const Offset(-.5, -.5),
                                        const Offset(.5, -.5),
                                        const Offset(.5, .5),
                                        const Offset(-.5, .5),
                                      })
                                        Shadow(
                                          offset: offset,
                                          color: Colors.white,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (widget.saleItem.price?.discount?.centum != null)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: GsaWidgetText(
                                    '${widget.saleItem.price!.discount!.formatted()} EUR',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.secondary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.saleItem.amountMeasureFormatted != null)
                          GsaWidgetText.rich(
                            [
                              GsaWidgetTextSpan(
                                widget.saleItem.amountMeasureFormatted!,
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        GsaWidgetText(
                          widget.saleItem.name ?? 'N/A',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (GsaConfig.cartEnabled && widget.saleItem.price?.centum != null)
                          GsaWidgetText(
                            '${widget.saleItem.price!.formatted()}' +
                                (widget.saleItem.price?.discount?.centum != null ? ' ${widget.saleItem.price!.discount!.formatted()}' : ''),
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        else if (GsaConfig.cartEnabled &&
                            widget.saleItem.options?.any((saleItemOption) => saleItemOption.price?.centum != null) == true)
                          GsaWidgetText.rich(
                            [
                              const GsaWidgetTextSpan(
                                'From ',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              GsaWidgetTextSpan(
                                (List.from(widget.saleItem.options!)
                                      ..sort(
                                        (a, b) => (a.price?.centum ?? double.infinity).compareTo(
                                          b.price?.centum ?? double.infinity,
                                        ),
                                      ))[0]
                                    .price!
                                    .formatted()!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        if (GsaConfig.provider == GsaConfigProvider.ivancica && widget.saleItem.options?.isNotEmpty == true)
                          Builder(
                            builder: (context) {
                              final sortedOptions = List.from(widget.saleItem.options!)
                                ..sort(
                                  (a, b) => (a.price?.centum ?? double.infinity).compareTo(
                                    b.price?.centum ?? double.infinity,
                                  ),
                                );
                              sortedOptions.removeWhere(
                                (saleItemOption) => saleItemOption.price == null || saleItemOption.name == null,
                              );
                              if (sortedOptions.isEmpty) return const SizedBox();
                              return Text(
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
                      ],
                    ),
                    if (GsaConfig.cartEnabled)
                      Center(
                        child: OutlinedButton(
                          style: ButtonStyle(
                            side: WidgetStatePropertyAll(
                              BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          child: SizedBox(
                            width: 60,
                            child: widget.saleItem.price == null &&
                                    widget.saleItem.options?.where((saleItemOption) => saleItemOption.price != null).isNotEmpty != true
                                ? const GsaWidgetText(
                                    'INQUIRE',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.shopping_cart),
                                      if (_cartCount > 0)
                                        Padding(
                                          padding: const EdgeInsets.only(left: 6),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: GsaWidgetText(
                                                '$_cartCount',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                          ),
                          onPressed: () async {
                            if (widget.saleItem.price != null) {
                              GsaDataCheckout.instance.addItem(widget.saleItem);
                              GsaWidgetOverlaySaleItem.open(context, widget.saleItem);
                            } else {
                              (switch (GsaConfig.provider) {
                                GsaConfigProvider.ivancica => GivRouteSaleItemDetails(widget.saleItem),
                                _ => GsaRouteSaleItemDetails(widget.saleItem),
                              })
                                  .push();
                            }
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              icon: _favorited
                  ? Icon(
                      Icons.favorite,
                      color: Theme.of(context).primaryColor,
                    )
                  : const Icon(
                      Icons.favorite_outline,
                      color: Colors.grey,
                    ),
              onPressed: () async {
                if (_favorited) {
                  await GsaServiceBookmarks.instance.removeBookmark(widget.saleItem.id ?? '');
                } else {
                  await GsaServiceBookmarks.instance.addBookmark(widget.saleItem.id ?? '');
                }
                setState(() => _favorited = !_favorited);
              },
            ),
          ),
        ],
      ),
      onTap: () async {
        await GsaWidgetOverlaySaleItem.open(context, widget.saleItem);
      },
    );
  }

  @override
  void dispose() {
    GsaDataCheckout.instance.notifierCartUpdate.removeListener(_onCartCountUpdate);
    super.dispose();
  }
}
