part of '../../page_preview.dart';

class _WidgetMenuSectionClient extends StatefulWidget {
  const _WidgetMenuSectionClient({
    required this.state,
  });

  final _GscPagePreviewState state;

  @override
  State<_WidgetMenuSectionClient> createState() => _WidgetMenuSectionClientState();
}

class _WidgetMenuSectionClientState extends State<_WidgetMenuSectionClient> {
  void _setClient(GsaPlugin value) async {
    await GsaData.clearAll();
    widget.state._plugin = value;
    widget.state.setState(() {});
  }

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
          initialSelection: widget.state._plugin,
          dropdownMenuEntries: [
            for (final provider in GscPlugin.pluginCollection)
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
            _setClient(value);
          },
        ),
      ],
    );
  }
}
