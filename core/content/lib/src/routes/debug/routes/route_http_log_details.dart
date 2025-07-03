part of '../route_debug.dart';

class _RouteHttpLogDetails extends GsacRoute {
  const _RouteHttpLogDetails(this.log);

  final GsaApiModelLog log;

  @override
  GsaRouteType get routeType => GsaRoutes.debug;

  @override
  String get displayName => 'HTTP Log Details';

  @override
  String get routeId => 'http-log-details';

  @override
  GsaRouteState<_RouteHttpLogDetails> createState() => _RouteHttpLogDetailsState();
}

class _RouteHttpLogDetailsState extends GsaRouteState<_RouteHttpLogDetails> {
  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GsaWidgetAppBar(
            label: widget.displayName,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              children: [
                Row(
                  children: [
                    GsaWidgetText(
                      widget.log.statusCode.toString() + ' ',
                      style: TextStyle(
                        color: widget.log.statusCode ~/ 2 != 100 ? Colors.red : Colors.green,
                        fontSize: 10,
                      ),
                    ),
                    GsaWidgetText(
                      widget.log.uri.host,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                GsaWidgetText(
                  widget.log.uri.path + '?' + widget.log.uri.query,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 12),
                for (final httpInformation in {
                  (
                    label: 'Request Headers',
                    value: widget.log.requestHeadersFormatted,
                  ),
                  (
                    label: 'Request Body',
                    value: widget.log.requestBodyFormatted,
                  ),
                  (
                    label: 'Response Headers',
                    value: widget.log.responseHeadersFormatted,
                  ),
                  (
                    label: 'Response Body',
                    value: widget.log.responseBodyFormatted,
                  ),
                }) ...[
                  GsaWidgetText(
                    httpInformation.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        child: GsaWidgetText(
                          httpInformation.value,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    onDoubleTap: () async {
                      await Clipboard.setData(
                        ClipboardData(
                          text: httpInformation.value,
                        ),
                      );
                      const GsaWidgetOverlayAlert(
                        'Data copied to clipboard!',
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.share),
        onPressed: () async {
          // TODO
        },
      ),
    );
  }
}
