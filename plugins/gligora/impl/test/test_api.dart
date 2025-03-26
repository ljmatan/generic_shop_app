import 'package:generic_shop_app_gligora/api/api.dart';

void main() async {
  print(await GliApiProducts.instance.getProducts());
}
