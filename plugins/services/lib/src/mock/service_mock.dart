import 'dart:math' as dart_math;

import 'package:generic_shop_app_api/api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

part 'values/service_mock_values_category.dart';
part 'values/service_mock_values_city.dart';
part 'values/service_mock_values_country.dart';
part 'values/service_mock_values_herbalife_images.dart';
part 'values/service_mock_values_merchant_name.dart';
part 'values/service_mock_values_personal_name.dart';
part 'values/service_mock_values_sale_item_name.dart';
part 'values/service_mock_values_prices.dart';
part 'values/service_mock_values_state.dart';
part 'values/service_mock_values_street.dart';

/// Data mocking services used for debugging and automated testing.
///
class GsaServiceMock extends GsaService {
  GsaServiceMock._();

  static final _instance = GsaServiceMock._();

  // ignore: public_member_api_docs
  static GsaServiceMock get instance => _instance() as GsaServiceMock;

  bool? _enabled;

  @override
  bool get enabled => _enabled != false;

  /// Generates a random string of [length]
  /// with options to [includeChars], [includeNumbers], and [includeSpecialChars].
  ///
  String generateRandomString(
    int length, {
    bool includeChars = true,
    bool includeNumbers = true,
    bool includeSpecialChars = false,
  }) {
    final validParameters = length > 0 && (includeChars || includeNumbers || includeSpecialChars);
    assert(validParameters);
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    const numbers = '1234567890';
    const specialChars = '!@#%^&*()_-+={}[]|:;"<>,.?/~`';
    String value = '';
    while (validParameters && value.length < length) {
      switch (dart_math.Random().nextInt(3)) {
        case 0:
          if (includeChars) value += chars[dart_math.Random().nextInt(chars.length)];
          break;
        case 1:
          if (includeNumbers) value += numbers[dart_math.Random().nextInt(numbers.length)];
          break;
        case 2:
          if (includeSpecialChars) value += specialChars[dart_math.Random().nextInt(specialChars.length)];
          break;
      }
    }
    return value;
  }

  String get _randomMerchantName {
    return _valueMerchantNames[dart_math.Random().nextInt(_valueMerchantNames.length)];
  }

  String get _randomCityName {
    return _valueCities[dart_math.Random().nextInt(_valueCities.length)];
  }

  String get _randomStateName {
    return _valueStates[dart_math.Random().nextInt(_valueStates.length)];
  }

  String get _randomCountryName {
    return _valueCountries[dart_math.Random().nextInt(_valueCountries.length)];
  }

  String get _randomPersonalName {
    return _valuePersonalNames[dart_math.Random().nextInt(_valuePersonalNames.length)];
  }

  String get _randomStreetName {
    return _valueStreets[dart_math.Random().nextInt(_valueStreets.length)];
  }

  String get _randomSaleItemName {
    return _valueSaleItemNames[dart_math.Random().nextInt(_valueSaleItemNames.length)];
  }

  String get _randomCategoryName {
    return _valueCategories[dart_math.Random().nextInt(_valueCategories.length)];
  }

  @override
  Future<void> init() async {
    await super.init();
    final herbalifeDataJson = {}; // dart_convert.jsonDecode(await dart_io.File('${}/assets/mock/herbalife_catalogue.json'));
    late List<GsaModelCategory> mockCategories;
    mockCategories = (herbalifeDataJson['categories'] as Iterable)
        .map(
          (categoryJson) => GsaModelCategory.fromJson(Map<dynamic, dynamic>.from(categoryJson)),
        )
        .toList();
    late List<GsaModelSaleItem> mockSaleItems;
    mockSaleItems = (herbalifeDataJson['saleItems'] as Iterable)
        .map(
          (saleItemJson) => GsaModelSaleItem.fromJson(Map<dynamic, dynamic>.from(saleItemJson))
            ..categoryId = mockCategories[dart_math.Random().nextInt(mockCategories.length)].id,
        )
        .toList();
    late List<GsaModelSaleItem> mockDeliveryOptions;
    mockDeliveryOptions = (herbalifeDataJson['deliveryOptions'] as Iterable)
        .map(
          (saleItemJson) => GsaModelSaleItem.fromJson(Map<dynamic, dynamic>.from(saleItemJson)),
        )
        .toList();
    late List<GsaModelSaleItem> mockPaymentOptions;
    mockPaymentOptions = (herbalifeDataJson['paymentOptions'] as Iterable)
        .map(
          (saleItemJson) => GsaModelSaleItem.fromJson(Map<dynamic, dynamic>.from(saleItemJson)),
        )
        .toList();
  }
}
