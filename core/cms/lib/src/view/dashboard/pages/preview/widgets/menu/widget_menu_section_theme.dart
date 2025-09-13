part of '../../page_preview.dart';

class _WidgetMenuSectionTheme extends StatefulWidget {
  const _WidgetMenuSectionTheme({
    required this.state,
  });

  final _GscPagePreviewState state;

  @override
  State<_WidgetMenuSectionTheme> createState() => _WidgetMenuSectionThemeState();
}

class _WidgetMenuSectionThemeState extends State<_WidgetMenuSectionTheme> {
  late TextEditingController _primaryColorHexController, _secondaryColorHexController, _borderColorHexController;

  void _setThemeBrightness(Brightness value) {
    widget.state._plugin.theme.brightness = value;
    widget.state.setState(() {});
    _primaryColorHexController.text = _toHexString(widget.state._plugin.theme.primaryColor);
    _secondaryColorHexController.text = _toHexString(widget.state._plugin.theme.secondaryColor);
    _borderColorHexController.text = _toHexString(widget.state._plugin.theme.borderColor);
  }

  final _additionalFontFamilies = <String>[];

  late Key _fontDropdownKey;

  void _setFontDropdownKey() {
    _fontDropdownKey = Key(widget.state._plugin.theme.fontFamily);
  }

  void _setFontFamily(String value) {
    widget.state._plugin.theme.fontFamily = value;
    _setFontDropdownKey();
    widget.state.setState(() {});
  }

  String _toHexString(Color value) {
    final hexString = value.toHexString();
    return hexString.startsWith('FF') && hexString.length > 6 ? hexString.replaceFirst('FF', '') : hexString;
  }

  void _setPrimaryColor(Color value) {
    if (widget.state._plugin.theme.brightness == Brightness.light) {
      widget.state._plugin.theme.primaryColorLight = value;
    } else {
      widget.state._plugin.theme.primaryColorDark = value;
    }
    _primaryColorHexController.text = _toHexString(value);
    widget.state.setState(() {});
  }

  void _setSecondaryColor(Color value) {
    if (widget.state._plugin.theme.brightness == Brightness.light) {
      widget.state._plugin.theme.secondaryColorLight = value;
    } else {
      widget.state._plugin.theme.secondaryColorDark = value;
    }
    _secondaryColorHexController.text = _toHexString(value);
    widget.state.setState(() {});
  }

  void _setBorderColor(Color value) {
    if (widget.state._plugin.theme.brightness == Brightness.light) {
      widget.state._plugin.theme.borderColorLight = value;
    } else {
      widget.state._plugin.theme.borderColorDark = value;
    }
    widget.state._plugin.theme.roundedRectangleBorder = widget.state._plugin.theme.roundedRectangleBorder.copyWith(
      side: BorderSide(
        color: value,
      ),
    );
    _borderColorHexController.text = _toHexString(value);
    widget.state.setState(() {});
  }

  void _setAnimatedAppBar(bool value) {
    widget.state._plugin.theme.animatedAppBar = value;
    widget.state.setState(() {});
  }

  void _setBorderRadius(double value) {
    final borderRadius = BorderRadius.circular(value);
    widget.state._plugin.theme.borderRadius = borderRadius;
    widget.state._plugin.theme.roundedRectangleBorder = widget.state._plugin.theme.roundedRectangleBorder.copyWith(
      borderRadius: borderRadius,
    );
    widget.state.setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _setFontDropdownKey();
    _primaryColorHexController = TextEditingController(
      text: _toHexString(
        widget.state._plugin.theme.brightness == Brightness.light
            ? widget.state._plugin.theme.primaryColorLight
            : widget.state._plugin.theme.primaryColorDark,
      ),
    );
    _secondaryColorHexController = TextEditingController(
      text: _toHexString(
        widget.state._plugin.theme.brightness == Brightness.light
            ? widget.state._plugin.theme.secondaryColorLight
            : widget.state._plugin.theme.secondaryColorDark,
      ),
    );
    _borderColorHexController = TextEditingController(
      text: _toHexString(widget.state._plugin.theme.borderColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _WidgetMenuSection(
      label: 'Theme',
      description: 'User interface customization options.',
      hint: 'Fields marked with * are customizable for both light and dark themes.',
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: .1),
            borderRadius: GsaPlugin.of(context).theme.borderRadius,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return Align(
                    alignment: widget.state._plugin.theme.brightness == Brightness.light ? Alignment.centerLeft : Alignment.centerRight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: GsaPlugin.of(context).theme.borderRadius,
                      ),
                      child: SizedBox(
                        width: constraints.maxWidth / 2,
                        height: 48,
                      ),
                    ),
                  );
                },
              ),
              Row(
                children: [
                  for (final brightnessOption in const <({String label, Brightness value})>{
                    (label: 'Light', value: Brightness.light),
                    (label: 'Dark', value: Brightness.dark),
                  })
                    Expanded(
                      child: InkWell(
                        child: GsaWidgetText(
                          brightnessOption.label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: widget.state._plugin.theme.brightness == brightnessOption.value ? Colors.white : Colors.grey,
                          ),
                        ),
                        onTap: widget.state._plugin.theme.brightness == brightnessOption.value
                            ? null
                            : () {
                                _setThemeBrightness(brightnessOption.value);
                              },
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: GsaTheme.of(context).paddings.content.regular,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: GsaWidgetButton.outlined(
            label: 'Logo Upload',
            icon: Icons.photo,
            onTap: () async {
              final imageFile = await GsdServiceOpenFile.instance.openImageFile();
              if (imageFile != null) {
                widget.state.setState(() {
                  final base64EncodedImage =
                      'BASE64/${imageFile.name.split('.').last}/'
                      '${dart_convert.base64Encode(imageFile.bytes)}';
                  widget.state._plugin.theme.logoImagePath = base64EncodedImage;
                });
              }
            },
          ),
        ),
        SizedBox(
          height: GsaTheme.of(context).paddings.content.medium,
        ),
        Row(
          children: [
            Expanded(
              child: GsaWidgetDropdownMenu<String>(
                key: _fontDropdownKey,
                labelText: 'Font Family',
                initialSelection: widget.state._plugin.theme.fontFamily,
                dropdownMenuEntries: [
                  for (final font in <({String label, String path})>{
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
                    for (final font in _additionalFontFamilies)
                      (
                        label: font,
                        path: font,
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
            ),
            SizedBox(
              width: GsaTheme.of(context).paddings.content.extraSmall,
            ),
            GsaWidgetButton.icon(
              icon: Icons.upload,
              tooltipMessage: 'Upload a new font file (OTF or TTF).',
              onTap: () async {
                final fontFile = await GsdServiceOpenFile.instance.openFontFile();
                if (fontFile != null) {
                  final fontLoader = FontLoader(fontFile.name);
                  fontLoader.addFont(
                    Future.value(
                      ByteData.sublistView(
                        fontFile.bytes,
                      ),
                    ),
                  );
                  await fontLoader.load();
                  _additionalFontFamilies.add(fontFile.name);
                  _setFontFamily(fontFile.name);
                }
              },
            ),
          ],
        ),
        for (final colorInput in <({TextEditingController controller, String label, Color color, Null Function(Color) onColorChanged})>{
          (
            controller: _primaryColorHexController,
            label: 'Primary Color*',
            color: widget.state._plugin.theme.brightness == Brightness.light
                ? widget.state._plugin.theme.primaryColorLight
                : widget.state._plugin.theme.primaryColorDark,
            onColorChanged: (Color value) {
              _setPrimaryColor(value);
            },
          ),
          (
            controller: _secondaryColorHexController,
            label: 'Secondary Color*',
            color: widget.state._plugin.theme.brightness == Brightness.light
                ? widget.state._plugin.theme.secondaryColorLight
                : widget.state._plugin.theme.secondaryColorDark,
            onColorChanged: (Color value) {
              _setSecondaryColor(value);
            },
          ),
          (
            controller: _borderColorHexController,
            label: 'Border Color*',
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
        for (final checkbox in <({String label, bool value, Function(bool newValue) onChanged})>{
          (
            label: 'Animated App Bar',
            value: widget.state._plugin.theme.animatedAppBar,
            onChanged: (newValue) {
              _setAnimatedAppBar(newValue);
            },
          ),
        }) ...[
          SizedBox(
            height: GsaTheme.of(context).paddings.content.medium,
          ),
          GsaWidgetSwitch(
            value: checkbox.value,
            child: GsaWidgetText(
              checkbox.label,
            ),
            onTap: checkbox.onChanged,
          ),
        ],
        for (final numValue in {
          (
            label: 'Border Radius',
            value: widget.state._plugin.theme.borderRadius.topLeft.x,
            onChanged: (value) {
              _setBorderRadius(value);
            },
          ),
        }) ...[
          SizedBox(
            height: GsaTheme.of(context).paddings.content.medium,
          ),
          GsaWidgetText(
            numValue.label,
          ),
          SizedBox(
            height: GsaTheme.of(context).paddings.content.extraSmall,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GsaWidgetButton.filled(
                icon: Icons.remove,
                backgroundColor: numValue.value > 0 ? null : Colors.grey,
                onTap: numValue.value > 0
                    ? () {
                        numValue.onChanged(numValue.value - 1);
                      }
                    : null,
              ),
              GsaWidgetText(
                numValue.value.toString(),
              ),
              GsaWidgetButton.filled(
                icon: Icons.add,
                onTap: () {
                  numValue.onChanged(numValue.value + 1);
                },
              ),
            ],
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
