part of '../../route_preview.dart';

class _WidgetMenuSectionTheme extends StatefulWidget {
  const _WidgetMenuSectionTheme({
    required this.state,
  });

  final _GsdRoutePreviewState state;

  @override
  State<_WidgetMenuSectionTheme> createState() => _WidgetMenuSectionThemeState();
}

class _WidgetMenuSectionThemeState extends State<_WidgetMenuSectionTheme> {
  void _setFontFamily(String value) {
    widget.state._plugin.theme.fontFamily = value;
    widget.state.rebuild();
  }

  String _toHexString(Color value) {
    final hexString = value.toHexString();
    return hexString.startsWith('FF') && hexString.length > 6 ? hexString.replaceFirst('FF', '') : hexString;
  }

  late TextEditingController _primaryColorHexController, _secondaryColorHexController, _borderColorHexController;

  void _setPrimaryColor(Color value) {
    widget.state._plugin.theme.primaryColor = value;
    _primaryColorHexController.text = _toHexString(value);
    widget.state.rebuild();
  }

  void _setSecondaryColor(Color value) {
    widget.state._plugin.theme.secondaryColor = value;
    _secondaryColorHexController.text = _toHexString(value);
    widget.state.rebuild();
  }

  void _setBorderColor(Color value) {
    widget.state._plugin.theme.borderColor = value;
    widget.state._plugin.theme.roundedRectangleBorder = widget.state._plugin.theme.roundedRectangleBorder.copyWith(
      side: BorderSide(
        color: value,
      ),
    );
    _borderColorHexController.text = _toHexString(value);
    widget.state.rebuild();
  }

  void _setThemeBrightness(Brightness value) {
    widget.state._plugin.theme.brightness = value;
    widget.state.rebuild();
  }

  void _setAnimatedAppBar(bool value) {
    widget.state._plugin.theme.animatedAppBar = value;
    widget.state.rebuild();
  }

  @override
  void initState() {
    super.initState();
    _primaryColorHexController = TextEditingController(
      text: _toHexString(widget.state._plugin.theme.primaryColor),
    );
    _secondaryColorHexController = TextEditingController(
      text: _toHexString(widget.state._plugin.theme.secondaryColor),
    );
    _borderColorHexController = TextEditingController(
      text: _toHexString(widget.state._plugin.theme.borderColor),
    );
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
        for (final colorInput in <({
          TextEditingController controller,
          String label,
          Color color,
          Null Function(Color) onColorChanged,
        })>{
          (
            controller: _primaryColorHexController,
            label: 'Primary Color',
            color: widget.state._plugin.theme.primaryColor,
            onColorChanged: (Color value) {
              _setPrimaryColor(value);
            },
          ),
          (
            controller: _secondaryColorHexController,
            label: 'Secondary Color',
            color: widget.state._plugin.theme.secondaryColor,
            onColorChanged: (Color value) {
              _setSecondaryColor(value);
            },
          ),
          (
            controller: _borderColorHexController,
            label: 'Border Color',
            color: widget.state._plugin.theme.borderColor,
            onColorChanged: (Color value) {
              _setBorderColor(value);
            },
          ),
        }) ...[
          const SizedBox(height: 20),
          InkWell(
            child: GsaWidgetTextField(
              controller: colorInput.controller,
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
            value: widget.state._plugin.theme.brightness == Brightness.dark,
            onChanged: (newValue) {
              _setThemeBrightness(
                newValue ? Brightness.dark : Brightness.light,
              );
            },
          ),
          (
            label: 'Animated App Bar',
            value: widget.state._plugin.theme.animatedAppBar,
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

  @override
  void dispose() {
    _primaryColorHexController.dispose();
    _secondaryColorHexController.dispose();
    _borderColorHexController.dispose();
    super.dispose();
  }
}
