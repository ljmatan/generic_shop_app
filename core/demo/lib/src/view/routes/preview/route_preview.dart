import 'package:flutter/material.dart';
import 'package:device_frame_plus/device_frame_plus.dart' as device_frame;
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as colorpicker;
import 'package:generic_shop_app_demo/demo.dart';

part 'widgets/widget_device_preview.dart';
part 'widgets/menu/widget_menu.dart';
part 'widgets/menu/widget_menu_section.dart';
part 'widgets/menu/widget_menu_section_device.dart';
part 'widgets/menu/widget_menu_section_client.dart';
part 'widgets/menu/widget_menu_section_features.dart';
part 'widgets/menu/widget_menu_section_theme.dart';

class GsdRoutePreview extends GsdRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsdRoutePreview({
    super.key,
  });

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

  Orientation _deviceOrientation = Orientation.portrait;

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

  GsaPlugin _plugin = GsdPlugin.pluginCollection.first;

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
              child: _WidgetDevicePreview(
                state: this,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
