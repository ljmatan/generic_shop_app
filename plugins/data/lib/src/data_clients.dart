import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Data class implementing the client records, methods and properties.
///
class GsaDataClients extends GsaData {
  GsaDataClients._();

  /// Globally-accessible singleton class instance.
  ///
  static final instance = GsaDataClients._();

  /// List of available merchants, if more than one are specified.
  ///
  final collection = <GsaModelClient>[];

  @override
  Future<void> init({
    List<GsaModelClient>? clients,
  }) async {
    clear();
    if (clients != null) {
      instance.collection.addAll(clients);
    }
  }

  @override
  void clear() {
    collection.clear();
  }
}
