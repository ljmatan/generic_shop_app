import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

part 'widgets/widget_http_log_details.dart';
part 'routes/route_http_log_details.dart';

/// Route integrated with development / debugging features.
///
class GsaRouteDebug extends GsarRoute {
  // ignore: public_member_api_docs
  const GsaRouteDebug({super.key});

  @override
  State<GsaRouteDebug> createState() => _GsaRouteDebugState();

  @override
  String get routeId => 'debug';

  @override
  String get displayName => 'Debug';
}

class _GsaRouteDebugState extends GsarRouteState<GsaRouteDebug> {
  final _tabNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
      body: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                for (final buttonLabel in <String>{
                  'HTTP (${GsarApi.logs.length})',
                  'APP ()',
                }.indexed)
                  Expanded(
                    child: TextButton(
                      child: Text(
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
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: switch (_tabNotifier.value) {
                0 => [
                    for (final log in GsarApi.logs.reversed.indexed)
                      Padding(
                        padding: log.$1 == 0 ? EdgeInsets.zero : const EdgeInsets.only(top: 10),
                        child: _WidgetHttpLogDetails(log.$2),
                      ),
                  ],
                1 => [],
                int() => throw UnimplementedError(),
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: Icon(Icons.share),
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
