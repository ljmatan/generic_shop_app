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
      child: SizedBox(
        width: 400,
        child: ListView(
          padding: Theme.of(context).paddings.listView(),
          children: [
            _WidgetMenuSectionDevice(
              state: widget.state,
            ),
            const SizedBox(height: 20),
            _WidgetMenuSectionClient(
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
    );
  }
}
