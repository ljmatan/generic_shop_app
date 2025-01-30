part of '../route_debug.dart';

class _WidgetHttpLogDetails extends StatelessWidget {
  const _WidgetHttpLogDetails(this.log);

  final GsarApiModelLog log;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    log.statusCode.toString() + ' ',
                    style: TextStyle(
                      color: log.statusCode ~/ 2 != 100 ? Colors.red : Colors.green,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    log.uri.host,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
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
                    child: Text(
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
        const _RouteHttpLogDetails().navigate(context);
      },
    );
  }
}
