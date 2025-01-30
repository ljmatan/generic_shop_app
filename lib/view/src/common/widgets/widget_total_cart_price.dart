import 'package:flutter/material.dart';
import 'package:generic_shop_app/data/data.dart';
import 'package:generic_shop_app/data/src/data_checkout.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_headline.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_text.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';

class GsaWidgetTotalCartPrice extends StatefulWidget {
  const GsaWidgetTotalCartPrice({super.key});

  @override
  State<GsaWidgetTotalCartPrice> createState() => _GsaWidgetTotalCartPriceState();
}

class _GsaWidgetTotalCartPriceState extends State<GsaWidgetTotalCartPrice> {
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
            const GsaWidgetText(
              'The total cart price displayed is an estimate and subject to change based on '
              'product availability, taxes, shipping fees, or any other additional expense.',
              style: TextStyle(
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
                        : '${GsaDataCheckout.instance.orderDraft.deliveryType!.price?.formatted() ?? 'N/A'} ${GsaaServiceCurrency.currency.code}',
                tooltip: 'Optional doorstep delivery.',
              ),
              if (GsaDataCheckout.instance.orderDraft.paymentType?.price?.centum != null &&
                  GsaDataCheckout.instance.orderDraft.paymentType!.price!.centum! > 0)
                (
                  label: 'Payment',
                  display: '${GsaDataCheckout.instance.orderDraft.paymentType!.price!.formatted()} ${GsaaServiceCurrency.currency.code}',
                  tooltip: 'The additional cost of the specified payment method.',
                ),
              (
                label: 'Total',
                display: GsaDataCheckout.instance.totalPriceFormatted + ' ${GsaaServiceCurrency.currency.code}',
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
                        priceItem.$2.display,
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
}
