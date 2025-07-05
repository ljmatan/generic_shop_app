import 'dart:convert' as dart_convert;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_data/data.dart';
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

  final _jsonEncoder = dart_convert.JsonEncoder.withIndent(' ' * 2);

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
                return SizedBox(
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
                            'CACHE (${GsaServiceCache.instance.cachedKeys?.length})',
                            'DATA',
                          }.indexed) ...[
                            if (buttonLabel.$1 != 0) const SizedBox(width: 10),
                            TextButton(
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
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _tabNotifier,
              builder: (context, value, child) {
                return ListView(
                  padding: Theme.of(context).listViewPadding,
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
                        const GsaWidgetText.rich(
                          [
                            GsaWidgetTextSpan(
                              'Below are the currently cached keys and their corresponding values.\n\n',
                            ),
                            GsaWidgetTextSpan(
                              'You can double tap on a value to copy it to the clipboard.',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (GsaServiceCache.instance.cachedKeys != null)
                          for (final key in GsaServiceCache.instance.cachedKeys!.indexed)
                            ExpansionTile(
                              title: GsaWidgetText(
                                key.$2,
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
                                              return _jsonEncoder.convert(
                                                dart_convert.jsonDecode(
                                                  GsaServiceCache.instance
                                                      .valueWithKey(
                                                        key.$2,
                                                      )
                                                      .toString(),
                                                ),
                                              );
                                            } catch (e) {
                                              return _jsonEncoder.convert(
                                                GsaServiceCache.instance.valueWithKey(
                                                  key.$2,
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
                                    Clipboard.setData(
                                      ClipboardData(
                                        text: GsaServiceCache.instance
                                            .valueWithKey(
                                              key.$2,
                                            )
                                            .toString(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                        else
                          const GsaWidgetText(
                            'No entries found.',
                          ),
                      ],
                    4 => [
                        const GsaWidgetText.rich(
                          [
                            GsaWidgetTextSpan(
                              'Noted below are active runtime data values.\n\n',
                            ),
                            GsaWidgetTextSpan(
                              'You can double tap on a value to copy it to the clipboard.',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
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
                        }) ...[
                          ExpansionTile(
                            title: GsaWidgetText(
                              dataPoint.label,
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
                                        _jsonEncoder.convert(
                                          dataPoint.value,
                                        ),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onDoubleTap: () async {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: _jsonEncoder.convert(
                                        dataPoint.value,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
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
                          () {
                            try {
                              return dart_convert.jsonDecode(
                                GsaServiceCache.instance.valueWithKey(key).toString(),
                              );
                            } catch (e) {
                              return GsaServiceCache.instance.valueWithKey(key);
                            }
                          }(),
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

  @override
  void dispose() {
    _tabNotifier.dispose();
    super.dispose();
  }
}
