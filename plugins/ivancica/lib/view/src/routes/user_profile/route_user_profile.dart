import 'dart:math';

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
  final _originData = GsaDataUser.instance.user?.originData as GivModelUser?;

  @override
  Widget build(BuildContext context) {
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
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                        ],
                      ),
                    ),
                    OutlinedButton(
                      child: Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 14),
                  child: Divider(height: 0),
                ),
                if (_originData?.loyaltyCard != null) ...[
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
                          _originData!.loyaltyCard!.substring(0, 12),
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final info in <({String label, String description})>{
                    (
                      label: 'Card number',
                      description: _originData.loyaltyCard!,
                    ),
                    if (_originData.loyaltyPoints != null)
                      (
                        label: 'Froddo Points',
                        description: _originData.loyaltyPoints.toString(),
                      ),
                    if (double.tryParse(_originData.loyaltyValue?.replaceAll(',', '.') ?? '') != null)
                      (
                        label: 'Discount Value',
                        description: GsaModelPrice(
                              centum: (double.parse(_originData.loyaltyValue!.replaceAll(',', '.')) * 100).round(),
                              currencyType: GsaModelPriceCurrencyType.values.firstWhereOrNull(
                                (currency) => currency.symbol == _originData.currency,
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
                for (final action in <({
                  String label,
                  String description,
                  IconData icon,
                  void Function() onTap,
                })>{
                  (
                    label: 'Wishlist',
                    description: 'Save your favorite items and find them easily when you\'re ready to buy.',
                    icon: Icons.favorite_border,
                    onTap: () {},
                  ),
                  (
                    label: 'Rewards',
                    description: 'Check your points, redeem discounts, and enjoy exclusive perks.',
                    icon: Icons.star_border,
                    onTap: () {},
                  ),
                  (
                    label: 'Order History',
                    description: 'Track your past purchases, check order details, and manage returns.',
                    icon: Icons.history,
                    onTap: () {},
                  ),
                  (
                    label: 'Reviews',
                    description: 'View and manage your product reviews and share your experiences.',
                    icon: Icons.reviews_outlined,
                    onTap: () {},
                  ),
                }.indexed)
                  Padding(
                    padding: action.$1 == 0 ? const EdgeInsets.only(top: 20) : const EdgeInsets.only(top: 12),
                    child: GestureDetector(
                      child: Card(
                        color: action.$1 % 2 == 0 ? Theme.of(context).colorScheme.secondary : Theme.of(context).primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 16,
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Transform.translate(
                                  offset: Offset(
                                    (Random().nextDouble() * 50) - 50,
                                    (Random().nextDouble() * 50),
                                  ),
                                  child: Transform.scale(
                                    scale: 3 + Random().nextDouble(),
                                    child: Transform.rotate(
                                      angle: ((Random().nextDouble() * 60) - 30) * pi / 180,
                                      child: Icon(
                                        action.$2.icon,
                                        color: Colors.white24,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    action.$2.label,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    action.$2.description,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: action.$2.onTap,
                    ),
                  ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
    );
  }
}
