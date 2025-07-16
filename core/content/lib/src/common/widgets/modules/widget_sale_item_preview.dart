import 'package:flutter/material.dart';
import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_data/data.dart';

/// Visual element specified for product details preview.
///
class GsaWidgetSaleItemPreview extends StatefulWidget {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetSaleItemPreview(
    this.saleItem, {
    super.key,
    this.width,
  });

  /// The model represented in this widget preview.
  ///
  final GsaModelSaleItem saleItem;

  /// Size applied to the element display.
  ///
  final double? width;

  /// Specified widget preview height.
  ///
  static final previewHeight =
      300.0 - (GsaConfig.cartEnabled ? 0 : 48 * GsaTheme.instance.textScaler(GsaRoute.navigatorKey.currentContext!).scale(1));

  @override
  State<GsaWidgetSaleItemPreview> createState() => _GsaWidgetSaleItemPreviewState();
}

class _GsaWidgetSaleItemPreviewState extends State<GsaWidgetSaleItemPreview> {
  int? _cartCount;

  void _setCartCount() {
    _cartCount = GsaDataCheckout.instance.orderDraft.getTotalItemCount(widget.saleItem);
    if (widget.saleItem.options != null) {
      for (final saleItemOption in widget.saleItem.options!) {
        final optionCount = GsaDataCheckout.instance.orderDraft.getItemCount(saleItemOption);
        if (optionCount != null) {
          _cartCount ??= 0;
          _cartCount = _cartCount! + optionCount;
        }
      }
    }
  }

  late String _cartCountListenerId;

  @override
  void initState() {
    super.initState();
    _setCartCount();
    _cartCountListenerId = GsaDataCheckout.instance.addListener(_setCartCount);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          Card(
            child: SizedBox(
              width: widget.width ?? (MediaQuery.of(context).size.width / 2 > 400 ? 400 : MediaQuery.of(context).size.width / 2),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SizedBox(
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
                                          cached: true,
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
                                      fontSize: 6,
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
                                      '${widget.saleItem.price!.discount!.formatted}',
                                      interpolated: true,
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
                    ),
                    const SizedBox(height: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.saleItem.amountMeasureFormatted != null)
                          GsaWidgetText(
                            widget.saleItem.amountMeasureFormatted!,
                            interpolated: true,
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        GsaWidgetText(
                          widget.saleItem.name ?? 'N/A',
                          interpolated: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (widget.saleItem.price?.centum != null)
                          GsaWidgetText(
                            '${widget.saleItem.price!.formatted}' +
                                (widget.saleItem.price?.discount?.centum != null ? ' ${widget.saleItem.price!.discount!.formatted}' : ''),
                            interpolated: true,
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        else if (widget.saleItem.options?.any((saleItemOption) => saleItemOption.price?.centum != null) == true)
                          GsaWidgetText.rich(
                            [
                              const GsaWidgetTextSpan(
                                'From',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              GsaWidgetTextSpan(
                                ' ${widget.saleItem.startingOptionPriceFormatted() ?? 'N/A'}',
                                interpolated: true,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        if (GsaConfig.plugin.client == GsaClient.froddoB2c && widget.saleItem.options?.isNotEmpty == true)
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
                              return GsaWidgetText.rich(
                                [
                                  const GsaWidgetTextSpan(
                                    'Sizes',
                                  ),
                                  const GsaWidgetTextSpan(
                                    ': ',
                                    interpolated: true,
                                  ),
                                  GsaWidgetTextSpan(
                                    sortedOptions.length > 1
                                        ? '${sortedOptions[0].name!} - ${sortedOptions.last.name}'
                                        : sortedOptions[0].name!,
                                    interpolated: true,
                                  ),
                                ],
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                    if (GsaConfig.cartEnabled) ...[
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: GsaWidgetButton.outlined(
                          backgroundColor: _cartCount == 0 ? Theme.of(context).primaryColor : null,
                          foregroundColor: _cartCount == 0 ? null : Theme.of(context).primaryColor,
                          label: !widget.saleItem.itemPriceExists && !widget.saleItem.itemOptionPriceExists ? 'INQUIRE' : '$_cartCount',
                          icon: !widget.saleItem.itemPriceExists && !widget.saleItem.itemOptionPriceExists ? null : Icons.shopping_cart,
                          interpolatedText: widget.saleItem.itemPriceExists || widget.saleItem.itemOptionPriceExists,
                          onTap: () async {
                            if (GsaConfig.plugin.addToCart != null) {
                              await GsaConfig.plugin.addToCart!(
                                context,
                                item: widget.saleItem,
                              );
                            } else {
                              debugPrint('GsaConfig.plugin.addToCart not defined.');
                            }
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: GsaWidgetBookmarkButton(
              widget.saleItem,
            ),
          ),
        ],
      ),
      onTap: () async {
        await GsaWidgetOverlaySaleItem(widget.saleItem).openBottomSheet();
      },
    );
  }

  @override
  void dispose() {
    GsaDataCheckout.instance.removeListener(id: _cartCountListenerId);
    super.dispose();
  }
}
