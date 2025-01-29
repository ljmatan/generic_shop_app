import 'package:generic_shop_app_ivancica/api/api.dart';

void main() async {
  print(await GivApiProducts.instance.getProducts());
}
