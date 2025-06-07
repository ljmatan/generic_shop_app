import 'package:flutter/material.dart';
import 'package:device_frame_plus/device_frame_plus.dart' as device_frame;
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_demo/src/view/routes/_routes.dart';

class GsdRoutePreview extends GsdRoute {
  const GsdRoutePreview({super.key});

  @override
  State<GsdRoutePreview> createState() => _GsdRoutePreviewState();
}

class _GsdRoutePreviewState extends GsaRouteState<GsdRoutePreview> {
  device_frame.DeviceInfo _device = device_frame.Devices.ios.iPhone14Pro;

  final _providers = GsaConfigProvider.values.toList().where(
        (provider) => provider != GsaConfigProvider.demo,
      );

  late GsaConfigProvider _provider;

  late List<GsaRouteType> _routes;

  int _routeIndex = 0;

  Key _routeDropdownKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _provider = _providers.elementAt(0);
    _routes = _provider.plugin.routes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: MediaQuery(
                      data: MediaQueryData(
                        size: _device.screenSize,
                        devicePixelRatio: _device.pixelRatio,
                      ),
                      child: device_frame.DeviceFrame(
                        device: _device,
                        screen: _routes[_routeIndex].widget(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  top: 16,
                  child: DropdownMenu(
                    dropdownMenuEntries: [
                      for (final device in device_frame.Devices.all)
                        DropdownMenuEntry(
                          label: device.name,
                          value: device,
                        ),
                    ],
                    initialSelection: _device,
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
                ),
              ],
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
                  DropdownMenu(
                    label: Text(
                      'App Provider',
                    ),
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
                        _routes = _provider.plugin.routes;
                        _routeIndex = 0;
                        _routeDropdownKey = UniqueKey();
                      });
                    },
                  ),
                  const Divider(height: 40),
                  DropdownMenu(
                    key: _routeDropdownKey,
                    label: Text(
                      'Route',
                    ),
                    initialSelection: 0,
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
                      });
                    },
                  ),
                  const Divider(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
