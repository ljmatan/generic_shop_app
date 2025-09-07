part of '../route_debug.dart';

class _WidgetLogDetailsData extends StatelessWidget {
  const _WidgetLogDetailsData(
    this.item,
  );

  final ({
    String label,
    Map? value,
  }) item;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: GsaWidgetText(
        item.label,
      ),
      tilePadding: EdgeInsets.zero,
      children: [
        InkWell(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: GsaWidgetText(
                  GsaServiceI18N.instance.jsonEncoder.convert(
                    item.value,
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          onDoubleTap: () async {
            await GsaServiceClipboard.instance.copyToClipboard(
              GsaServiceI18N.instance.jsonEncoder.convert(
                item.value,
              ),
            );
          },
        ),
      ],
    );
  }
}
