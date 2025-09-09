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
      description: 'Plugin client selection.',
      initiallyExpanded: true,
      children: [
        GsaWidgetDropdownMenu<GsaPlugin>(
          labelText: 'Provider',
          enableFilter: false,
          enableSearch: false,
          initialSelection: state._plugin,
          dropdownMenuEntries: [
            for (final provider in GsdPlugin.pluginCollection)
              DropdownMenuEntry(
                label: provider.client.name,
                value: provider,
              ),
          ],
          onSelected: (value) async {
            if (value == null) {
              throw Exception(
                'The specified provider value must not be null.',
              );
            }
            state._plugin = value;
            state.rebuild();
          },
        ),
      ],
    );
  }
}
