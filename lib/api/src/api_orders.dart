import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// API endpoint call and handling implementation references.
///
extension GsaaEndpointsOrdersImplExt on GsaaEndpointsOrders {
  Function get implementation {
    switch (this) {
      case GsaaEndpointsOrders.register:
        return GsaaApiOrders.instance.register;
      case GsaaEndpointsOrders.deleteAll:
        return GsaaApiOrders.instance.deleteAll;
      case GsaaEndpointsOrders.deleteSoft:
        return GsaaApiOrders.instance.deleteSoft;
      case GsaaEndpointsOrders.createOrUpdateDraft:
        return GsaaApiOrders.instance.createOrUpdateDraft;
      case GsaaEndpointsOrders.confirmDraft:
        return GsaaApiOrders.instance.confirmDraft;
    }
  }
}

/// Checkout and order related client APIs.
///
class GsaaApiOrders extends GsarApi {
  const GsaaApiOrders._();

  static const instance = GsaaApiOrders._();

  @override
  String get protocol => 'http';

  @override
  String get identifier => 'orders';

  @override
  int get version => 0;

  /// Registers a given [order] to the system.
  ///
  /// This is not an endpoint which should tipically be used by the clients,
  /// it's instead implemented for maintenance purposes.
  ///
  Future<String> register({
    required GsaaModelOrderDraft order,
  }) async {
    final response = await post(
      GsaaEndpointsOrders.register.path,
      order.toJson(),
    );
    final orderId = response['orderId'];
    if (orderId == null) {
      throw 'Order ID missing from registration response.';
    } else {
      return orderId;
    }
  }

  /// Deletes an order with the specific [orderId] from the system database.
  ///
  Future<void> deleteAll({
    required String orderId,
  }) async {
    await delete(
      GsaaEndpointsOrders.deleteAll.path,
      body: {
        'orderId': orderId,
      },
    );
  }

  /// Marks an order as being deleted, without deleting the actual data.
  ///
  Future<void> deleteSoft({
    required String orderId,
  }) async {
    await delete(
      GsaaEndpointsOrders.deleteSoft.path,
      body: {
        'orderId': orderId,
      },
    );
  }

  /// Creates or updates an order draft, and returns the associated details from the server.
  ///
  Future<GsaaModelOrderDraft> createOrUpdateDraft({
    required GsaaModelOrderDraft order,
  }) async {
    final response = await post(
      GsaaEndpointsOrders.createOrUpdateDraft.path,
      order.toJson(),
    );
    return GsaaModelOrderDraft.fromJson(response);
  }

  /// Marks the order as confirmed from the user side.
  ///
  Future<String> confirmDraft({
    required GsaaModelOrderDraft order,
  }) async {
    final response = await post(
      GsaaEndpointsOrders.confirmDraft.path,
      order.toJson(),
    );
    final orderId = response['orderId'];
    if (orderId == null) {
      throw 'Order ID missing from registration response.';
    } else {
      return orderId;
    }
  }
}
