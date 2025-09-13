part of '../route_checkout.dart';

class _WidgetCheckoutOverview extends StatefulWidget {
  const _WidgetCheckoutOverview({
    required this.state,
  });

  final _GsaRouteCheckoutState state;

  @override
  State<_WidgetCheckoutOverview> createState() => _WidgetCheckoutOverviewState();
}

class _WidgetCheckoutOverviewState extends State<_WidgetCheckoutOverview> {
  bool _termsAccepted = false;

  final _checkboxKey = GlobalKey<GsaWidgetSwitchState>();

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
              onTap: () async {
                await widget.state._goToStep(0);
              },
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
                onTap: () async {
                  await widget.state._goToStep(
                    GsaDataCheckout.instance.orderDraft.deliveryType != null ? 1 : 0,
                  );
                },
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
        GsaWidgetText(
          'Cart item prices may deviate from actual costs due to factors like '
          'promotions, taxes, and occasional errors. '
          'For precise totals, verify the information with the merchant.',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),
        for (final saleItem in GsaDataCheckout.instance.orderDraft.items.indexed)
          Padding(
            padding: saleItem.$1 == 0 ? EdgeInsets.zero : const EdgeInsets.only(top: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: saleItem.$2.imageUrls?.isNotEmpty == true
                          ? GsaWidgetImage.network(
                              saleItem.$2.imageUrls![0],
                              width: 60,
                              height: 60,
                            )
                          : GsaWidgetImage.placeholder(
                              width: 60,
                              height: 60,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  width: GsaTheme.of(context).paddings.content.small,
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
                            saleItem.$2.name ?? 'N/A',
                            maxLines: 2,
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                            ),
                          ),
                          Row(
                            children: [
                              GsaWidgetText(
                                '${saleItem.$2.cartCount()} x ${saleItem.$2.price?.formatted} '
                                '${GsaConfig.currency.code} ',
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              GsaWidgetText(
                                ' ${((saleItem.$2.cartCount() ?? 0) * (saleItem.$2.price?.unity ?? 0)).toStringAsFixed(2)} ${GsaConfig.currency.code}',
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
          onValueChanged: (newValue) {
            setState(() {
              _termsAccepted = newValue;
            });
          },
          checkboxKey: _checkboxKey,
        ),
        const SizedBox(height: 16),
        GsaWidgetButton.filled(
          label: 'Confirm Order',
          backgroundColor: _termsAccepted ? null : Colors.grey,
          onTap: _termsAccepted
              ? () async {
                  const GsaWidgetOverlayContentBlocking().openDialog();
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.pop(context);
                  const GsaRouteOrderStatus().push();
                }
              : () {
                  _checkboxKey.currentState?.validate();
                },
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        ),
      ],
    );
  }
}
