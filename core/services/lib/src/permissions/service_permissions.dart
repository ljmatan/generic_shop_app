import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;

/// Service implemented for operating system permission handling.
///
class GsaServicePermissions extends GsaService {
  GsaServicePermissions._();

  static final _instance = GsaServicePermissions._();

  /// Globally-accessible singleton class instance.
  ///
  static GsaServicePermissions get instance => _instance() as GsaServicePermissions;

  /// Retrivies and returns the relevant [permission] grant status.
  ///
  Future<bool> getPermissionStatus(
    permission_handler.Permission permission,
  ) async {
    return await permission.isGranted || await permission.isLimited || await permission.isProvisional;
  }

  /// Requests the specified [permission] and returns `true` if the permission has been granted.
  ///
  Future<bool> requestPermission(
    permission_handler.Permission permission,
  ) async {
    final requestResult = await permission.request();
    return {
      permission_handler.PermissionStatus.granted,
      permission_handler.PermissionStatus.limited,
      permission_handler.PermissionStatus.provisional,
    }.contains(requestResult);
  }
}
