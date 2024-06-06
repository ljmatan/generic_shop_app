/// Various server HTTP API endpoint definitions.

library endpoints;

part 'src/endpoints_aggregated.dart';
part 'src/endpoints_merchants.dart';
part 'src/endpoints_orders.dart';
part 'src/endpoints_sale_items.dart';
part 'src/endpoints_users.dart';

enum _EndpointMethodType {
  getRequest,
  postRequest,
  patchRequest,
  putRequest,
  deleteRequest,
}

extension _EndpointMethodTypeExt on _EndpointMethodType {
  String get id {
    switch (this) {
      case _EndpointMethodType.getRequest:
        return 'GET';
      case _EndpointMethodType.postRequest:
        return 'POST';
      case _EndpointMethodType.patchRequest:
        return 'PATCH';
      case _EndpointMethodType.putRequest:
        return 'PUT';
      case _EndpointMethodType.deleteRequest:
        return 'DELETE';
    }
  }
}
