import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

/// Route displaying the order status information.
///
class GsaRouteOrderStatus extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteOrderStatus({super.key});

  @override
  State<GsaRouteOrderStatus> createState() => _GsaRouteOrderStatusState();
}

class _GsaRouteOrderStatusState extends GsaRouteState<GsaRouteOrderStatus> {
  void _close() {
    Navigator.of(GsaRoute.navigatorContext ?? context).popUntil((route) {
      return route.isFirst;
    });
  }

  @override
  Widget view(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        _close();
      },
      child: Scaffold(
        body: Column(
          children: [
            GsaWidgetAppBar(
              label: widget.displayName,
              onBackPressed: () {
                _close();
              },
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  vertical: GsaTheme.of(context).paddings.widget.listViewVertical,
                ),
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(26),
                      child: Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  Center(
                    child: GsaWidgetText(
                      'Order Complete',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Center(
                    child: GsaWidgetText.rich(
                      const [
                        GsaWidgetTextSpan(
                          'Order ID: ',
                        ),
                        GsaWidgetTextSpan(
                          'V32SDA1',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: GsaWidgetText.rich(
                      const [
                        GsaWidgetTextSpan(
                          'We\'ll keep you updated every step of the way.\n\n',
                        ),
                        GsaWidgetTextSpan(
                          'Thank you for your purchase!',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: GsaTheme.of(context).paddings.widget.listViewHorizontal,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: GsaWidgetButton.filled(
                        label: 'HOME',
                        onTap: () {
                          _close();
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: GsaTheme.of(context).paddings.content.mediumLarge,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: GsaTheme.of(context).paddings.widget.listViewHorizontal,
                    ),
                    child: const GsaWidgetHeadline(
                      'My Order',
                    ),
                  ),
                  for (final saleItem in GsaDataCheckout.instance.orderDraft.items.indexed) ...[
                    if (saleItem.$1 != 0)
                      SizedBox(
                        height: GsaTheme.of(context).paddings.content.small,
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: GsaTheme.of(context).paddings.widget.listViewHorizontal,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: saleItem.$2.imageUrls?.isNotEmpty == true
                                    ? GsaWidgetImage.network(
                                        saleItem.$2.imageUrls![0],
                                        width: 60,
                                        height: 60,
                                      )
                                    : GsaWidgetImage.placeholder(
                                        width: 60,
                                        height: 60,
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: GsaTheme.of(context).paddings.content.small,
                          ),
                          Flexible(
                            child: SizedBox(
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GsaWidgetText(
                                      saleItem.$2.name ?? 'N/A',
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        GsaWidgetText(
                                          '${saleItem.$2.cartCount()} x ${saleItem.$2.price?.formatted} '
                                          '${GsaConfig.currency.code} ',
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Spacer(),
                                        GsaWidgetText(
                                          ' ${((saleItem.$2.cartCount() ?? 0) * (saleItem.$2.price?.unity ?? 0)).toStringAsFixed(2)} ${GsaConfig.currency.code}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (GsaDataCheckout.instance.orderDraft.deliveryType != null) ...[
                    SizedBox(
                      height: GsaTheme.of(context).paddings.content.mediumLarge,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: GsaTheme.of(context).paddings.widget.listViewHorizontal,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const GsaWidgetHeadline(
                            'Delivery',
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.local_shipping,
                                size: 14,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: GsaTheme.of(context).paddings.content.small,
                              ),
                              GsaWidgetText(
                                GsaDataCheckout.instance.orderDraft.deliveryType?.name ?? 'N/A',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (GsaDataCheckout.instance.orderDraft.paymentType != null) ...[
                    SizedBox(
                      height: GsaTheme.of(context).paddings.content.mediumLarge,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: GsaTheme.of(context).paddings.widget.listViewHorizontal,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const GsaWidgetHeadline(
                            'Payment',
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.account_balance,
                                size: 14,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: GsaTheme.of(context).paddings.content.small,
                              ),
                              GsaWidgetText(
                                GsaDataCheckout.instance.orderDraft.paymentType?.name ?? 'N/A',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(
                    height: GsaTheme.of(context).paddings.content.mediumLarge,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: GsaTheme.of(context).paddings.widget.listViewHorizontal,
                    ),
                    child: const GsaWidgetTotalCartPrice(),
                  ),
                  SizedBox(
                    height: GsaTheme.of(context).paddings.content.mediumLarge,
                  ),
                  GsaWidgetSaleItemCarousel(
                    GsaDataSaleItems.instance.collection,
                    label: 'Featured',
                    horizontalPadding: GsaTheme.of(context).paddings.widget.listViewHorizontal,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    GsaDataCheckout.instance.clear();
    super.dispose();
  }
}
