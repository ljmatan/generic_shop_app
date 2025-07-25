import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_ivancica/giv.dart';

/// Screen displaying product details and other relevant functionalities and content.
///
class GivRouteSaleItemDetails extends GivRoute {
  /// Default, unnamed widget constructor.
  ///
  const GivRouteSaleItemDetails({
    super.key,
  });

  @override
  State<GivRouteSaleItemDetails> createState() => _GivRouteSaleItemDetailsState();
}

class _GivRouteSaleItemDetailsState extends GsaRouteState<GivRouteSaleItemDetails> {
  /// The current item specified for viewing.
  ///
  GsaModelSaleItem? saleItem = GsaRouteSaleItemDetails.selectedSaleItem;

  /// Controller handling the selection of the sale item image.
  ///
  late ValueNotifier<String?> _imageUrlSelectionNotifier;

  /// Used for the sale item option (e.g., shoe size) selection.
  ///
  late ValueNotifier<GsaModelSaleItem?> _optionSelectionNotifier;

  @override
  void initState() {
    super.initState();
    _imageUrlSelectionNotifier = ValueNotifier(
      saleItem?.imageUrls?.isNotEmpty == true ? saleItem?.imageUrls![0] : null,
    );
    _optionSelectionNotifier = ValueNotifier(
      saleItem?.options?.isNotEmpty == true ? saleItem?.options![0] : null,
    );
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GsaWidgetAppBar(
            label: widget.displayName,
          ),
          Expanded(
            child: saleItem == null
                ? const Center(
                    child: GsaWidgetError(
                      'Sale item not defined.',
                    ),
                  )
                : ListView(
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
                                        return GsaWidgetImage.network(
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
                              if (saleItem != null)
                                Positioned(
                                  right: 8,
                                  child: GsaWidgetBookmarkButton(
                                    saleItem!,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      if ((saleItem?.imageUrls?.length ?? 0) > 1)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                            height: 80,
                            child: ListView(
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (final imageUrl in saleItem!.imageUrls!.indexed)
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
                                            padding: const EdgeInsets.all(2),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(4),
                                              child: GsaWidgetImage.network(
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
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: GsaWidgetText.rich(
                                  [
                                    GsaWidgetTextSpan(
                                      saleItem?.name ?? 'N/A',
                                    ),
                                    if (saleItem?.productCode != null)
                                      GsaWidgetTextSpan(
                                        '\n${saleItem?.productCode!}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                  ],
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
                                      return GsaWidgetButton.filled(
                                        label: 'Inquire',
                                        onTap: () {},
                                      );
                                    }
                                    return GsaWidgetText(
                                      value!.price!.formatted!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const Divider(height: 0, indent: 20, endIndent: 20),
                              if (saleItem?.options != null)
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
                                              GsaWidgetText(
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
                                              for (final option in saleItem!.options!.indexed)
                                                Padding(
                                                  padding: option.$1 == 0 ? EdgeInsets.zero : const EdgeInsets.only(left: 8),
                                                  child: GestureDetector(
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                        color: _optionSelectionNotifier.value == option.$2
                                                            ? Theme.of(context).primaryColor
                                                            : Colors.white,
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                      child: SizedBox(
                                                        width: 40,
                                                        height: 48,
                                                        child: Center(
                                                          child: GsaWidgetText(
                                                            option.$2.name ?? 'N/A',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  _optionSelectionNotifier.value == option.$2 ? FontWeight.bold : null,
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
                                        if (_optionSelectionNotifier.value?.name != null &&
                                            num.tryParse(_optionSelectionNotifier.value!.name!) != null)
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
                                            child: GsaWidgetText(
                                              'Length: ' +
                                                  (num.parse(_optionSelectionNotifier.value!.name!) * 2 / 3).toStringAsFixed(1) +
                                                  'cm',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              if (GsaConfig.cartEnabled && saleItem?.options?.isNotEmpty == true) ...[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: GsaWidgetButton.filled(
                                      label: 'Add to Cart',
                                      icon: Icons.shopping_bag,
                                      tonal: true,
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: GsaWidgetText(
                                      'or',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              Center(
                                child: GsaWidgetBookmarkButton(
                                  saleItem!,
                                  child: (bookmarked) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: GsaWidgetText(
                                      bookmarked ? 'Remove from Favorites' : 'Add to Favorites',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).primaryColor,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (saleItem?.attributeIconUrls?.isNotEmpty == true)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
                              child: GsaWidgetText(
                                'Characteristics',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                children: [
                                  for (final icon in saleItem!.attributeIconUrls!.indexed)
                                    Padding(
                                      padding: icon.$1 == 0 ? EdgeInsets.zero : const EdgeInsets.only(left: 10),
                                      child: GsaWidgetImage.network(
                                        icon.$2,
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (saleItem?.informationList?.isNotEmpty == true)
                              for (final information in saleItem!.informationList!.indexed)
                                Padding(
                                  padding: information.$1 == 0
                                      ? const EdgeInsets.fromLTRB(20, 14, 20, 0)
                                      : const EdgeInsets.fromLTRB(20, 6, 20, 0),
                                  child: GsaWidgetText.rich(
                                    [
                                      GsaWidgetTextSpan(
                                        '${information.$2.label}: ',
                                      ),
                                      GsaWidgetTextSpan(
                                        information.$2.description,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      if (saleItem?.description?.isNotEmpty == true)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: GsaWidgetText(
                                  'Description',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              GsaWidgetText(
                                saleItem!.description!,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (saleItem?.options
                              ?.where(
                                (option) =>
                                    option.availability?.any(
                                      (availability) => availability.locationId != null,
                                    ) ==
                                    true,
                              )
                              .isNotEmpty ==
                          true)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: GsaWidgetText(
                                  'Availability',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Wrap(
                                spacing: 12,
                                runSpacing: 10,
                                children: [
                                  for (final storeLocation in <String>{
                                    for (final option in saleItem!.options!)
                                      if (option.availability?.isNotEmpty == true)
                                        for (final availabilityOption in option.availability!)
                                          if (availabilityOption.locationId != null) availabilityOption.locationId!,
                                  })
                                    Builder(
                                      builder: (context) {
                                        final productAvailable = _optionSelectionNotifier.value?.availability
                                                ?.any((availabilityInfo) => availabilityInfo.locationId == storeLocation) ==
                                            true;
                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              productAvailable ? Icons.check : Icons.close,
                                              color: productAvailable ? Theme.of(context).primaryColor : Colors.grey,
                                              size: 13,
                                            ),
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 5),
                                                child: GsaWidgetText(
                                                  storeLocation,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: productAvailable ? Theme.of(context).primaryColor : Colors.grey,
                                                  ),
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
