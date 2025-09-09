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
            value: state._appOptions.cart,
            specify: (bool value) {
              state._appOptions.cart = value;
            }
          ),
          (
            label: 'Registration',
            value: state._appOptions.registration,
            specify: (bool value) {
              state._appOptions.registration = value;
            }
          ),
          (
            label: 'Guest Login',
            value: state._appOptions.guestLogin,
            specify: (bool value) {
              state._appOptions.guestLogin = value;
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
