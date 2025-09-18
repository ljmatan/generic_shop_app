import 'dart:math' as dart_math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/arch.dart';
import 'package:device_info_plus/device_info_plus.dart' as device_info;
import 'package:package_info_plus/package_info_plus.dart' as package_info;

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

  /// Object encapsulating MACOS device information.
  ///
  device_info.MacOsDeviceInfo? macOsDeviceInfo;

  /// Device information for a Linux system.
  ///
  /// See:
  /// - https://www.freedesktop.org/software/systemd/man/os-release.html
  /// - https://www.freedesktop.org/software/systemd/man/machine-id.html
  ///
  device_info.LinuxDeviceInfo? linuxDeviceInfo;

  /// Object encapsulating WINDOWS device information.
  ///
  device_info.WindowsDeviceInfo? windowsDeviceInfo;

  /// Application metadata.
  ///
  /// Provides application bundle information on iOS and application package information on Android.
  ///
  late package_info.PackageInfo _packageInfo;

  /// A unique identifier assigned to this device.
  ///
  /// In order to attempt avoiding duplicate ID entries across the userbase,
  /// the ID is derived from the following:
  ///
  /// - Collection of random characters
  /// - App client identifier
  /// - Installed app version number
  /// - GSA library version identifier
  ///
  String? deviceId;

  /// Generates a new, unique device identifier,
  /// if not found recorded to the permanent device storage.
  ///
  Future<void> _generateDeviceId(BuildContext context) async {
    final cachedDeviceId = GsaServiceCacheEntry.deviceId.value;
    if (cachedDeviceId is String && cachedDeviceId.isNotEmpty) {
      deviceId = cachedDeviceId;
    } else {
      String generateRandomString(int length) {
        const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
        final rand = dart_math.Random.secure();
        return List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join();
      }

      String hashString(String input) {
        var hash = 0;
        for (var i = 0; i < input.length; i++) {
          hash = 0x1fffffff & (hash + input.codeUnitAt(i));
          hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
          hash ^= (hash >> 6);
        }
        hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
        hash ^= (hash >> 11);
        hash = 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
        return (hash & 0x7fffffff).toRadixString(16).padLeft(8, '0');
      }

      final randomPart = generateRandomString(12);

      final clientName = GsaPlugin.of(context).client.name;

      final clientHash = hashString(clientName);

      final appVersion = _packageInfo.version;

      final gsaLibVersion = GsaConfig.version;

      deviceId = '$randomPart-$clientHash-$appVersion-$gsaLibVersion';

      await GsaServiceCacheEntry.deviceId.setValue(deviceId);
    }
  }

  @override
  Future<void> init(BuildContext context) async {
    await super.init(context);
    final deviceInfoPlugin = device_info.DeviceInfoPlugin();
    if (kIsWeb) {
      webDeviceInfo = await deviceInfoPlugin.webBrowserInfo;
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          androidDeviceInfo = await deviceInfoPlugin.androidInfo;
          break;
        case TargetPlatform.iOS:
          iosDeviceInfo = await deviceInfoPlugin.iosInfo;
          break;
        case TargetPlatform.macOS:
          macOsDeviceInfo = await deviceInfoPlugin.macOsInfo;
          break;
        case TargetPlatform.linux:
          linuxDeviceInfo = await deviceInfoPlugin.linuxInfo;
          break;
        case TargetPlatform.windows:
          windowsDeviceInfo = await deviceInfoPlugin.windowsInfo;
          break;
        default:
          throw UnimplementedError(
            'No device setup available for platform $defaultTargetPlatform',
          );
      }
    }
    _packageInfo = await package_info.PackageInfo.fromPlatform();
    await _generateDeviceId(context);
  }
}
