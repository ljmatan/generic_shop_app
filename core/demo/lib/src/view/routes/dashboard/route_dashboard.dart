import 'package:flutter/material.dart';
import 'package:generic_shop_app_demo/demo.dart';

class GsdRouteDashboard extends GsdRoute {
  const GsdRouteDashboard({
    super.key,
  });

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
              color: Colors.grey.shade900,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: GsaTheme.of(context).paddings.listViewHorizontal(),
                vertical: 20,
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
                            color: Colors.white,
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
                    'Routes',
                    'Widgets',
                  }.indexed) ...[
                    if (tab.$1 != 0) const SizedBox(width: 12),
                    GsaWidgetButton.filled(
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
                  const Spacer(),
                  GsaWidgetButton.outlined(
                    label: 'Export Configuration',
                    icon: Icons.exit_to_app,
                    onTap: () {
                      // TODO
                    },
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: switch (_selectedTabIndex) {
              0 => const GsdRoutePreview(),
              1 => const GsdRouteRoutes(),
              2 => const GsdRouteWidgets(),
              int() => throw UnimplementedError(
                  'Tab index $_selectedTabIndex not implemented with GsdRouteDashboard.',
                ),
            },
          ),
        ],
      ),
    );
  }
}
