import 'dart:ui' as dart_ui;

import 'package:flutter/material.dart';
import 'package:device_frame_plus/device_frame_plus.dart' as device_frame;
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as colorpicker;
import 'package:generic_shop_app_demo/demo.dart';
import 'package:generic_shop_app_fitness_tracker/fitness_tracker.dart';
import 'package:generic_shop_app_froddo_b2b/froddo_b2b.dart';
import 'package:generic_shop_app_froddo_b2c/froddo_b2c.dart';

part 'misc/misc_navigator_observer.dart';
part 'misc/misc_scroll_behaviour.dart';
part 'widgets/widget_device_preview.dart';
part 'widgets/widget_menu_section.dart';
part 'widgets/widget_menu.dart';

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

  void _setPlatform(
    TargetPlatform value,
  ) {
    setState(() {
      _platform = value;
      _device = device_frame.Devices.all.firstWhere(
        (device) {
          return device.identifier.platform == value;
        },
      );
    });
  }

  late GsaPluginClient _pluginClient;

  int _routeIndex = 0;

  Key _routeDropdownKey = UniqueKey();

  late List<GsaRouteType> _routes;

  void _setClient(GsaPluginClient value) {
    setState(() {
      _pluginClient = value;
      _routeIndex = 0;
      _routes = [
        ...GsaRoutes.values,
        ...GsaPlugin.of(context).routes.values,
      ];
      GsaRoute.navigatorKey = GlobalKey<NavigatorState>();
      _routeDropdownKey = UniqueKey();
      _theme = GsaTheme(
        plugin: GsaPlugin.of(context),
        platform: _platform,
      );
    });
  }

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

  final _appOptions = GsaPluginFeatures();

  late GsaTheme _theme;

  @override
  void initState() {
    super.initState();
    if (GsaRoute.navigatorContext == null) {
      throw Exception('GsaRoute.navigatorContext is null.');
    }
    final plugin = GsaPlugin.of(GsaRoute.navigatorContext!);
    _pluginClient = plugin.client;
    _routes = [
      ...GsaRoutes.values,
      ...plugin.routes.values,
    ];
    GsaRoute.navigatorKey = GlobalKey<NavigatorState>();
    _navigatorObserver = _NavigatorObserver(
      _onNavigatorChange,
    );
    _theme = GsaTheme(
      plugin: plugin,
      platform: _platform,
    );
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _WidgetMenu(
            state: this,
          ),
          Expanded(
            child: Center(
              child: InteractiveViewer(
                trackpadScrollCausesScale: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: SizedBox.expand(
                    child: _WidgetDevicePreview(
                      state: this,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
