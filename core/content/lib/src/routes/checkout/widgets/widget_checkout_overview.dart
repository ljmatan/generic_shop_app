part of '../route_checkout.dart';

class _WidgetCheckoutOverview extends StatefulWidget {
  const _WidgetCheckoutOverview();

  @override
  State<_WidgetCheckoutOverview> createState() => _WidgetCheckoutOverviewState();
}

class _WidgetCheckoutOverviewState extends State<_WidgetCheckoutOverview> {
  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      children: [
        if (GsaDataCheckout.instance.orderDraft.deliveryType != null) ...[
          GsaWidgetHeadline(
            'Delivery',
            action: (
              label: 'EDIT',
              onTap: () {},
            ),
          ),
          GsaWidgetText(
            GsaDataCheckout.instance.orderDraft.deliveryType!.name ?? 'N/A',
          ),
          if (GsaDataCheckout.instance.orderDraft.deliveryType!.description != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: GsaWidgetText(
                GsaDataCheckout.instance.orderDraft.deliveryType!.description!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          if (GsaDataCheckout.instance.orderDraft.paymentType == null) const SizedBox(height: 10),
        ],
        if (GsaDataCheckout.instance.orderDraft.paymentType != null) ...[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GsaWidgetHeadline(
              'Payment',
              action: (
                label: 'EDIT',
                onTap: () {},
              ),
            ),
          ),
          GsaWidgetText(
            GsaDataCheckout.instance.orderDraft.paymentType!.name ?? 'N/A',
          ),
          if (GsaDataCheckout.instance.orderDraft.deliveryType!.description != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: GsaWidgetText(
                GsaDataCheckout.instance.orderDraft.deliveryType!.description!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 10),
        const GsaWidgetHeadline('Cart Items'),
        const GsaWidgetText(
          'Cart item prices may deviate from actual costs due to factors like promotions, taxes, and occasional errors. '
          'For precise totals, verify the information with the merchant.',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 16),
        for (final product in GsaDataCheckout.instance.orderDraft.items.indexed)
          Padding(
            padding: product.$1 == 0 ? EdgeInsets.zero : const EdgeInsets.only(top: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.$2.imageUrls?.isNotEmpty == true)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GsaWidgetImage.network(
                        product.$2.imageUrls![0],
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                Flexible(
                  child: SizedBox(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GsaWidgetText(
                            product.$2.name ?? 'N/A',
                            maxLines: 2,
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                            ),
                          ),
                          Row(
                            children: [
                              GsaWidgetText(
                                '${product.$2.cartCount()} × ${product.$2.price?.formatted()} ${GsaConfig.currency.code} ',
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              GsaWidgetText(
                                ' ${((product.$2.cartCount() ?? 0) * (product.$2.price?.unity ?? 0)).toStringAsFixed(2)} ${GsaConfig.currency.code}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 20),
        const GsaWidgetTotalCartPrice(),
        const SizedBox(height: 20),
        const GsaWidgetHeadline('Terms and Conditions'),
        const SizedBox(height: 6),
        GsaWidgetTermsConfirmation(
          value: _termsAccepted,
          onValueChanged: (value) => setState(() => _termsAccepted = !_termsAccepted),
        ),
        const SizedBox(height: 16),
        FilledButton(
          child: const GsaWidgetText(
            'Confirm Order',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          onPressed: _termsAccepted
              ? () async {
                  GsaWidgetOverlayContentBlocking().openDialog(context);
                  await Future.delayed(const Duration(seconds: 2));
                  GsaDataCheckout.instance.clear();
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.of(context).pushNamed('order-status');
                }
              : null,
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom),
      ],
    );
  }
}
