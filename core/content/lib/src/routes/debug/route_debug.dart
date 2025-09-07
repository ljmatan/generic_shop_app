import 'dart:convert' as dart_convert;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app_content/content.dart';
import 'package:generic_shop_app_data/data.dart';
import 'package:generic_shop_app_services/services.dart';

part 'widgets/widget_logs.dart';
part 'widgets/widget_log_details_app.dart';
part 'widgets/widget_log_details_cache.dart';
part 'widgets/widget_log_details_data.dart';
part 'widgets/widget_log_details_http.dart';
part 'widgets/widget_log_details_route.dart';

part 'routes/route_http_log_details.dart';

/// Route integrated with development / debugging features.
///
class GsaRouteDebug extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteDebug({super.key});

  @override
  bool get translatable {
    return false;
  }

  @override
  State<GsaRouteDebug> createState() => _GsaRouteDebugState();
}

class _GsaRouteDebugState extends GsaRouteState<GsaRouteDebug> {
  int _selectedTabIndex = 0;

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GsaWidgetAppBar(
            label: widget.displayName,
          ),
          DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final buttonLabel in <String>{
                        'HTTP (${GsaApi.logs.length})',
                        'EVENT (${GsaServiceLogging.instance.logs.general.length})',
                        'ERROR (${GsaServiceLogging.instance.logs.error.length})',
                        'METHOD (${GsaServiceLogging.instance.logs.method.length})',
                        'ROUTES (${GsaRoute.observables.length})',
                        'CACHE (${GsaServiceCache.instance.cachedKeys?.length})',
                        'DATA',
                        'STRINGS',
                      }.indexed) ...[
                        if (buttonLabel.$1 != 0) const SizedBox(width: 10),
                        GsaWidgetButton.text(
                          label: buttonLabel.$2,
                          foregroundColor: _selectedTabIndex == buttonLabel.$1 ? Theme.of(context).primaryColor : Colors.grey,
                          onTap: () {
                            if (_selectedTabIndex != buttonLabel.$1) {
                              setState(() {
                                _selectedTabIndex = buttonLabel.$1;
                              });
                            }
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: switch (_selectedTabIndex) {
              0 => _WidgetLogs<GsaApiModelLog>(
                  label: 'HTTP Network Calls',
                  collection: GsaApi.logs.reversed,
                  itemBuilder: (item) {
                    return _WidgetLogDetailsHttp(item);
                  },
                ),
              1 => _WidgetLogs<GsaServiceLoggingModelAppLog>(
                  label: 'App logs and debug information.',
                  collection: GsaServiceLogging.instance.logs.general.reversed,
                  itemBuilder: (item) {
                    return _WidgetLogDetailsApp(item);
                  },
                ),
              2 => _WidgetLogs<GsaServiceLoggingModelAppLog>(
                  label: 'Any encountred exceptions or errors.',
                  collection: GsaServiceLogging.instance.logs.error.reversed,
                  itemBuilder: (item) {
                    return _WidgetLogDetailsApp(item);
                  },
                ),
              3 => _WidgetLogs<GsaServiceLoggingModelAppLog>(
                  label: 'App method calls recorded by the app.',
                  collection: GsaServiceLogging.instance.logs.method.reversed,
                  itemBuilder: (item) {
                    return _WidgetLogDetailsApp(item);
                  },
                ),
              4 => _WidgetLogs<GsaRouteState<GsaRoute>>(
                  label: 'Routes being observed for navigation events.',
                  collection: GsaRoute.observables.reversed,
                  itemBuilder: (item) {
                    return _WidgetLogDetailsRoute(item);
                  },
                ),
              5 => _WidgetLogs<String>(
                  label: 'Cache keys and their corresponding values.',
                  hint: 'Double tap a value to copy it to the clipboard.',
                  collection: GsaServiceCache.instance.cachedKeys,
                  itemBuilder: (item) {
                    return _WidgetLogDetailsCache(item);
                  },
                ),
              6 => _WidgetLogs<
                    ({
                      String label,
                      Map? value,
                    })>(
                  label: 'Active runtime data values.',
                  hint: 'Double tap a value to copy it to the clipboard.',
                  collection: {
                    (
                      label: 'User',
                      value: GsaDataUser.instance.user?.toJson(),
                    ),
                    (
                      label: 'Merchant',
                      value: GsaDataMerchant.instance.merchant?.toJson(),
                    ),
                    (
                      label: 'Clients',
                      value: {
                        'collection': GsaDataClients.instance.collection.map(
                          (client) {
                            return client.toJson();
                          },
                        ).toList(),
                      },
                    ),
                    (
                      label: 'Sale Items',
                      value: {
                        'collection': GsaDataSaleItems.instance.collection.map(
                          (saleItem) {
                            return saleItem.toJson();
                          },
                        ).toList(),
                      },
                    ),
                    (
                      label: 'Checkout',
                      value: GsaDataCheckout.instance.orderDraft.toJson(),
                    ),
                  },
                  itemBuilder: (item) {
                    return _WidgetLogDetailsData(item);
                  },
                ),
              7 => _WidgetLogs<String>(
                  label: 'Translatable strings and their current values.',
                  hint: 'Double tap a value to copy it to the clipboard.',
                  collection: [
                    GsaServiceI18N.instance.translationValuesJsonEncoded,
                  ],
                  itemBuilder: (item) => InkWell(
                    child: GsaWidgetText(
                      item,
                    ),
                    onDoubleTap: () async {
                      await GsaServiceClipboard.instance.copyToClipboard(
                        GsaServiceI18N.instance.translationValuesJsonEncoded,
                      );
                    },
                  ),
                ),
              int() => throw UnimplementedError(
                  'Index $_selectedTabIndex not implemented with debug route tabs.',
                ),
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: const Icon(Icons.share),
        onPressed: () async {
          await GsaServiceShare.instance.shareFile(
            Uint8List.fromList(
              dart_convert.utf8.encode(
                dart_convert.jsonEncode(
                  {
                    'http': [
                      for (final log in GsaApi.logs) log.toJson(),
                    ],
                    'event': [
                      for (final log in GsaServiceLogging.instance.logs.general) log.toJson(),
                    ],
                    'error': [
                      for (final log in GsaServiceLogging.instance.logs.error) log.toJson(),
                    ],
                    'cache': [
                      if (GsaServiceCache.instance.cachedKeys != null)
                        for (final key in GsaServiceCache.instance.cachedKeys!)
                          {
                            key: GsaServiceCache.instance.valueWithKey(key),
                          },
                    ],
                    'data': [
                      for (final dataPoint in <({
                        String label,
                        Map? value,
                      })>{
                        (
                          label: 'User',
                          value: GsaDataUser.instance.user?.toJson(),
                        ),
                        (
                          label: 'Merchant',
                          value: GsaDataMerchant.instance.merchant?.toJson(),
                        ),
                        (
                          label: 'Clients',
                          value: {
                            'collection': GsaDataClients.instance.collection.map(
                              (client) {
                                return client.toJson();
                              },
                            ).toList(),
                          },
                        ),
                        (
                          label: 'Sale Items',
                          value: {
                            'collection': GsaDataSaleItems.instance.collection.map(
                              (saleItem) {
                                return saleItem.toJson();
                              },
                            ).toList(),
                          },
                        ),
                        (
                          label: 'Checkout',
                          value: GsaDataCheckout.instance.orderDraft.toJson(),
                        ),
                      })
                        {
                          dataPoint.label: dataPoint.value,
                        },
                    ],
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
