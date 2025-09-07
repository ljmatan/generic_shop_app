import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:generic_shop_app_architecture/arch.dart';
import 'package:device_info_plus/device_info_plus.dart' as device_info;

/// Class providing device information from within the Flutter application.
///
class GsaServiceDeviceInfo extends GsaService {
  GsaServiceDeviceInfo._();

  static final _instance = GsaServiceDeviceInfo._();

  /// Globally-accessible class instance.
  ///
  static GsaServiceDeviceInfo get instance => _instance() as GsaServiceDeviceInfo;

  /// Information derived from `android.os.Build`.
  ///
  /// See: https://developer.android.com/reference/android/os/Build.html
  ///
  device_info.AndroidDeviceInfo? androidDeviceInfo;

  /// Information derived from `UIDevice`.
  ///
  /// See: https://developer.apple.com/documentation/uikit/uidevice
  ///
  device_info.IosDeviceInfo? iosDeviceInfo;

  /// Information derived from `navigator`.
  ///
  /// See: https://developer.mozilla.org/en-US/docs/Web/API/Window/navigator
  ///
  device_info.WebBrowserInfo? webDeviceInfo;

  @override
  Future<void> init() async {
    await super.init();
    if (kIsWeb) {
      webDeviceInfo = await device_info.DeviceInfoPlugin().webBrowserInfo;
    } else {
      if (Platform.isAndroid) {
        androidDeviceInfo = await device_info.DeviceInfoPlugin().androidInfo;
      }
      if (Platform.isIOS) {
        iosDeviceInfo = await device_info.DeviceInfoPlugin().iosInfo;
      }
    }
  }
}
