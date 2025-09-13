import 'dart:convert' as dart_convert;

import 'package:flutter/material.dart';
import 'package:device_frame_plus/device_frame_plus.dart' as device_frame;
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as colorpicker;
import 'package:generic_shop_app_cms/cms.dart';

part 'widgets/widget_device_preview.dart';
part 'widgets/menu/widget_menu.dart';
part 'widgets/menu/widget_menu_section.dart';
part 'widgets/menu/widget_menu_section_device.dart';
part 'widgets/menu/widget_menu_section_client.dart';
part 'widgets/menu/widget_menu_section_features.dart';
part 'widgets/menu/widget_menu_section_theme.dart';

class GscPagePreview extends StatefulWidget {
  /// Default, unnamed widget constructor.
  ///
  const GscPagePreview({
    super.key,
  });

  @override
  State<GscPagePreview> createState() => _GscPagePreviewState();
}

class _GscPagePreviewState extends State<GscPagePreview> {
  /// Device platforms supported for the project preview.
  ///
  final _platforms = TargetPlatform.values.toList()
    ..removeWhere(
      (platform) => platform == TargetPlatform.fuchsia,
    );

  TargetPlatform _platform = TargetPlatform.iOS;

  device_frame.DeviceInfo _device = device_frame.Devices.ios.iPhone12;

  Orientation _deviceOrientation = Orientation.portrait;

  GsaPlugin _plugin = GscPlugin.pluginCollection.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withValues(alpha: .1),
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
