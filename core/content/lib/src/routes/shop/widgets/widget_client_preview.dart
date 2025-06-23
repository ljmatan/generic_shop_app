part of '../route_shop.dart';

class _WidgetClientPreview extends StatelessWidget {
  _WidgetClientPreview();

  final client = GsaDataCheckout.instance.orderDraft.client;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: GsaTheme.instance.contentPadding.horizontal / 2,
      ),
      child: InkWell(
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
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          child: GsaWidgetText(
                            'Client',
                            style: TextStyle(
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
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (client?.contactDetails?.personalDetails?.formattedName != null) ...[
                    const SizedBox(height: 8),
                    GsaWidgetText(
                      '${GsaDataCheckout.instance.orderDraft.client?.contactDetails?.personalDetails?.formattedName}',
                    ),
                  ],
                  if (client?.contactDetails?.addressDetails?.addressFormatted != null) ...[
                    const SizedBox(height: 8),
                    GsaWidgetText(
                      '${client?.contactDetails?.addressDetails?.addressFormatted}',
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
      ),
    );
  }
}
