import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_content/src/common/widgets/actions/widget_sticky_bottom_button.dart';
import 'package:generic_shop_app_data/data.dart';
import 'package:generic_shop_app_services/services.dart';

part 'widgets/widget_cart_item.dart';

/// Route providing the cart / checkout overview and the related data manipulation options.
///
class GsaRouteCart extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteCart({super.key});

  @override
  State<GsaRouteCart> createState() => _GsaRouteCartState();
}

class _GsaRouteCartState extends GsaRouteState<GsaRouteCart> {
  late Set<String> _saleItemCategoryIds;

  @override
  void initState() {
    super.initState();
    _saleItemCategoryIds = {};
  }

  final _filteredCategoryIds = <String>{};

  final _scrollController = ScrollController();

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
              controller: _scrollController,
              padding: const EdgeInsets.all(20),
              children: [
                ValueListenableBuilder(
                  valueListenable: GsaDataCheckout.instance.notifierCartUpdate,
                  builder: (context, cartItemCount, child) {
                    return Row(
                      children: [
                        Expanded(
                          child: GsaWidgetText.rich(
                            [
                              const GsaWidgetTextSpan(
                                'Cart Items ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              GsaWidgetTextSpan(
                                '($cartItemCount)',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Tooltip(
                          message: 'The total price of your cart is an estimate based on the available display price of items added to it. '
                                  'It is subject to change and may not always reflect real-time updates. '
                                  'Additional charges for taxes or options such as delivery may also apply.'
                              .translated(context),
                          triggerMode: TooltipTriggerMode.tap,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ValueListenableBuilder(
                                valueListenable: GsaDataCheckout.instance.notifierCartUpdate,
                                builder: (context, value, child) {
                                  return GsaWidgetText(
                                    GsaDataCheckout.instance.orderDraft.totalItemPriceFormatted,
                                    style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  );
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.info_outline,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const Divider(height: 30),
                const GsaWidgetText(
                  'Browse and review the items in your cart.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                if (_saleItemCategoryIds.length > 1)
                  SizedBox(
                    height: 38,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (final category in GsaDataCheckout.instance.orderDraft.items
                            .map(
                              (saleItem) =>
                                  GsaDataSaleItems.instance.categories.firstWhere((category) => category.id == saleItem.categoryId),
                            )
                            .indexed)
                          Padding(
                            padding: const EdgeInsets.only(right: 9),
                            child: OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  _filteredCategoryIds.contains(category.$2.id) ? Theme.of(context).primaryColor : null,
                                ),
                              ),
                              child: GsaWidgetText(
                                '${category.$2.name} '
                                '( TODO )',
                                style: _filteredCategoryIds.contains(category.$2.id)
                                    ? const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      )
                                    : const TextStyle(
                                        color: Colors.grey,
                                      ),
                              ),
                              onPressed: () {
                                if (category.$2.id != null) {
                                  setState(() {
                                    _filteredCategoryIds.contains(category.$2.id)
                                        ? _filteredCategoryIds.remove(category.$2.id)
                                        : _filteredCategoryIds.add(category.$2.id!);
                                  });
                                }
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                const SizedBox(height: 26),
                for (final item in (_filteredCategoryIds.isEmpty
                        ? GsaDataCheckout.instance.orderDraft.items
                        : GsaDataCheckout.instance.orderDraft.items.where(
                            (saleItem) {
                              return _filteredCategoryIds.contains(saleItem.categoryId);
                            },
                          ))
                    .indexed) ...[
                  if (item.$1 != 0) const SizedBox(height: 30),
                  _WidgetCartItem(
                    item.$2,
                    key: UniqueKey(),
                  ),
                ],
                const SizedBox(height: 20),
                const GsaWidgetText(
                  'The items in your cart are subject to verification and adjustment at the time of checkout. '
                  'We reserve the right to modify or cancel orders based on the availability and pricing.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 30),
                const GsaWidgetHeadline('Promo Code'),
                const GsaWidgetText(
                  'Enter your promo code here for exclusive discounts and special offers.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GsaWidgetTextField(
                        labelText: 'Coupon Code',
                        prefixIcon: Icon(
                          Icons.redeem,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                      ),
                      iconSize: 30,
                      onPressed: () {},
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 3,
                        ),
                        child: GsaWidgetText(
                          'Add a New Coupon',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                const GsaWidgetTotalCartPrice(),
                const SizedBox(height: 20),
                Card(
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: GsaWidgetText.rich(
                      [
                        const GsaWidgetTextSpan(
                          'By proceeding with checkout, you acknowledge and accept our ',
                        ),
                        GsaWidgetTextSpan(
                          'Terms of Service',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('terms-and-conditions');
                          },
                        ),
                        const GsaWidgetTextSpan(
                          ' and ',
                        ),
                        GsaWidgetTextSpan(
                          'Privacy Policy',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('privacy-policy');
                          },
                        ),
                        const GsaWidgetTextSpan('.'),
                      ],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GsaWidgetStickyBottomButton(
            label: 'Checkout',
            onTap: () async {
              if (_scrollController.position.pixels < _scrollController.position.maxScrollExtent - 20) {
                await _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent + 20,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                );
              } else {
                Navigator.popUntil(context, (route) => route.isFirst);
                const GsaRouteCheckout().push(context: context);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
