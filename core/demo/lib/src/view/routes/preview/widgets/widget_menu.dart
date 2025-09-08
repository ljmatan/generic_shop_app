part of '../route_preview.dart';

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
            _WidgetMenuSection(
              label: 'Device',
              description: 'Operating system and device model options.',
              initiallyExpanded: true,
              children: [
                GsaWidgetDropdownMenu<TargetPlatform>(
                  labelText: 'Platform',
                  enableFilter: false,
                  enableSearch: false,
                  dropdownMenuEntries: [
                    for (final platform in widget.state._platforms)
                      DropdownMenuEntry(
                        label: platform.name,
                        value: platform,
                      ),
                  ],
                  initialSelection: widget.state._platform,
                  onSelected: (value) {
                    if (value == null) {
                      throw Exception(
                        'Target platform value must not be null.',
                      );
                    }
                    widget.state._setPlatform(value);
                  },
                ),
                const SizedBox(height: 20),
                GsaWidgetDropdownMenu<device_frame.DeviceInfo>(
                  labelText: 'Model',
                  enableFilter: false,
                  enableSearch: false,
                  dropdownMenuEntries: [
                    for (final device in device_frame.Devices.all.where(
                      (device) {
                        return device.identifier.platform == widget.state._platform;
                      },
                    ))
                      DropdownMenuEntry(
                        label: device.name,
                        value: device,
                      ),
                  ],
                  initialSelection: widget.state._device,
                  width: MediaQuery.of(context).size.width * .25 - 40,
                  onSelected: (value) {
                    if (value == null) {
                      throw Exception(
                        'Device value must not be null.',
                      );
                    }
                    widget.state._device = value;
                    widget.state.rebuild();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            _WidgetMenuSection(
              label: 'Client',
              description: 'Client and route selection.',
              children: [
                GsaWidgetDropdownMenu<GsaPluginClient>(
                  labelText: 'Provider',
                  enableFilter: false,
                  enableSearch: false,
                  initialSelection: widget.state._pluginClient,
                  dropdownMenuEntries: [
                    for (final provider in GsaPluginClient.values)
                      DropdownMenuEntry(
                        label: provider.name,
                        value: provider,
                      ),
                  ],
                  onSelected: (value) async {
                    if (value == null) {
                      throw Exception(
                        'The specified provider value must not be null.',
                      );
                    }
                    const GsaWidgetOverlayContentBlocking().openDialog();
                    try {
                      Navigator.pop(context);
                      widget.state._setClient(value);
                    } catch (e) {
                      Navigator.pop(context);
                      GsaWidgetOverlayAlert(
                        '$e',
                      ).openDialog();
                    }
                  },
                ),
                const SizedBox(height: 20),
                GsaWidgetDropdownMenu(
                  key: widget.state._routeDropdownKey,
                  labelText: 'Route',
                  enableFilter: false,
                  enableSearch: false,
                  initialSelection: widget.state._routeIndex,
                  dropdownMenuEntries: [
                    for (final route in widget.state._routes.indexed)
                      DropdownMenuEntry(
                        label: route.$2.displayName,
                        value: route.$1,
                      ),
                  ],
                  onSelected: (value) {
                    if (value == null) {
                      throw Exception(
                        'The specified route value must not be null.',
                      );
                    }
                    setState(() {
                      widget.state._routeIndex = value;
                      GsaRoute.navigatorKey = GlobalKey<NavigatorState>();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            _WidgetMenuSection(
              label: 'Options',
              description: 'Specify available app functionalities.',
              children: [
                for (final option in <({String label, bool value, Function(bool) specify})>{
                  (
                    label: 'Checkout',
                    value: widget.state._appOptions.cart,
                    specify: (bool value) {
                      widget.state._appOptions.cart = value;
                    }
                  ),
                  (
                    label: 'Registration',
                    value: widget.state._appOptions.registration,
                    specify: (bool value) {
                      widget.state._appOptions.registration = value;
                    }
                  ),
                  (
                    label: 'Guest Login',
                    value: widget.state._appOptions.guestLogin,
                    specify: (bool value) {
                      widget.state._appOptions.guestLogin = value;
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
                      widget.state.rebuild();
                    },
                  ),
                ],
              ],
            ),
            const SizedBox(height: 20),
            _WidgetMenuSection(
              label: 'Theme',
              description: 'Theme customization options.',
              children: [
                GsaWidgetDropdownMenu<String>(
                  labelText: 'Font Family',
                  width: MediaQuery.of(context).size.width * .25 - 40,
                  initialSelection: GsaTheme.instance.fontFamily,
                  dropdownMenuEntries: [
                    for (final fontId in <String>{
                      'Comic Neue',
                      'Quicksand',
                      'Merriweather Sans',
                      'Open Sans',
                    })
                      DropdownMenuEntry(
                        label: fontId,
                        value: fontId,
                      ),
                  ],
                  onSelected: (value) {
                    if (value == null) {
                      throw Exception(
                        'The specified font family value must not be null.',
                      );
                    }
                    widget.state._theme.fontFamily = value;
                    widget.state.rebuild();
                  },
                ),
                const SizedBox(height: 16),
                GsaWidgetSwitch(
                  value: widget.state._theme.brightness == Brightness.dark,
                  child: GsaWidgetText('Dark Theme'),
                  onTap: (newValue) {
                    widget.state._theme.brightness = newValue ? Brightness.dark : Brightness.light;
                    widget.state.rebuild();
                  },
                ),
                for (final colorInput in {
                  (
                    label: 'Primary Color',
                    color: widget.state._theme.primaryColor,
                    onColorChanged: (Color value) {
                      widget.state._theme.primaryColor = value;
                      widget.state.rebuild();
                    },
                  ),
                  (
                    label: 'Secondary Color',
                    color: widget.state._theme.secondaryColor,
                    onColorChanged: (Color value) {
                      widget.state._theme.secondaryColor = value;
                      widget.state.rebuild();
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
                      final result = await showDialog(
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
                                colorInput.color,
                              ),
                            ),
                          ],
                        ),
                      );
                      colorInput.onColorChanged(result ?? colorInput.color);
                    },
                  ),
                ],
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
