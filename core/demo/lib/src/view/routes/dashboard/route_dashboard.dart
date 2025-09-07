import 'package:flutter/material.dart';
import 'package:generic_shop_app_demo/demo.dart';

class GsdRouteDashboard extends GsdRoute {
  const GsdRouteDashboard({super.key});

  @override
  GsaRouteState<GsdRouteDashboard> createState() => _GsdRouteDashboardState();
}

class _GsdRouteDashboardState extends GsaRouteState<GsdRouteDashboard> {
  int _selectedTabIndex = 0;

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 16,
              ),
              child: Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GsaWidgetText(
                          'GSA',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 24),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  for (final tab in const <String>{
                    'Client',
                    'Widgets',
                  }.indexed) ...[
                    if (tab.$1 != 0) const SizedBox(width: 12),
                    GsaWidgetButton.text(
                      label: tab.$2,
                      onTap: _selectedTabIndex == tab.$1
                          ? null
                          : () {
                              setState(() {
                                _selectedTabIndex = tab.$1;
                              });
                            },
                    ),
                  ],
                ],
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: switch (_selectedTabIndex) {
              0 => GsdRoutePreview(),
              1 => GsdRouteComponents(),
              int() => throw UnimplementedError(
                  'Tab index $_selectedTabIndex not implemented with GsdRouteDashboard.',
                )
            },
          ),
        ],
      ),
    );
  }
}
