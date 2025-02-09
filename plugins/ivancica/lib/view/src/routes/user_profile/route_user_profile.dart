import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_data/data.dart';
import 'package:generic_shop_app_ivancica/models/models.dart';
import 'package:generic_shop_app_services/services.dart';

/// Screen containing user profile information and configuration options.
///
class GivRouteUserProfile extends GivRoute {
  /// Default, unnamed widget constructor.
  ///
  const GivRouteUserProfile({
    super.key,
  });

  @override
  State<GivRouteUserProfile> createState() => _GivRouteUserProfileState();
}

class _GivRouteUserProfileState extends GsaRouteState<GivRouteUserProfile> {
  @override
  Widget build(BuildContext context) {
    final originData = GsaDataUser.instance.user?.originData as GivModelUser?;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.displayName,
        ),
      ),
      body: GsaDataUser.instance.user == null
          ? GsaWidgetError(
              'No user information found.',
            )
          : ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              children: [
                if (GsaDataUser.instance.user!.personalDetails?.formattedName != null)
                  Text(
                    GsaDataUser.instance.user!.personalDetails!.formattedName!,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                if (GsaDataUser.instance.user!.contact?.email != null)
                  Text(
                    GsaDataUser.instance.user!.contact!.email!,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                if (originData?.loyaltyCard != null) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Froddo Club Card',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Earn points every time you shop and turn them into discounts! '
                    'Simply scan below code at checkout and watch your rewards grow.',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 12,
                      ),
                      child: Text(
                        'Terms and Conditions apply.',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    onTap: () {
                      // TODO
                    },
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.tertiary,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: GsaWidgetImage.string(
                        GsaServiceBarcodeGenerator.instance.generateCode128Svg(
                          originData!.loyaltyCard!.substring(0, 12),
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final info in <({String label, String description})>{
                    (
                      label: 'Card number',
                      description: originData.loyaltyCard!,
                    ),
                    if (originData.loyaltyPoints != null)
                      (
                        label: 'Froddo Points',
                        description: originData.loyaltyPoints.toString(),
                      ),
                    if (double.tryParse(originData.loyaltyValue?.replaceAll(',', '.') ?? '') != null)
                      (
                        label: 'Discount Value',
                        description: GsaModelPrice(
                              centum: (double.parse(originData.loyaltyValue!.replaceAll(',', '.')) * 100).round(),
                              currencyType: GsaModelPriceCurrencyType.values.firstWhereOrNull(
                                (currency) => currency.symbol == originData.currency,
                              ),
                            ).formatted() ??
                            'N/A',
                      ),
                  }.indexed)
                    Padding(
                      padding: info.$1 == 0 ? EdgeInsets.zero : const EdgeInsets.only(top: 5),
                      child: GsaWidgetText.rich(
                        [
                          GsaWidgetTextSpan(
                            '${info.$2.label}: ',
                          ),
                          GsaWidgetTextSpan(
                            info.$2.description,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ],
            ),
    );
  }
}
