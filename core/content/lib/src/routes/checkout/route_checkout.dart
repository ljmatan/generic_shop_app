import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:generic_shop_app_content/content.dart';

part 'widgets/widget_checkout_option.dart';
part 'widgets/widget_merchant_map_finder.dart';
part 'widgets/widget_checkout_overview.dart';

/// Route aimed at checkout integration,
/// with all of the checkout options (delivery, payment, info propagation) implemented.
///
class GsaRouteCheckout extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteCheckout({super.key});

  @override
  State<GsaRouteCheckout> createState() => _GsaRouteCheckoutState();
}

class _GsaRouteCheckoutState extends GsaRouteState<GsaRouteCheckout> {
  final _pageController = PageController();

  final _animationDuration = const Duration(milliseconds: 500);

  Future<void> _goToStep(int step) async {
    return await _pageController.animateToPage(
      step,
      duration: _animationDuration,
      curve: Curves.ease,
    );
  }

  Future<void> _goToPreviousStep() async {
    return await _pageController.previousPage(
      duration: _animationDuration,
      curve: Curves.ease,
    );
  }

  Future<void> _goToNextStep() async {
    return await _pageController.nextPage(
      duration: _animationDuration,
      curve: Curves.ease,
    );
  }

  @override
  void didPop() {
    super.didPop();
    GsaDataCheckout.instance.orderDraft.deliveryType = null;
    GsaDataCheckout.instance.orderDraft.paymentType = null;
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GsaWidgetAppBar(
            label: widget.displayName,
            onBackPressed: () async {
              if ((_pageController.page ?? 0) > .5) {
                if ((_pageController.page ?? 0) > 1 && _pageController.page! < 2) {
                  GsaDataCheckout.instance.orderDraft.paymentType = null;
                }
                await _goToPreviousStep();
              } else {
                Navigator.pop(context);
              }
            },
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                if (GsaDataSaleItems.instance.deliveryOptions.isNotEmpty && GsaDataCheckout.instance.orderDraft.deliverable)
                  _WidgetCheckoutOption(
                    type: _WidgetCheckoutOptionType.delivery,
                    options: GsaDataSaleItems.instance.deliveryOptions,
                    title: 'Delivery Options',
                    subtitle: 'Delivery options are specified and can be configured below.',
                    inputFieldsTitle: 'Delivery Info',
                    inputFieldsNotice: 'Below information is specified as the item delivery address. '
                        'This information is shared with the vendor and courier companies for the purposes of order fullfilment.',
                    onCartSettingsUpdate: () => setState(() {}),
                    goToNextStep: _goToNextStep,
                  ),
                if (GsaDataSaleItems.instance.paymentOptions.isNotEmpty && GsaDataCheckout.instance.orderDraft.payable)
                  _WidgetCheckoutOption(
                    type: _WidgetCheckoutOptionType.payment,
                    options: GsaDataSaleItems.instance.paymentOptions,
                    title: 'Payment Options',
                    subtitle: 'Payment options are specified and can be configured below.',
                    inputFieldsTitle: 'Invoice Address',
                    inputFieldsNotice:
                        'Below information is specified as your legal address or the address where you receive correspondence. '
                        'This information is shared with the vendor and courier companies for the purposes of order fullfilment.',
                    onCartSettingsUpdate: () => setState(() {}),
                    goToNextStep: _goToNextStep,
                  ),
                if (1 == 2 && GsaDataMerchant.instance.merchant == null)
                  _WidgetMerchantMapFinder(
                    notice: GsaModelTranslated(
                      values: [
                        (
                          languageId: 'en',
                          value: 'Reach out to a nearby independent Herbalife distributor to complete your purchase.',
                        ),
                      ],
                    ),
                    goToNextStep: _goToNextStep,
                  ),
                _WidgetCheckoutOverview(
                  state: this,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
