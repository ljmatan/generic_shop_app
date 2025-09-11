import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

/// A widget displaying the summary of the cart pricing information.
///
class GsaWidgetTotalCartPrice extends StatefulWidget {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetTotalCartPrice({super.key});

  @override
  State<GsaWidgetTotalCartPrice> createState() => _GsaWidgetTotalCartPriceState();
}

class _GsaWidgetTotalCartPriceState extends State<GsaWidgetTotalCartPrice> {
  late String _cartCountListenerId;

  @override
  void initState() {
    super.initState();
    _cartCountListenerId = GsaDataCheckout.instance.addListener(
      () => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GsaDataCheckout.instance.notifierCartUpdate,
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const GsaWidgetHeadline('Price'),
            GsaWidgetText(
              'The total cart price displayed is an estimate and subject to change based on '
              'product availability, taxes, shipping fees, or any other additional expense.',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 14),
            for (final priceItem in {
              (
                label: 'Delivery',
                display: GsaDataCheckout.instance.orderDraft.deliveryType == null
                    ? 'Specified at Checkout'
                    : GsaDataCheckout.instance.orderDraft.deliveryType?.price?.centum == 0
                        ? 'FREE'
                        : GsaDataCheckout.instance.orderDraft.deliveryType!.price?.formatted ?? 'N/A',
                tooltip: 'Optional doorstep delivery.',
              ),
              if (GsaDataCheckout.instance.orderDraft.paymentType?.price?.centum != null &&
                  GsaDataCheckout.instance.orderDraft.paymentType!.price!.centum! > 0)
                (
                  label: 'Payment',
                  display: GsaDataCheckout.instance.orderDraft.paymentType!.price!.formatted,
                  tooltip: 'The additional cost of the specified payment method.',
                ),
              (
                label: 'Total',
                display: GsaDataCheckout.instance.orderDraft.totalPriceFormatted,
                tooltip: 'The total amount due for the items in your cart.',
              ),
            }.indexed)
              Padding(
                padding: priceItem.$1 == 0 ? EdgeInsets.zero : const EdgeInsets.only(top: 10),
                child: Tooltip(
                  message: priceItem.$2.tooltip,
                  triggerMode: TooltipTriggerMode.tap,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 14,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: GsaWidgetText(
                          ' ${priceItem.$2.label}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      GsaWidgetText(
                        priceItem.$2.display ?? 'N/A',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    GsaDataCheckout.instance.removeListener(
      id: _cartCountListenerId,
    );
    super.dispose();
  }
}
