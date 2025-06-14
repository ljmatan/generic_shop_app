part of '../route_debug.dart';

class _WidgetHttpLogDetails extends StatelessWidget {
  const _WidgetHttpLogDetails(this.log);

  final GsaApiModelLog log;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GsaWidgetText(
                'Request start at ' +
                    log.requestTimeFormatted() +
                    ', finished in ${log.responseTime.difference(log.requestTime).inMilliseconds}ms',
                style: TextStyle(
                  fontSize: 8,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  GsaWidgetText(
                    log.statusCode.toString() + ' ',
                    style: TextStyle(
                      color: log.statusCode ~/ 2 != 100 ? Colors.red : Colors.green,
                      fontSize: 10,
                    ),
                  ),
                  GsaWidgetText(
                    log.uri.host,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              GsaWidgetText(
                log.uri.path,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 12),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: GsaWidgetText(
                      log.responseBodyFormatted.length > 200
                          ? '${log.responseBodyFormatted.substring(0, 200)}...'
                          : log.responseBodyFormatted,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => _RouteHttpLogDetails(log),
          ),
        );
      },
    );
  }
}
