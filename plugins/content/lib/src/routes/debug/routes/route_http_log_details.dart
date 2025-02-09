part of '../route_debug.dart';

class _RouteHttpLogDetails extends GsacRoute {
  const _RouteHttpLogDetails(this.log);

  final GsaApiModelLog log;

  @override
  String get displayName => 'http-log-details';

  @override
  String get routeId => 'HTTP Log Details';

  @override
  GsaRouteState<_RouteHttpLogDetails> createState() => __RouteHttpLogDetailsState();
}

class __RouteHttpLogDetailsState extends GsaRouteState<_RouteHttpLogDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.displayName,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        children: [
          Row(
            children: [
              Text(
                widget.log.statusCode.toString() + ' ',
                style: TextStyle(
                  color: widget.log.statusCode ~/ 2 != 100 ? Colors.red : Colors.green,
                  fontSize: 10,
                ),
              ),
              Text(
                widget.log.uri.host,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            widget.log.uri.path,
            style: TextStyle(
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
            Text(
              httpInformation.label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Text(
                  httpInformation.value,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.share),
        onPressed: () async {
          // TODO
        },
      ),
    );
  }
}
