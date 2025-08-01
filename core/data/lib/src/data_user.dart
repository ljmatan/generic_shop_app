import 'package:flutter/material.dart';
import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_services/services.dart';

/// Data class implementing the app user methods and properties.
///
class GsaDataUser extends GsaData {
  GsaDataUser._();

  /// Globally-accessible singleton class instance.
  ///
  static final instance = GsaDataUser._();

  /// Application user data instance property.
  ///
  GsaModelUser? user;

  /// Whether the user is authenticated against the backend.
  ///
  bool get authenticated => user != null;

  @override
  Future<void> init({
    GsaModelUser? user,
  }) async {
    clear();
    instance.user = user;
  }

  @override
  void clear() {
    user = null;
  }

  /// Logs out the user and deletes any relevant application data.
  ///
  Future<void> logout([BuildContext? context]) async {
    context ??= GsaRoute.navigatorKey.currentContext;
    if (context != null) {
      const GsaWidgetOverlayContentBlocking().openDialog();
    }
    try {
      await GsaServiceCache.instance.clearData();
      GsaData.clearAll();
    } catch (e) {
      if (context != null) {
        Navigator.pop(context);
      }
      GsaWidgetOverlayAlert(
        '$e',
      ).openDialog();
    }
    GsaConfig.plugin.initialRoute().push(replacement: true);
  }
}
