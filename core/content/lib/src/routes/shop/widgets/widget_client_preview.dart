part of '../route_shop.dart';

class _WidgetClientPreview extends StatelessWidget {
  const _WidgetClientPreview();

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
                  GsaWidgetText(
                    'Client Details',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  if (GsaDataCheckout.instance.orderDraft.client?.personalDetails?.formattedName != null)
                    GsaWidgetText(
                      '${GsaDataCheckout.instance.orderDraft.client?.personalDetails?.formattedName}',
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
