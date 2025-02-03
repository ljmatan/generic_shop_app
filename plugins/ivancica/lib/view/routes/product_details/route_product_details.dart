import 'package:flutter/material.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

class GivRouteProductDetails extends GsarRoute {
  /// Default, unnamed widget constructor.
  ///
  const GivRouteProductDetails(
    this.saleItem, {
    super.key,
  });

  ///
  ///
  final GsaaModelSaleItem saleItem;

  @override
  State<GivRouteProductDetails> createState() => _GivRouteProductDetailsState();

  @override
  String get routeId => 'product-details';

  @override
  String get displayName => 'Product Details';
}

class _GivRouteProductDetailsState extends GsarRouteState<GivRouteProductDetails> {
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
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: _imageUrlSelectionNotifier.value != null
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
                                color: Theme.of(context).colorScheme.tertiary,
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
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: widget.saleItem.name ?? 'N/A',
                      children: [
                        if (widget.saleItem.productCode != null)
                          TextSpan(
                            text: '\n${widget.saleItem.productCode!}',
                            style: TextStyle(
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
                  if (_optionSelectionNotifier.value != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 6),
                      child: ValueListenableBuilder(
                        valueListenable: _optionSelectionNotifier,
                        builder: (context, value, child) {
                          if (value!.price == null) {
                            FilledButton.icon(
                              onPressed: () {},
                              label: Text(
                                'Inquire',
                              ),
                            );
                          }
                          return Text(
                            value.price!.formatted()!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                  const Divider(),
                ],
              ),
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
