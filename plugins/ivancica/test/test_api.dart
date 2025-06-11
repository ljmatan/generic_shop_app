import 'package:generic_shop_app_ivancica/src/api/_api.dart';

void main() async {
  print(
    await GivApiUser.instance.login(
      email: 'aaaaa@bbbb.com',
      password: 'Password1!',
    ),
  );
  print(await GivApiProducts.instance.getProducts());
}
