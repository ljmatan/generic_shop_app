import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:generic_shop_app/data/data.dart';
import 'package:generic_shop_app/services/src/i18n/service_i18n.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app/services/services.dart';
import 'package:generic_shop_app/view/src/common/widgets/actions/widget_text_field.dart';
import 'package:generic_shop_app/view/src/common/widgets/overlays/widget_overlay_content_blocking.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_image.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_total_cart_price.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_headline.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_phone_number_input.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_terms_confirmation.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_text.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:latlong2/latlong.dart';

part 'widgets/widget_checkout_option.dart';
part 'widgets/widget_vendor_option.dart';
part 'widgets/widget_merchant_map_finder.dart';
part 'widgets/widget_checkout_overview.dart';

/// Route aimed at checkout integration,
/// with all of the checkout options (delivery, payment, info propagation) implemented.
///
class GsaRouteCheckout extends GsaRoute {
  // ignore: public_member_api_docs
  const GsaRouteCheckout({super.key});

  @override
  State<GsaRouteCheckout> createState() => _GsaRouteCheckoutState();

  @override
  String get routeId => 'checkout';

  @override
  String get displayName => 'Checkout';
}

class _GsaRouteCheckoutState extends GsaRouteState<GsaRouteCheckout> {
  final _pageController = PageController();

  Future<void> _goToNextStep() async {
    return await _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

  @override
  void didPop() {
    super.didPop();
    GsaDataCheckout.instance.orderDraft.deliveryType = null;
    GsaDataCheckout.instance.orderDraft.paymentType = null;
    GsaDataCheckout.instance.onCartUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const BackButtonIcon(),
          onPressed: () async {
            if ((_pageController.page ?? 0) > .5) {
              if ((_pageController.page ?? 0) > 1 && _pageController.page! < 2) {
                GsaDataCheckout.instance.orderDraft.paymentType = null;
                GsaDataCheckout.instance.onCartUpdate();
              }
              await _pageController.animateToPage(
                (_pageController.page! - 1 > 0 ? _pageController.page! - 1 : 0).toInt(),
                duration: const Duration(milliseconds: 600),
                curve: Curves.ease,
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: GsaWidgetText(widget.displayName),
      ),
      body: PageView(
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
              inputFieldsNotice: 'Below information is specified as your legal address or the address where you receive correspondence. '
                  'This information is shared with the vendor and courier companies for the purposes of order fullfilment.',
              onCartSettingsUpdate: () => setState(() {}),
              goToNextStep: _goToNextStep,
            ),
          if (GsaDataMerchant.instance.merchant == null)
            _WidgetMerchantMapFinder(
              notice: GsaaModelTranslated(
                values: [
                  (
                    languageId: 'en',
                    value: 'Reach out to a nearby independent Herbalife distributor to complete your purchase.',
                  ),
                ],
              ),
              goToNextStep: _goToNextStep,
            ),
          const _WidgetCheckoutOverview(),
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
