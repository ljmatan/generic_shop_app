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
            child: ListView(
              padding: Theme.of(context).listViewPadding,
              children: switch (_selectedTabIndex) {
                0 => [
                    if (GsaApi.logs.isNotEmpty)
                      for (final log in GsaApi.logs.reversed.indexed) ...[
                        if (log.$1 != 0) const SizedBox(height: 10),
                        _WidgetHttpLogDetails(log.$2),
                      ]
                    else
                      GsaWidgetText(
                        'No entries found.',
                      ),
                  ],
                1 => [
                    GsaWidgetText(
                      'App logs and debug information are recorded to this list.',
                    ),
                    const SizedBox(height: 16),
                    if (GsaServiceLogging.instance.logs.general.isNotEmpty)
                      for (final log in GsaServiceLogging.instance.logs.general.reversed.indexed) ...[
                        if (log.$1 != 0) const SizedBox(height: 10),
                        _WidgetAppLogDetails(log.$2),
                      ]
                    else
                      GsaWidgetText(
                        'No entries found.',
                      ),
                  ],
                2 => [
                    GsaWidgetText(
                      'Any encountred exceptions should be recorded to this list.',
                    ),
                    const SizedBox(height: 16),
                    if (GsaServiceLogging.instance.logs.error.isNotEmpty)
                      for (final log in GsaServiceLogging.instance.logs.error.reversed.indexed) ...[
                        if (log.$1 != 0) const SizedBox(height: 10),
                        _WidgetAppLogDetails(log.$2),
                      ]
                    else
                      GsaWidgetText(
                        'No entries found.',
                      ),
                  ],
                3 => [
                    GsaWidgetText.rich(
                      const [
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
                                          return GsaServiceI18N.instance.jsonEncoder.convert(
                                            dart_convert.jsonDecode(
                                              GsaServiceCache.instance
                                                  .valueWithKey(
                                                    key.$2,
                                                  )
                                                  .toString(),
                                            ),
                                          );
                                        } catch (e) {
                                          return GsaServiceI18N.instance.jsonEncoder.convert(
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
                                await GsaServiceClipboard.instance.copyToClipboard(
                                  GsaServiceCache.instance
                                      .valueWithKey(
                                        key.$2,
                                      )
                                      .toString(),
                                );
                              },
                            ),
                          ],
                        )
                    else
                      GsaWidgetText(
                        'No entries found.',
                      ),
                  ],
                4 => [
                    GsaWidgetText.rich(
                      const [
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
                                    GsaServiceI18N.instance.jsonEncoder.convert(
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
                              await GsaServiceClipboard.instance.copyToClipboard(
                                GsaServiceI18N.instance.jsonEncoder.convert(
                                  dataPoint.value,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ],
                5 => [
                    InkWell(
                      child: GsaWidgetText(
                        GsaServiceI18N.instance.translationValuesJsonEncoded,
                      ),
                      onDoubleTap: () async {
                        await GsaServiceClipboard.instance.copyToClipboard(
                          GsaServiceI18N.instance.translationValuesJsonEncoded,
                        );
                      },
                    ),
                  ],
                int() => throw UnimplementedError(),
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
