import 'dart:ui' as dart_ui;

import 'package:flutter/material.dart';
import 'package:device_frame_plus/device_frame_plus.dart' as device_frame;
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as colorpicker;
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_demo/src/view/routes/_routes.dart';

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

  final _providers = GsaConfigProvider.values;

  late GsaConfigProvider _provider;

  late List<GsaRouteType> _providerRoutes;

  List<GsaRouteType> get _routes {
    return [
      ..._providerRoutes,
    ]..removeWhere(
        (route) => route.routeId == 'splash',
      );
  }

  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  int _routeIndex = 0;

  Key _routeDropdownKey = UniqueKey();

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

  late Color _primaryColor, _secondaryColor;

  @override
  void initState() {
    super.initState();
    GsaRoute.navigatorKey = _navigatorKey;
    _provider = _providers.elementAt(0);
    _providerRoutes = _provider.plugin.routes;
    _navigatorObserver = _NavigatorObserver(
      _onNavigatorChange,
    );
    _primaryColor = _provider.plugin.themeProperties?.primary ?? GsaTheme.instance.data.primaryColor;
    _secondaryColor = _provider.plugin.themeProperties?.primary ?? GsaTheme.instance.data.colorScheme.secondary;
  }

  @override
  Widget build(BuildContext context) {
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
                        plugin: _provider.plugin,
                        platform: _platform,
                        brightness: _darkTheme ? Brightness.dark : Brightness.light,
                        primaryColor: _primaryColor,
                        secondaryColor: _secondaryColor,
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
              boxShadow: kElevationToShadow[16],
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                children: [
                  Text(
                    'Device',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Divider(height: 20),
                  const SizedBox(height: 16),
                  GsaWidgetDropdownMenu(
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
                    width: MediaQuery.of(context).size.width * .2 - 40,
                    onSelected: (value) {
                      if (value == null) {
                        throw Exception(
                          'Device type value must not be null.',
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
                  GsaWidgetDropdownMenu(
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
                    width: MediaQuery.of(context).size.width * .2 - 40,
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
                  Text(
                    'Client',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Divider(height: 20),
                  const SizedBox(height: 16),
                  GsaWidgetDropdownMenu(
                    labelText: 'Provider',
                    enableFilter: false,
                    enableSearch: false,
                    initialSelection: _provider,
                    width: MediaQuery.of(context).size.width * .2 - 40,
                    dropdownMenuEntries: [
                      for (final provider in _providers) DropdownMenuEntry(label: provider.name, value: provider),
                    ],
                    onSelected: (value) {
                      if (value == null) {
                        throw Exception(
                          'The specified provider value must not be null.',
                        );
                      }
                      setState(
                        () {
                          _provider = value;
                          _providerRoutes = _provider.plugin.routes;
                          _routeIndex = 0;
                          _navigatorKey = GlobalKey<NavigatorState>();
                          GsaRoute.navigatorKey = _navigatorKey;
                          _routeDropdownKey = UniqueKey();
                          _primaryColor = _provider.plugin.themeProperties?.primary ?? GsaTheme.instance.data.primaryColor;
                          _secondaryColor = _provider.plugin.themeProperties?.secondary ?? GsaTheme.instance.data.colorScheme.secondary;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  GsaWidgetDropdownMenu(
                    key: _routeDropdownKey,
                    labelText: 'Route',
                    enableFilter: false,
                    enableSearch: false,
                    initialSelection: _routeIndex,
                    width: MediaQuery.of(context).size.width * .2 - 40,
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
                  Text(
                    'Theme',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Divider(height: 20),
                  GsaWidgetSwitch(
                    value: _darkTheme,
                    child: Text('Dark Theme'),
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
                    (
                      label: 'Secondary Color',
                      color: _secondaryColor,
                      onColorChanged: (Color value) => _secondaryColor = value,
                    ),
                  }) ...[
                    const SizedBox(height: 20),
                    InkWell(
                      child: GsaWidgetTextField(
                        labelText: colorInput.label,
                        enabled: false,
                        prefix: Text(
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
                            title: Text(
                              colorInput.label,
                            ),
                            content: SingleChildScrollView(
                              child: colorpicker.ColorPicker(
                                pickerColor: colorInput.color,
                                onColorChanged: colorInput.onColorChanged,
                              ),
                              // Use Material color picker:
                              //
                              // child: MaterialPicker(
                              //   pickerColor: pickerColor,
                              //   onColorChanged: changeColor,
                              //   showLabel: true, // only on portrait mode
                              // ),
                              //
                              // Use Block color picker:
                              //
                              // child: BlockPicker(
                              //   pickerColor: currentColor,
                              //   onColorChanged: changeColor,
                              // ),
                              //
                              // child: MultipleChoiceBlockPicker(
                              //   pickerColors: currentColors,
                              //   onColorsChanged: changeColors,
                              // ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text('CONFIRM'),
                                onPressed: () => Navigator.pop(
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
                  Text(
                    'Data',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Divider(height: 20),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
