part of '../../page_preview.dart';

class _WidgetMenuSectionFeatures extends StatefulWidget {
  const _WidgetMenuSectionFeatures({
    required this.state,
  });

  final _GscPagePreviewState state;

  @override
  State<_WidgetMenuSectionFeatures> createState() => _WidgetMenuSectionFeaturesState();
}

class _WidgetMenuSectionFeaturesState extends State<_WidgetMenuSectionFeatures> {
  @override
  Widget build(BuildContext context) {
    return _WidgetMenuSection(
      label: 'Features',
      description: 'Specify available app functionalities.',
      children: [
        for (final option in <({String label, bool value, Function(bool) specify})>{
          (
            label: 'Checkout',
            value: widget.state._plugin.features.cart,
            specify: (bool value) {
              widget.state._plugin.features.cart = value;
            },
          ),
          (
            label: 'Bookmarks',
            value: widget.state._plugin.features.bookmarks,
            specify: (bool value) {
              widget.state._plugin.features.bookmarks = value;
            },
          ),
          (
            label: 'Authentication',
            value: widget.state._plugin.features.authentication,
            specify: (bool value) {
              widget.state._plugin.features.authentication = value;
            },
          ),
          (
            label: 'Registration',
            value: widget.state._plugin.features.registration,
            specify: (bool value) {
              widget.state._plugin.features.registration = value;
            },
          ),
          (
            label: 'Guest Login',
            value: widget.state._plugin.features.guestLogin,
            specify: (bool value) {
              widget.state._plugin.features.guestLogin = value;
            },
          ),
          (
            label: 'Currency Conversion',
            value: widget.state._plugin.features.currencyConversion,
            specify: (bool value) {
              widget.state._plugin.features.currencyConversion = value;
            },
          ),
        }.indexed) ...[
          if (option.$1 != 0) const Divider(height: 20),
          GsaWidgetSwitch(
            value: option.$2.value,
            child: GsaWidgetText(
              option.$2.label,
            ),
            onTap: (value) {
              option.$2.specify(value);
              widget.state.setState(() {});
            },
          ),
        ],
      ],
    );
  }
}
