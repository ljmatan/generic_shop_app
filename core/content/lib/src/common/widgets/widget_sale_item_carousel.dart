import 'package:flutter/material.dart';
import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// Horizontally scrollable list of sale items.
///
class GsaWidgetSaleItemCarousel extends StatelessWidget {
  // ignore: public_member_api_docs
  const GsaWidgetSaleItemCarousel(
    this.saleItems, {
    super.key,
    this.label,
    required this.horizontalPadding,
  });

  /// The list of sale items for display.
  ///
  final List<GsaModelSaleItem> saleItems;

  /// The title element for the given sale item list.
  ///
  final String? label;

  /// The padding applied to the child [ListView] object.
  ///
  final double horizontalPadding;

  static const _internalPadding = 8.0;

  @override
  Widget build(BuildContext context) {
    if (saleItems.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: GsaWidgetHeadline(
              label!,
            ),
          ),
        ],
        const SizedBox(height: 12),
        SizedBox(
          height: GsaWidgetSaleItemPreview.previewHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: saleItems.length,
            padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding < _internalPadding ? horizontalPadding : horizontalPadding - _internalPadding,
            ),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                right: horizontalPadding < _internalPadding ? horizontalPadding : _internalPadding,
              ),
              child: GsaWidgetSaleItemPreview(
                saleItems[index],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
