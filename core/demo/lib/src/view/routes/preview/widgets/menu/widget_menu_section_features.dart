part of '../../route_preview.dart';

class _WidgetMenuSectionFeatures extends StatelessWidget {
  const _WidgetMenuSectionFeatures({
    required this.state,
  });

  final _GsdRoutePreviewState state;

  @override
  Widget build(BuildContext context) {
    return _WidgetMenuSection(
      label: 'Features',
      description: 'Specify available app functionalities.',
      children: [
        for (final option in <({String label, bool value, Function(bool) specify})>{
          (
            label: 'Checkout',
            value: state._plugin.features.cart,
            specify: (bool value) {
              state._plugin.features.cart = value;
            }
          ),
          (
            label: 'Bookmarks',
            value: state._plugin.features.bookmarks,
            specify: (bool value) {
              state._plugin.features.bookmarks = value;
            }
          ),
          (
            label: 'Authentication',
            value: state._plugin.features.authentication,
            specify: (bool value) {
              state._plugin.features.authentication = value;
            }
          ),
          (
            label: 'Registration',
            value: state._plugin.features.registration,
            specify: (bool value) {
              state._plugin.features.registration = value;
            }
          ),
          (
            label: 'Guest Login',
            value: state._plugin.features.guestLogin,
            specify: (bool value) {
              state._plugin.features.guestLogin = value;
            }
          ),
          (
            label: 'Currency Conversion',
            value: state._plugin.features.currencyConversion,
            specify: (bool value) {
              state._plugin.features.currencyConversion = value;
            }
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
              state.rebuild();
            },
          ),
        ],
      ],
    );
  }
}
