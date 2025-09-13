import 'dart:math' as dart_math;

import 'package:generic_shop_app_architecture/arch.dart';

part 'values/service_mock_values_category.dart';
part 'values/service_mock_values_city.dart';
part 'values/service_mock_values_country.dart';
part 'values/service_mock_values_merchant_name.dart';
part 'values/service_mock_values_personal_name.dart';
part 'values/service_mock_values_sale_item_name.dart';
part 'values/service_mock_values_prices.dart';
part 'values/service_mock_values_state.dart';
part 'values/service_mock_values_street.dart';
part 'values/service_mock_values_words.dart';

/// Data mocking services used for debugging and automated testing.
///
class GsdServiceMock extends GsaService {
  GsdServiceMock._();

  static final _instance = GsdServiceMock._();

  /// Globally-accessible class instance.
  ///
  static GsdServiceMock get instance => _instance() as GsdServiceMock;

  @override
  bool get critical {
    return true;
  }

  final _random = dart_math.Random();

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
      switch (_random.nextInt(3)) {
        case 0:
          if (includeChars) value += chars[_random.nextInt(chars.length)];
          break;
        case 1:
          if (includeNumbers) value += numbers[_random.nextInt(numbers.length)];
          break;
        case 2:
          if (includeSpecialChars) value += specialChars[_random.nextInt(specialChars.length)];
          break;
      }
    }
    return value;
  }

  /// Returns an ID value not already found in the specified [collection].
  ///
  String generateUniqueId<T>({
    required Iterable<T> collection,
    required String Function(T value) comparisonId,
  }) {
    String id = generateRandomString(10);
    while (collection.any(
      (item) {
        return comparisonId(item) == id;
      },
    )) {
      id = generateRandomString(10);
    }
    return id;
  }

  /// Returns a random entry from the provided [collection].
  ///
  dynamic getRandomEntry<T>(Iterable<T> collection) {
    return collection.elementAt(
      _random.nextInt(collection.length),
    );
  }

  /// Returns a random text description.
  ///
  String generateRandomDescription({
    int minWords = 20,
    int maxWords = 50,
  }) {
    final length = minWords + _random.nextInt(maxWords - minWords + 1);
    final buffer = StringBuffer();
    int wordsInSentence = 0;
    int sentenceLength = 4 + _random.nextInt(8);
    for (var i = 0; i < length; i++) {
      String w = getRandomEntry<String>(_valueWords);
      if (wordsInSentence == 0) {
        w = w[0].toUpperCase() + w.substring(1);
      }
      buffer.write(w);
      wordsInSentence++;
      if (wordsInSentence >= sentenceLength || i == length - 1) {
        buffer.write('. ');
        wordsInSentence = 0;
        sentenceLength = 4 + _random.nextInt(8);
      } else {
        buffer.write(' ');
      }
    }
    return buffer.toString().trim();
  }

  @override
  Future<void> init() async {
    await super.init();
    // Register product categories.
    final mockCategories = <({
      String id,
      String name,
    })>[];
    for (int i = 0; i < _valueCategories.length; i++) {
      final id = generateUniqueId(
        collection: mockCategories,
        comparisonId: (mockCategory) {
          return mockCategory.id;
        },
      );
      mockCategories.add(
        (
          id: id,
          name: _valueCategories[i],
        ),
      );
    }
    final serialisedCategories = mockCategories.map(
      (mockCategory) {
        return GsaModelCategory(
          id: mockCategory.id,
          name: mockCategory.name,
          description: generateRandomDescription(),
        );
      },
    ).toList();
    GsaDataSaleItems.instance.categories = serialisedCategories;
    // Register sale items.
    final mockSaleItems = <({
      String id,
      String name,
      int priceCentum,
    })>[];
    for (int i = 0; i < _valueSaleItemNames.length; i++) {
      final id = generateUniqueId(
        collection: mockSaleItems,
        comparisonId: (mockSaleItem) {
          return mockSaleItem.id;
        },
      );
      mockSaleItems.add(
        (
          id: id,
          name: _valueSaleItemNames[i],
          priceCentum: getRandomEntry(_valuePrices) as int,
        ),
      );
    }
    final serialisedSaleItems = mockSaleItems.map(
      (mockSaleItem) {
        return GsaModelSaleItem(
          id: mockSaleItem.id,
          name: mockSaleItem.name,
          categoryId: (getRandomEntry(
            GsaDataSaleItems.instance.categories,
          ) as GsaModelCategory)
              .id,
          description: generateRandomDescription(),
          price: GsaModelPrice(
            centum: mockSaleItem.priceCentum,
          ),
        );
      },
    ).toList();
    GsaDataSaleItems.instance.collection = serialisedSaleItems;
    // Filter categories to include only relevant results.
    GsaDataSaleItems.instance.categories.removeWhere(
      (category) {
        return !GsaDataSaleItems.instance.collection.any(
          (saleItem) {
            return saleItem.categoryId == category.id;
          },
        );
      },
    );
    // Register delivery options.
    final mockDeliveryOptionsSerialised = <GsaModelSaleItem>[];
    for (final deliveryOption in <({
      String name,
      int priceCentum,
      bool delivered,
    })>{
      (
        name: 'Pickup',
        priceCentum: 0,
        delivered: false,
      ),
      (
        name: 'Delivery',
        priceCentum: 1000,
        delivered: true,
      ),
    }.indexed) {
      final id = generateUniqueId(
        collection: mockDeliveryOptionsSerialised,
        comparisonId: (mockDeliveryOption) {
          return mockDeliveryOption.id ?? 'N/A';
        },
      );
      final option = GsaModelSaleItem(
        id: id,
        name: deliveryOption.$2.name,
        price: GsaModelPrice(
          centum: deliveryOption.$2.priceCentum,
        ),
        delivered: deliveryOption.$2.delivered,
      );
      mockDeliveryOptionsSerialised.add(option);
    }
    GsaDataSaleItems.instance.deliveryOptions = mockDeliveryOptionsSerialised;
    // Register payment options.
    final mockPaymentOptionsSerialised = <GsaModelSaleItem>[];
    for (final paymentOption in <({
      String name,
      int priceCentum,
      bool delivered,
    })>{
      (
        name: 'Cash at Pickup',
        priceCentum: 300,
        delivered: false,
      ),
      (
        name: 'Credit Card',
        priceCentum: 0,
        delivered: true,
      ),
    }.indexed) {
      final id = generateUniqueId(
        collection: mockPaymentOptionsSerialised,
        comparisonId: (mockPaymentOption) {
          return mockPaymentOption.id ?? 'N/A';
        },
      );
      final option = GsaModelSaleItem(
        id: id,
        name: paymentOption.$2.name,
        price: GsaModelPrice(
          centum: paymentOption.$2.priceCentum,
        ),
        delivered: paymentOption.$2.delivered,
      );
      mockPaymentOptionsSerialised.add(option);
    }
    GsaDataSaleItems.instance.paymentOptions = mockPaymentOptionsSerialised;
  }
}
