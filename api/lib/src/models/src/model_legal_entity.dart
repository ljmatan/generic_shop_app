import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

@GsarModelMacro()
class GsaModelLegalEntity {
  GsaModelLegalEntity({
    required this.name,
    required this.address,
  });

  String? name;

  GsaaModelAddress? address;
}
