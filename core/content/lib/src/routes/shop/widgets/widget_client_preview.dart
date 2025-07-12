part of '../route_shop.dart';

class _WidgetClientPreview extends StatelessWidget {
  _WidgetClientPreview();

  final client = GsaDataCheckout.instance.orderDraft.client;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        child: GsaWidgetText(
                          'Client',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (client?.personalDetails?.formattedName != null) ...[
                      const SizedBox(width: 8),
                      Expanded(
                        child: GsaWidgetText(
                          '${GsaDataCheckout.instance.orderDraft.client?.personalDetails?.formattedName}',
                          interpolated: true,
                        ),
                      ),
                    ],
                  ],
                ),
                if (client?.contactDetails?.personalDetails?.formattedName != null) ...[
                  const SizedBox(height: 8),
                  GsaWidgetText(
                    '${GsaDataCheckout.instance.orderDraft.client?.contactDetails?.personalDetails?.formattedName}',
                    interpolated: true,
                  ),
                ],
                if (client?.contactDetails?.addressDetails?.addressFormatted != null) ...[
                  const SizedBox(height: 8),
                  GsaWidgetText(
                    '${client?.contactDetails?.addressDetails?.addressFormatted}',
                    interpolated: true,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
