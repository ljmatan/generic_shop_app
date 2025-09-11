part of '../../route_preview.dart';

class _WidgetMenu extends StatefulWidget {
  const _WidgetMenu({
    required this.state,
  });

  final _GsdRoutePreviewState state;

  @override
  State<_WidgetMenu> createState() => _WidgetMenuState();
}

class _WidgetMenuState extends State<_WidgetMenu> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 600,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  padding: GsaTheme.of(context).paddings.widget.listView,
                  children: [
                    _WidgetMenuSectionClient(
                      state: widget.state,
                    ),
                    const SizedBox(height: 20),
                    _WidgetMenuSectionDevice(
                      state: widget.state,
                    ),
                    const SizedBox(height: 20),
                    _WidgetMenuSectionFeatures(
                      state: widget.state,
                    ),
                    const SizedBox(height: 20),
                    _WidgetMenuSectionTheme(
                      state: widget.state,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const Divider(),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: GsaWidgetButton.text(
                    label: 'Export Configuration',
                    foregroundColor: Colors.white,
                    onTap: () {
                      // TODO
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
