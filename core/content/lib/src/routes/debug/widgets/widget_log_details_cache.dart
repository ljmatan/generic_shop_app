part of '../route_debug.dart';

class _WidgetLogDetailsCache extends StatelessWidget {
  const _WidgetLogDetailsCache(
    this.cacheKey,
  );

  final String cacheKey;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: GsaWidgetText(
        cacheKey,
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
                  () {
                    try {
                      return GsaServiceI18N.instance.jsonEncoder.convert(
                        dart_convert.jsonDecode(
                          GsaServiceCache.instance
                              .valueWithKey(
                                cacheKey,
                              )
                              .toString(),
                        ),
                      );
                    } catch (e) {
                      return GsaServiceI18N.instance.jsonEncoder.convert(
                        GsaServiceCache.instance.valueWithKey(
                          cacheKey,
                        ),
                      );
                    }
                  }(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          onDoubleTap: () async {
            await GsaServiceClipboard.instance.copyToClipboard(
              GsaServiceCache.instance
                  .valueWithKey(
                    cacheKey,
                  )
                  .toString(),
            );
          },
        ),
      ],
    );
  }
}
