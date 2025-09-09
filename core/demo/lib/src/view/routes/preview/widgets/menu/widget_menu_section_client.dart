part of '../../route_preview.dart';

class _WidgetMenuSectionClient extends StatelessWidget {
  const _WidgetMenuSectionClient({
    required this.state,
  });

  final _GsdRoutePreviewState state;

  @override
  Widget build(BuildContext context) {
    return _WidgetMenuSection(
      label: 'Client',
      description: 'Client and route selection.',
      children: [
        GsaWidgetDropdownMenu<GsaPluginClient>(
          labelText: 'Provider',
          enableFilter: false,
          enableSearch: false,
          initialSelection: state._pluginClient,
          dropdownMenuEntries: [
            for (final provider in GsaPluginClient.values)
              DropdownMenuEntry(
                label: provider.name,
                value: provider,
              ),
          ],
          onSelected: (value) async {
            if (value == null) {
              throw Exception(
                'The specified provider value must not be null.',
              );
            }
            state._setClient(value);
          },
        ),
        const SizedBox(height: 20),
        GsaWidgetDropdownMenu(
          key: state._routeDropdownKey,
          labelText: 'Route',
          enableFilter: false,
          enableSearch: false,
          initialSelection: state._routeIndex,
          dropdownMenuEntries: [
            for (final route in state._routes.indexed)
              DropdownMenuEntry(
                label: route.$2.displayName,
                value: route.$1,
              ),
          ],
          onSelected: (value) {
            if (value == null) {
              throw Exception(
                'The specified route value must not be null.',
              );
            }
            state._routeIndex = value;
            GsaRoute.navigatorKey = GlobalKey<NavigatorState>();
            state.rebuild();
          },
        ),
      ],
    );
  }
}
