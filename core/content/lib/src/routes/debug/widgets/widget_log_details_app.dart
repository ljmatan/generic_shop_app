part of '../route_debug.dart';

class _WidgetLogDetailsApp extends StatelessWidget {
  const _WidgetLogDetailsApp(
    this.log,
  );

  final GsaServiceLoggingModelAppLog log;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GsaWidgetText(
              log.time.toIso8601String(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 8),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                child: GsaWidgetText(
                  log.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GsaWidgetText(
              '${log.fileName}',
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 6),
            GsaWidgetText(
              '${log.className}.${log.method}',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            if (log.callerFrames != null) ...[
              for (final callerFrame in log.callerFrames!.indexed) ...[
                const Divider(),
                const SizedBox(height: 6),
                GsaWidgetText(
                  '${callerFrame.$2.source}',
                  style: const TextStyle(
                    fontSize: 8,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                GsaWidgetText.rich(
                  [
                    GsaWidgetTextSpan(
                      '#${callerFrame.$1 + 1} ',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    GsaWidgetTextSpan(
                      '${callerFrame.$2.className}.${callerFrame.$2.method}',
                    ),
                  ],
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 6),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
