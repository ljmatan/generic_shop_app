import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_ivancica/view/src/routes/routes.dart';

/// Screen displaying product details and other relevant functionalities and content.
///
class GivRouteSaleItemDetails extends GivRoute {
  /// Default, unnamed widget constructor.
  ///
  const GivRouteSaleItemDetails(
    this.saleItem, {
    super.key,
  });

  /// The sale item specified for viewing.
  ///
  final GsaaModelSaleItem saleItem;

  @override
  State<GivRouteSaleItemDetails> createState() => _GivRouteSaleItemDetailsState();
}

class _GivRouteSaleItemDetailsState extends GsarRouteState<GivRouteSaleItemDetails> {
  /// Controller handling the selection of the sale item image.
  ///
  late ValueNotifier<String?> _imageUrlSelectionNotifier;

  /// Used for the sale item option (e.g., shoe size) selection.
  ///
  late ValueNotifier<GsaaModelSaleItem?> _optionSelectionNotifier;

  @override
  void initState() {
    super.initState();
    _imageUrlSelectionNotifier = ValueNotifier(
      widget.saleItem.imageUrls?.isNotEmpty == true ? widget.saleItem.imageUrls![0] : null,
    );
    _optionSelectionNotifier = ValueNotifier(
      widget.saleItem.options?.isNotEmpty == true ? widget.saleItem.options![0] : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: Stack(
                children: [
                  _imageUrlSelectionNotifier.value != null
                      ? ValueListenableBuilder(
                          valueListenable: _imageUrlSelectionNotifier,
                          builder: (context, value, child) {
                            return Image.network(
                              value!,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              alignment: Alignment.center,
                            );
                          },
                        )
                      : Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            size: 100,
                          ),
                        ),
                  Positioned(
                    right: 8,
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return IconButton(
                          icon: Icon(Icons.favorite_outline),
                          onPressed: () {},
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if ((widget.saleItem.imageUrls?.length ?? 0) > 1)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 80,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (final imageUrl in widget.saleItem.imageUrls!.indexed)
                      Padding(
                        padding: imageUrl.$1 == 0 ? EdgeInsets.zero : const EdgeInsets.only(left: 8),
                        child: GestureDetector(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.secondary,
                                width: .1,
                              ),
                              color: Colors.white,
                            ),
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    imageUrl.$2,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            _imageUrlSelectionNotifier.value = imageUrl.$2;
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text.rich(
                      TextSpan(
                        text: widget.saleItem.name ?? 'N/A',
                        children: [
                          if (widget.saleItem.productCode != null)
                            TextSpan(
                              text: '\n${widget.saleItem.productCode!}',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                        ],
                      ),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
                    child: ValueListenableBuilder(
                      valueListenable: _optionSelectionNotifier,
                      builder: (context, value, child) {
                        if (value?.price == null) {
                          return FilledButton.icon(
                            onPressed: () {},
                            label: Text(
                              'Inquire',
                            ),
                          );
                        }
                        return Text(
                          value!.price!.formatted()!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(height: 0, indent: 20, endIndent: 20),
                  if (widget.saleItem.options != null)
                    ValueListenableBuilder(
                      valueListenable: _optionSelectionNotifier,
                      builder: (context, value, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: SvgPicture.asset(
                                      'assets/ivancica/svg/shoe.svg',
                                      width: 15,
                                      height: 15,
                                      alignment: Alignment.center,
                                      colorFilter: ColorFilter.mode(
                                        Colors.grey,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Select your shoe size:',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 48,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                children: [
                                  for (final option in widget.saleItem.options!.indexed)
                                    Padding(
                                      padding: option.$1 == 0 ? EdgeInsets.zero : const EdgeInsets.only(left: 8),
                                      child: GestureDetector(
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color:
                                                _optionSelectionNotifier.value == option.$2 ? Theme.of(context).primaryColor : Colors.white,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: SizedBox(
                                            width: 40,
                                            height: 48,
                                            child: Center(
                                              child: Text(
                                                option.$2.name ?? 'N/A',
                                                style: TextStyle(
                                                  fontWeight: _optionSelectionNotifier.value == option.$2 ? FontWeight.bold : null,
                                                  color: _optionSelectionNotifier.value == option.$2 ? Colors.white : null,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          _optionSelectionNotifier.value = option.$2;
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (_optionSelectionNotifier.value?.name != null && num.tryParse(_optionSelectionNotifier.value!.name!) != null)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                                child: Text(
                                  'Length: ' + (num.parse(_optionSelectionNotifier.value!.name!) * 2 / 3).toStringAsFixed(1) + 'cm',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FilledButton.tonalIcon(
                        icon: Icon(
                          Icons.shopping_bag,
                          color: Theme.of(context).primaryColor,
                        ),
                        label: Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        'or',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      child: Text('Add to Favorites'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (widget.saleItem.description?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Text(
                      'Description',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Text(
                    widget.saleItem.description!,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Text(
                    'Availability',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ),
                  ),
                ),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    for (final storeLocation in <String>{
                      'Pula Max City',
                      'ZG Maksimirska',
                      'ZG Ilica',
                      'Varaždin',
                      'West Gate',
                      'Začretje Roses Outlet',
                      'Centralno skladište',
                      'Požega',
                      'Rijeka Tower Center',
                      'ZG CC One East',
                      'ZG Avenue Mall',
                      'Čakovec Galerija Sjever',
                      'Koprivnica',
                      'Bjelovar',
                      'Virovitica',
                      'Osijek Portanova',
                      'Vinkovci',
                      'Sisak',
                      'Slavonski Brod',
                      'Karlovac',
                      'ZG Arena',
                      'Dubrovnik',
                      'Split Mall Of Split',
                      'Šibenik Dalmare',
                      'Zadar City Park',
                      'ZG CC One West',
                    })
                      Builder(
                        builder: (context) {
                          // TODO
                          final productAvailable = Random().nextBool() && Random().nextBool();
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                productAvailable ? Icons.check : Icons.close,
                                color: productAvailable ? Theme.of(context).primaryColor : Colors.grey,
                                size: 13,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  storeLocation,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: productAvailable ? Theme.of(context).primaryColor : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _optionSelectionNotifier.dispose();
    _imageUrlSelectionNotifier.dispose();
    super.dispose();
  }
}
