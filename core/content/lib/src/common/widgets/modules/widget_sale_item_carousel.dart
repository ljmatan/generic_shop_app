import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

/// Horizontally scrollable list of sale items.
///
class GsaWidgetSaleItemCarousel extends StatefulWidget {
  /// Default, unnamed widget constructor.
  ///
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

  /// Padding applied between element entries.
  ///
  static const _internalPadding = 8.0;

  @override
  State<GsaWidgetSaleItemCarousel> createState() => _GsaWidgetSaleItemCarouselState();
}

class _GsaWidgetSaleItemCarouselState extends State<GsaWidgetSaleItemCarousel> {
  /// The number of items displayed per row with grid view mode.
  ///
  int get _itemsPerRow {
    final screenWidth = MediaQuery.of(context).size.width;
    if (Theme.of(context).dimensions.smallScreen) return 0;
    return screenWidth < 1300
        ? 3
        : screenWidth < 1600
            ? 4
            : 5;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.saleItems.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
            child: GsaWidgetHeadline(
              widget.label!,
            ),
          ),
        ],
        const SizedBox(height: 12),
        if (Theme.of(context).dimensions.smallScreen)
          SizedBox(
            height: GsaWidgetSaleItemPreview.previewHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.saleItems.length,
              padding: EdgeInsets.only(
                left: widget.horizontalPadding,
                right: widget.horizontalPadding < GsaWidgetSaleItemCarousel._internalPadding
                    ? widget.horizontalPadding
                    : widget.horizontalPadding - GsaWidgetSaleItemCarousel._internalPadding,
              ),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  right: widget.horizontalPadding < GsaWidgetSaleItemCarousel._internalPadding
                      ? widget.horizontalPadding
                      : GsaWidgetSaleItemCarousel._internalPadding,
                ),
                child: GsaWidgetSaleItemPreview(
                  widget.saleItems[index],
                ),
              ),
            ),
          )
        else ...[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.horizontalPadding,
            ),
            child: Wrap(
              spacing: GsaWidgetSaleItemCarousel._internalPadding,
              runSpacing: GsaWidgetSaleItemCarousel._internalPadding,
              children: [
                for (final saleItem in widget.saleItems)
                  GsaWidgetSaleItemPreview(
                    saleItem,
                    width: ((MediaQuery.of(context).size.width - widget.horizontalPadding * 2) -
                            (GsaWidgetSaleItemCarousel._internalPadding * (_itemsPerRow - 1))) /
                        _itemsPerRow,
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
