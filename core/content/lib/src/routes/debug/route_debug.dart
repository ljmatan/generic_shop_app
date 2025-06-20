import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_services/services.dart';

part 'widgets/widget_app_log_details.dart';
part 'widgets/widget_http_log_details.dart';
part 'routes/route_http_log_details.dart';

/// Route integrated with development / debugging features.
///
class GsaRouteDebug extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteDebug({super.key});

  @override
  State<GsaRouteDebug> createState() => _GsaRouteDebugState();
}

class _GsaRouteDebugState extends GsaRouteState<GsaRouteDebug> {
  final _tabNotifier = ValueNotifier<int>(0);

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          GsaWidgetAppBar(
            label: widget.displayName,
          ),
          DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ValueListenableBuilder(
              valueListenable: _tabNotifier,
              builder: (context, value, child) {
                return Row(
                  children: [
                    for (final buttonLabel in <String>{
                      'HTTP (${GsaApi.logs.length})',
                      'EVENT (${GsaServiceLogging.instance.logs.general.length})',
                      'ERROR (${GsaServiceLogging.instance.logs.error.length})',
                      'CACHE (${GsaServiceCache.instance.cachedKeys?.length})',
                    }.indexed)
                      Expanded(
                        child: TextButton(
                          child: GsaWidgetText(
                            buttonLabel.$2,
                            style: TextStyle(
                              color: _tabNotifier.value == buttonLabel.$1 ? null : Colors.grey,
                              fontWeight: _tabNotifier.value == buttonLabel.$1 ? null : FontWeight.w300,
                            ),
                          ),
                          onPressed: () {
                            _tabNotifier.value = buttonLabel.$1;
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _tabNotifier,
              builder: (context, value, child) {
                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  children: switch (_tabNotifier.value) {
                    0 => [
                        if (GsaApi.logs.isNotEmpty)
                          for (final log in GsaApi.logs.reversed.indexed) ...[
                            if (log.$1 != 0) const SizedBox(height: 10),
                            _WidgetHttpLogDetails(log.$2),
                          ]
                        else
                          const GsaWidgetText(
                            'No entries found.',
                          ),
                      ],
                    1 => [
                        if (GsaServiceLogging.instance.logs.general.isNotEmpty)
                          for (final log in GsaServiceLogging.instance.logs.general.reversed.indexed) ...[
                            if (log.$1 != 0) const SizedBox(height: 10),
                            _WidgetAppLogDetails(log.$2),
                          ]
                        else
                          const GsaWidgetText(
                            'No entries found.',
                          ),
                      ],
                    2 => [
                        if (GsaServiceLogging.instance.logs.error.isNotEmpty)
                          for (final log in GsaServiceLogging.instance.logs.error.reversed.indexed) ...[
                            if (log.$1 != 0) const SizedBox(height: 10),
                            _WidgetAppLogDetails(log.$2),
                          ]
                        else
                          const GsaWidgetText(
                            'No entries found.',
                          ),
                      ],
                    3 => [
                        if (GsaServiceCache.instance.cachedKeys != null)
                          for (final key in GsaServiceCache.instance.cachedKeys!.indexed) ...[
                            if (key.$1 != 0) const SizedBox(height: 10),
                            GsaWidgetText.rich(
                              [
                                GsaWidgetTextSpan(
                                  '${key.$2}: ',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                GsaWidgetTextSpan(
                                  GsaServiceCache.instance.valueWithKey(key.$2).toString(),
                                ),
                              ],
                            ),
                          ]
                        else
                          const GsaWidgetText(
                            'No entries found.',
                          ),
                      ],
                    int() => throw UnimplementedError(),
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: const Icon(Icons.share),
        onPressed: () async {
          // TODO
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabNotifier.dispose();
    super.dispose();
  }
}
