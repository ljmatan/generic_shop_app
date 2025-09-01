import 'dart:ui' as dart_ui;

import 'package:flutter/material.dart';
import 'package:device_frame_plus/device_frame_plus.dart' as device_frame;
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as colorpicker;
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_demo/gsd.dart';

part 'misc/misc_navigator_observer.dart';
part 'misc/misc_scroll_behaviour.dart';

class GsdRoutePreview extends GsdRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsdRoutePreview({super.key});

  @override
  State<GsdRoutePreview> createState() => _GsdRoutePreviewState();
}

class _GsdRoutePreviewState extends GsaRouteState<GsdRoutePreview> {
  /// Device platforms supported for the project preview.
  ///
  final _platforms = TargetPlatform.values.toList()
    ..removeWhere(
      (platform) => platform == TargetPlatform.fuchsia,
    );

  TargetPlatform _platform = TargetPlatform.iOS;

  device_frame.DeviceInfo _device = device_frame.Devices.ios.iPhone12;

  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  int _routeIndex = 0;

  Key _routeDropdownKey = UniqueKey();

  late List<GsaRouteType> _routes;

  void _onNavigatorChange() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final routeIndex = _routes.indexWhere(
          (route) {
            return route.routeRuntimeType == GsaRoute.presenting.widget.runtimeType;
          },
        );
        if (routeIndex != -1 && _routeIndex != routeIndex) {
          setState(() {
            _routeIndex = routeIndex;
            _routeDropdownKey = UniqueKey();
          });
        }
      },
    );
  }

  late _NavigatorObserver _navigatorObserver;

  bool _darkTheme = false;

  late Color _primaryColor;

  String _fontFamily = 'Quicksand';

  @override
  void initState() {
    super.initState();
    _routes = [
      ...GsaRoutes.values,
      if (GsaConfig.plugin.routes != null) ...GsaConfig.plugin.routes!,
    ];
    GsaRoute.navigatorKey = _navigatorKey;
    _navigatorObserver = _NavigatorObserver(
      _onNavigatorChange,
    );
    _primaryColor = GsaConfig.plugin.theme.primaryColor ?? GsaTheme.instance.data.primaryColor;
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: MediaQuery(
                  data: MediaQueryData(
                    size: _device.screenSize,
                    devicePixelRatio: _device.pixelRatio,
                    textScaler: GsaTheme.instance.textScaler(
                      context,
                      _device.screenSize.width,
                    ),
                  ),
                  child: device_frame.DeviceFrame(
                    device: _device,
                    screen: Theme(
                      data: GsaTheme(
                        platform: _platform,
                        brightness: _darkTheme ? Brightness.dark : Brightness.light,
                        primaryColor: _primaryColor,
                        fontFamily: _fontFamily,
                      ).data,
                      child: ScrollConfiguration(
                        behavior: const _TouchScrollBehavior(),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Navigator(
                            key: _navigatorKey,
                            observers: [
                              _navigatorObserver,
                            ],
                            initialRoute: _routes[_routeIndex].routeId,
                            onDidRemovePage: (page) {
                              _onNavigatorChange();
                            },
                            onGenerateRoute: (settings) {
                              return MaterialPageRoute(
                                builder: (_) => _routes
                                    .firstWhere(
                                      (route) => route.routeId == settings.name,
                                    )
                                    .widget(),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .25,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                children: [
                  GsaWidgetText(
                    'Device',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Divider(height: 20),
                  const SizedBox(height: 16),
                  GsaWidgetDropdownMenu<TargetPlatform>(
                    labelText: 'Platform',
                    enableFilter: false,
                    enableSearch: false,
                    dropdownMenuEntries: [
                      for (final platform in _platforms)
                        DropdownMenuEntry(
                          label: platform.name,
                          value: platform,
                        ),
                    ],
                    initialSelection: _platform,
                    width: MediaQuery.of(context).size.width * .25 - 40,
                    onSelected: (value) {
                      if (value == null) {
                        throw Exception(
                          'Target platform value must not be null.',
                        );
                      }
                      setState(() {
                        _platform = value;
                        _device = device_frame.Devices.all.firstWhere(
                          (device) {
                            return device.identifier.platform == value;
                          },
                        );
                      });
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
                          return device.identifier.platform == _platform;
                        },
                      ))
                        DropdownMenuEntry(
                          label: device.name,
                          value: device,
                        ),
                    ],
                    initialSelection: _device,
                    width: MediaQuery.of(context).size.width * .25 - 40,
                    onSelected: (value) {
                      if (value == null) {
                        throw Exception(
                          'Device value must not be null.',
                        );
                      }
                      setState(() {
                        _device = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  GsaWidgetText(
                    'Client',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Divider(height: 20),
                  const SizedBox(height: 16),
                  GsaWidgetDropdownMenu<GsaPlugin>(
                    labelText: 'Provider',
                    enableFilter: false,
                    enableSearch: false,
                    initialSelection: GsaConfig.plugin,
                    width: MediaQuery.of(context).size.width * .25 - 40,
                    dropdownMenuEntries: [
                      for (final provider in [])
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
                        await GsaConfig.plugin.init();
                        Navigator.pop(context);
                        setState(
                          () {
                            GsaConfig.plugin = value;
                            _routeIndex = 0;
                            _routes = [
                              ...GsaRoutes.values,
                              if (GsaConfig.plugin.routes != null) ...GsaConfig.plugin.routes!,
                            ];
                            _navigatorKey = GlobalKey<NavigatorState>();
                            GsaRoute.navigatorKey = _navigatorKey;
                            _routeDropdownKey = UniqueKey();
                            _primaryColor = GsaConfig.plugin.theme.primaryColor ?? GsaTheme.instance.data.primaryColor;
                            _fontFamily = GsaConfig.plugin.theme.fontFamily ?? _fontFamily;
                          },
                        );
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
                    key: _routeDropdownKey,
                    labelText: 'Route',
                    enableFilter: false,
                    enableSearch: false,
                    initialSelection: _routeIndex,
                    width: MediaQuery.of(context).size.width * .25 - 40,
                    dropdownMenuEntries: [
                      for (final route in _routes.indexed)
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
                        _routeIndex = value;
                        _navigatorKey = GlobalKey<NavigatorState>();
                        GsaRoute.navigatorKey = _navigatorKey;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  GsaWidgetText(
                    'Options',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Divider(height: 20),
                  GsaWidgetSwitch(
                    value: GsaConfig.cartEnabled,
                    child: GsaWidgetText('Checkout'),
                    onTap: (value) {
                      setState(() => GsaConfig.cartEnabled = value);
                    },
                  ),
                  const Divider(height: 20),
                  GsaWidgetSwitch(
                    value: GsaConfig.registrationEnabled,
                    child: GsaWidgetText('Registration'),
                    onTap: (value) {
                      setState(() => GsaConfig.registrationEnabled = value);
                    },
                  ),
                  const Divider(height: 20),
                  GsaWidgetSwitch(
                    value: GsaConfig.guestLoginEnabled,
                    child: GsaWidgetText('Guest Login'),
                    onTap: (value) {
                      setState(() => GsaConfig.guestLoginEnabled = value);
                    },
                  ),
                  const SizedBox(height: 20),
                  GsaWidgetText(
                    'Theme',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Divider(height: 20),
                  const SizedBox(height: 16),
                  GsaWidgetDropdownMenu<String>(
                    labelText: 'Font Family',
                    width: MediaQuery.of(context).size.width * .25 - 40,
                    initialSelection: _fontFamily,
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
                      setState(() => _fontFamily = value);
                    },
                  ),
                  const SizedBox(height: 16),
                  GsaWidgetSwitch(
                    value: _darkTheme,
                    child: GsaWidgetText('Dark Theme'),
                    onTap: (value) {
                      setState(() => _darkTheme = value);
                    },
                  ),
                  for (final colorInput in {
                    (
                      label: 'Primary Color',
                      color: _primaryColor,
                      onColorChanged: (Color value) => _primaryColor = value,
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
                        if (result == null) {
                          colorInput.onColorChanged(colorInput.color);
                        } else {
                          setState(() {});
                        }
                      },
                    ),
                  ],
                  const SizedBox(height: 20),
                  GsaWidgetText(
                    'Data',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Divider(height: 20),
                  for (final provider in []) ...[
                    const SizedBox(height: 12),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: GsaWidgetButton.outlined(
                        label: 'INIT ${provider.name.toUpperCase()}',
                        onTap: () async {
                          const GsaWidgetOverlayContentBlocking().openDialog();
                          try {
                            GsaData.clearAll();
                            await GsaConfig.plugin.init();
                            Navigator.pop(context);
                            setState(() {
                              _routeIndex = 0;
                              _routes = [
                                ...GsaRoutes.values,
                                if (GsaConfig.plugin.routes != null) ...GsaConfig.plugin.routes!,
                              ];
                              _navigatorKey = GlobalKey<NavigatorState>();
                              GsaRoute.navigatorKey = _navigatorKey;
                              _routeDropdownKey = UniqueKey();
                              _primaryColor = GsaConfig.plugin.theme.primaryColor ?? GsaTheme.instance.data.primaryColor;
                              _fontFamily = GsaConfig.plugin.theme.fontFamily ?? _fontFamily;
                            });
                          } catch (e) {
                            Navigator.pop(context);
                            GsaWidgetOverlayAlert(
                              '$e',
                            ).openDialog();
                          }
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
