import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:generic_shop_app/services/services.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

/// Service responsible for opening external apps via specified addresses.
///
/// Implemented with [url_launcher](https://pub.dev/packages/url_launcher).
///
class GsaServiceUrlLauncher extends GsaService {
  GsaServiceUrlLauncher._();

  static final _instance = GsaServiceUrlLauncher._();

  // ignore: public_member_api_docs
  static GsaServiceUrlLauncher get instance => _instance() as GsaServiceUrlLauncher;

  /// Invokes the [launchUrl] method provided by the url_launcher package.
  ///
  /// Throws an exception if the invocation was unsuccessful.
  ///
  Future<void> _launch(String uri) async {
    if (!await url_launcher.launchUrl(Uri.parse(uri))) {
      throw 'Failed to launch URL: $uri';
    }
  }

  /// Launches a http or https URL in an external browser.
  ///
  Future<void> launchWeb(
    String url,
  ) async {
    await _launch(url);
  }

  /// Launches the email app with the specified email address.
  ///
  Future<void> launchEmail(
    String email,
  ) async {
    await _launch('mailto:$email');
  }

  /// Launches the text messaging app with the specified number.
  ///
  Future<void> launchSms(
    String number,
  ) async {
    await _launch('sms:$number');
  }

  /// Launches the dialer app with the specified phone number.
  ///
  Future<void> launchCall(
    String number,
  ) async {
    await _launch('tel:$number');
  }

  /// Launches the external maps app.
  ///
  Future<void> launchMaps(
    double latitude,
    double longitude, {
    String? displayName,
  }) async {
    launchWeb(
      !kIsWeb && Platform.isIOS
          ? 'http://maps.apple.com/?ll=$latitude,$longitude'
          : 'https://www.google.com/maps/search/?api=1&query="$displayName $latitude,$longitude"',
    );
  }
}
