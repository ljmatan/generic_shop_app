import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_architecture/arch.dart';

/// API endpoint call and handling implementation references.
///
extension GsaEndpointsOrdersImplExt on GsaEndpointsOrders {
  Function get implementation {
    switch (this) {
      case GsaEndpointsOrders.register:
        return GsaApiOrders.instance.register;
      case GsaEndpointsOrders.deleteAll:
        return GsaApiOrders.instance.deleteAll;
      case GsaEndpointsOrders.deleteSoft:
        return GsaApiOrders.instance.deleteSoft;
      case GsaEndpointsOrders.createOrUpdateDraft:
        return GsaApiOrders.instance.createOrUpdateDraft;
      case GsaEndpointsOrders.confirmDraft:
        return GsaApiOrders.instance.confirmDraft;
    }
  }
}

/// Checkout and order related client APIs.
///
class GsaApiOrders extends GsaApi {
  const GsaApiOrders._();

  static const instance = GsaApiOrders._();

  @override
  String get protocol => 'http';

  /// Registers a given [order] to the system.
  ///
  /// This is not an endpoint which should tipically be used by the clients,
  /// it's instead implemented for maintenance purposes.
  ///
  Future<String> register({required GsaModelOrderDraft order}) async {
    final response = await post(GsaEndpointsOrders.register.path, order.toJson());
    final orderId = response['orderId'];
    if (orderId == null) {
      throw 'Order ID missing from registration response.';
    } else {
      return orderId;
    }
  }

  /// Deletes an order with the specific [orderId] from the system database.
  ///
  Future<void> deleteAll({required String orderId}) async {
    await delete(GsaEndpointsOrders.deleteAll.path, body: {'orderId': orderId});
  }

  /// Marks an order as being deleted, without deleting the actual data.
  ///
  Future<void> deleteSoft({required String orderId}) async {
    await delete(GsaEndpointsOrders.deleteSoft.path, body: {'orderId': orderId});
  }

  /// Creates or updates an order draft, and returns the associated details from the server.
  ///
  Future<GsaModelOrderDraft> createOrUpdateDraft({required GsaModelOrderDraft order}) async {
    final response = await post(GsaEndpointsOrders.createOrUpdateDraft.path, order.toJson());
    return GsaModelOrderDraft.fromJson(response);
  }

  /// Marks the order as confirmed from the user side.
  ///
  Future<String> confirmDraft({required GsaModelOrderDraft order}) async {
    final response = await post(GsaEndpointsOrders.confirmDraft.path, order.toJson());
    final orderId = response['orderId'];
    if (orderId == null) {
      throw 'Order ID missing from registration response.';
    } else {
      return orderId;
    }
  }
}
