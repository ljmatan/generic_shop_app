import 'package:flutter/material.dart';
import 'package:generic_shop_app_cms/cms.dart';

class GscRouteDashboard extends GscRoute {
  const GscRouteDashboard({
    super.key,
  });

  @override
  GsaRouteState<GscRouteDashboard> createState() => _GscRouteDashboardState();
}

class _GscRouteDashboardState extends GsaRouteState<GscRouteDashboard> {
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
                horizontal: GsaTheme.of(context).paddings.widget.listViewHorizontal,
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
                      backgroundColor: tab.$1 == _selectedTabIndex ? Colors.white10 : Colors.transparent,
                      foregroundColor: tab.$1 == _selectedTabIndex ? Colors.white : Colors.grey,
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
              0 => const GscPagePreview(),
              1 => const GscPageRoutes(),
              2 => const GscPageComponents(),
              int() => throw UnimplementedError(
                'Tab index $_selectedTabIndex not implemented with GscRouteDashboard.',
              ),
            },
          ),
        ],
      ),
    );
  }
}
