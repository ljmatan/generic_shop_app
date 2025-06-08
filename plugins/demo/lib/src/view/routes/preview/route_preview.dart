import 'dart:ui' as dart_ui;

import 'package:flutter/material.dart';
import 'package:device_frame_plus/device_frame_plus.dart' as device_frame;
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_demo/src/view/routes/_routes.dart';

class GsdRoutePreview extends GsdRoute {
  const GsdRoutePreview({super.key});

  @override
  State<GsdRoutePreview> createState() => _GsdRoutePreviewState();
}

class _GsdRoutePreviewState extends GsaRouteState<GsdRoutePreview> {
  final _devicePlatforms = TargetPlatform.values.toList()
    ..removeWhere(
      (platform) => platform == TargetPlatform.fuchsia,
    );

  TargetPlatform _devicePlatform = TargetPlatform.iOS;

  device_frame.DeviceInfo _device = device_frame.Devices.ios.iPhone12;

  final _providers = GsaConfigProvider.values.toList().where(
        (provider) => provider != GsaConfigProvider.demo,
      );

  late GsaConfigProvider _provider;

  late List<GsaRouteType> _providerRoutes;

  List<GsaRouteType> get _routes {
    return [
      ...GsaRoutes.values,
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

  @override
  void initState() {
    super.initState();
    GsaRoute.navigatorKey = _navigatorKey;
    _provider = _providers.elementAt(0);
    _providerRoutes = _provider.plugin.routes;
    _navigatorObserver = _NavigatorObserver(
      _onNavigatorChange,
    );
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
                  ),
                  child: Theme(
                    data: GsaTheme(plugin: _provider.plugin).data,
                    child: device_frame.DeviceFrame(
                      device: _device,
                      screen: ScrollConfiguration(
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
                  const Divider(height: 32),
                  const SizedBox(height: 16),
                  DropdownMenu(
                    label: Text(
                      'Platform',
                    ),
                    enableFilter: false,
                    enableSearch: false,
                    dropdownMenuEntries: [
                      for (final platform in _devicePlatforms)
                        DropdownMenuEntry(
                          label: platform.name,
                          value: platform,
                        ),
                    ],
                    initialSelection: _devicePlatform,
                    width: MediaQuery.of(context).size.width * .2 - 40,
                    onSelected: (value) {
                      if (value == null) {
                        throw Exception(
                          'Device type value must not be null.',
                        );
                      }
                      setState(() {
                        _devicePlatform = value;
                        _device = device_frame.Devices.all.firstWhere(
                          (device) {
                            return device.identifier.platform == value;
                          },
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownMenu(
                    label: Text(
                      'Model',
                    ),
                    enableFilter: false,
                    enableSearch: false,
                    dropdownMenuEntries: [
                      for (final device in device_frame.Devices.all.where(
                        (device) {
                          return device.identifier.platform == _devicePlatform;
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
                  const Divider(height: 32),
                  const SizedBox(height: 16),
                  DropdownMenu(
                    label: Text(
                      'Provider',
                    ),
                    enableFilter: false,
                    enableSearch: false,
                    initialSelection: 0,
                    width: MediaQuery.of(context).size.width * .2 - 40,
                    dropdownMenuEntries: [
                      for (final provider in _providers.indexed)
                        DropdownMenuEntry(
                          label: provider.$2.name,
                          value: provider.$1,
                        ),
                    ],
                    onSelected: (value) {
                      if (value == null) {
                        throw Exception(
                          'The specified provider value must not be null.',
                        );
                      }
                      setState(() {
                        _provider = _providers.elementAt(value);
                        _providerRoutes = _provider.plugin.routes;
                        _routeIndex = 0;
                        _navigatorKey = GlobalKey<NavigatorState>();
                        GsaRoute.navigatorKey = _navigatorKey;
                        _routeDropdownKey = UniqueKey();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownMenu(
                    key: _routeDropdownKey,
                    label: Text(
                      'Route',
                    ),
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
                  const Divider(height: 32),
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

class _NavigatorObserver implements NavigatorObserver {
  const _NavigatorObserver(
    this.onNavigatorChange,
  );

  final void Function() onNavigatorChange;

  @override
  void didChangeTop(Route topRoute, Route? previousTopRoute) {
    onNavigatorChange();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    onNavigatorChange();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    onNavigatorChange();
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    onNavigatorChange();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    onNavigatorChange();
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    onNavigatorChange();
  }

  @override
  void didStopUserGesture() {
    // Do nothing.
  }

  @override
  NavigatorState? get navigator => null;
}

class _TouchScrollBehavior extends MaterialScrollBehavior {
  const _TouchScrollBehavior();

  @override
  Set<dart_ui.PointerDeviceKind> get dragDevices => {
        dart_ui.PointerDeviceKind.touch,
        dart_ui.PointerDeviceKind.mouse,
      };
}
