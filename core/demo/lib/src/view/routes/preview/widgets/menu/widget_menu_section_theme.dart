part of '../../route_preview.dart';

class _WidgetMenuSectionTheme extends StatelessWidget {
  const _WidgetMenuSectionTheme({
    required this.state,
  });

  final _GsdRoutePreviewState state;

  void _setFontFamily(String value) {
    state._plugin.theme.fontFamily = value;
    state.rebuild();
  }

  void _setPrimaryColor(Color value) {
    state._plugin.theme.primaryColor = value;
    state.rebuild();
  }

  void _setSecondaryColor(Color value) {
    state._plugin.theme.secondaryColor = value;
    state.rebuild();
  }

  void _setThemeBrightness(Brightness value) {
    state._plugin.theme.brightness = value;
    state.rebuild();
  }

  void _setAnimatedAppBar(bool value) {
    state._plugin.theme.animatedAppBar = value;
    state.rebuild();
  }

  @override
  Widget build(BuildContext context) {
    return _WidgetMenuSection(
      label: 'Theme',
      description: 'Theme customization options.',
      children: [
        GsaWidgetDropdownMenu<String>(
          labelText: 'Font Family',
          width: MediaQuery.of(context).size.width * .25 - 40,
          initialSelection: GsaPlugin.of(context).theme.fontFamily,
          dropdownMenuEntries: [
            for (final font in <({
              String label,
              String path,
            })>{
              (
                label: 'Comic Neue',
                path: 'packages/generic_shop_app_demo/Comic Neue',
              ),
              (
                label: 'Quicksand',
                path: 'packages/generic_shop_app_content/Quicksand',
              ),
              (
                label: 'Merriweather Sans',
                path: 'packages/generic_shop_app_froddo_b2b/Merriweather Sans',
              ),
              (
                label: 'Open Sans',
                path: 'packages/generic_shop_app_fitness_tracker/Open Sans',
              ),
            })
              DropdownMenuEntry(
                label: font.label,
                value: font.path,
              ),
          ],
          onSelected: (value) {
            if (value == null) {
              throw Exception(
                'The specified font family value must not be null.',
              );
            }
            _setFontFamily(value);
          },
        ),
        for (final colorInput in {
          (
            label: 'Primary Color',
            color: state._plugin.theme.primaryColor,
            onColorChanged: (Color value) {
              _setPrimaryColor(value);
            },
          ),
          (
            label: 'Secondary Color',
            color: state._plugin.theme.secondaryColor,
            onColorChanged: (Color value) {
              _setSecondaryColor(value);
            },
          ),
        }) ...[
          const SizedBox(height: 20),
          InkWell(
            child: GsaWidgetTextField(
              labelText: colorInput.label,
              enabled: false,
              prefix: GsaWidgetText(
                '#',
              ),
              suffixIcon: Icon(
                Icons.circle,
                color: colorInput.color,
              ),
            ),
            onTap: () async {
              final colorBackup = colorInput.color;
              final updateConfirmed = await showDialog<bool?>(
                context: context,
                builder: (context) => AlertDialog(
                  title: GsaWidgetText(
                    colorInput.label,
                  ),
                  content: SingleChildScrollView(
                    child: colorpicker.ColorPicker(
                      pickerColor: colorInput.color,
                      onColorChanged: colorInput.onColorChanged,
                      enableAlpha: false,
                      hexInputBar: true,
                    ),
                  ),
                  actions: <Widget>[
                    GsaWidgetButton.elevated(
                      label: 'CONFIRM',
                      onTap: () => Navigator.pop(
                        context,
                        true,
                      ),
                    ),
                  ],
                ),
              );
              if (updateConfirmed != true) {
                colorInput.onColorChanged(colorBackup);
              }
            },
          ),
        ],
        for (final checkbox in <({
          String label,
          bool value,
          Function(bool newValue) onChanged,
        })>{
          (
            label: 'Dark Theme',
            value: state._plugin.theme.brightness == Brightness.dark,
            onChanged: (newValue) {
              _setThemeBrightness(
                newValue ? Brightness.dark : Brightness.light,
              );
            },
          ),
          (
            label: 'Animated App Bar',
            value: state._plugin.theme.animatedAppBar,
            onChanged: (newValue) {
              _setAnimatedAppBar(newValue);
            },
          ),
        }) ...[
          const SizedBox(height: 16),
          GsaWidgetSwitch(
            value: checkbox.value,
            child: GsaWidgetText(
              checkbox.label,
            ),
            onTap: checkbox.onChanged,
          ),
        ],
      ],
    );
  }
}
