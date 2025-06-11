import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';

class GivModelProduct {
  int? proId;
  String? productCode;
  String? productName;
  String? productDescription;
  String? alfaCode;
  int? givesLoyaltyPoints;
  String? freeDelivery;
  String? availableSizes;
  String? brand;
  String? mold;
  String? type;
  String? boys;
  String? girls;
  String? unisex;
  String? woman;
  String? man;
  List<String>? tags;
  List<GivModelProductImage>? images;
  List<GivModelProductPrice>? prices;
  List<GivModelProductStock>? stocks;
  List<String>? icons;
  List<GivModelProductAttribute>? attributes;

  GivModelProduct({
    this.proId,
    this.productCode,
    this.productName,
    this.productDescription,
    this.alfaCode,
    this.givesLoyaltyPoints,
    this.freeDelivery,
    this.availableSizes,
    this.brand,
    this.mold,
    this.type,
    this.boys,
    this.girls,
    this.unisex,
    this.woman,
    this.man,
    this.tags,
    this.images,
    this.prices,
    this.stocks,
    this.icons,
    this.attributes,
  });

  factory GivModelProduct.fromJson(Map<String, dynamic> json) => GivModelProduct(
        proId: json['proId'],
        productCode: json['productCode'],
        productName: json['productName'],
        productDescription: json['productDescription'],
        alfaCode: json['alfaCode'],
        givesLoyaltyPoints: json['givesLoyaltyPoints'],
        freeDelivery: json['freeDelivery'],
        availableSizes: json['availableSizes'],
        brand: json['brand'],
        mold: json['mold'],
        type: json['type'],
        boys: json['boys'],
        girls: json['girls'],
        unisex: json['unisex'],
        woman: json['woman'],
        man: json['man'],
        tags: json['tags'] == null ? [] : List<String>.from(json['tags']!.map((x) => x)),
        images: json['images'] == null ? [] : List<GivModelProductImage>.from(json['images']!.map((x) => GivModelProductImage.fromJson(x))),
        prices: json['prices'] == null ? [] : List<GivModelProductPrice>.from(json['prices']!.map((x) => GivModelProductPrice.fromJson(x))),
        stocks: json['stocks'] == null ? [] : List<GivModelProductStock>.from(json['stocks']!.map((x) => GivModelProductStock.fromJson(x))),
        icons: json['icons'] == null ? [] : List<String>.from(json['icons']!.map((x) => x)),
        attributes: json['attributes'] == null
            ? []
            : List<GivModelProductAttribute>.from(json['attributes']!.map((x) => GivModelProductAttribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'proId': proId,
        'productCode': productCode,
        'productName': productName,
        'productDescription': productDescription,
        'alfaCode': alfaCode,
        'givesLoyaltyPoints': givesLoyaltyPoints,
        'freeDelivery': freeDelivery,
        'availableSizes': availableSizes,
        'brand': brand,
        'mold': mold,
        'type': type,
        'boys': boys,
        'girls': girls,
        'unisex': unisex,
        'woman': woman,
        'man': man,
        'tags': tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        'images': images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
        'prices': prices == null ? [] : List<dynamic>.from(prices!.map((x) => x.toJson())),
        'stocks': stocks == null ? [] : List<dynamic>.from(stocks!.map((x) => x.toJson())),
        'icons': icons == null ? [] : List<dynamic>.from(icons!.map((x) => x)),
        'attributes': attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x.toJson())),
      };

  /// Encodes the class to the [GsaModelSaleItem] type, supported by the GSA project.
  ///
  GsaModelSaleItem toSupportedType() {
    return GsaModelSaleItem(
      id: proId?.toString(),
      productCode: productCode,
      name: productName,
      description: productDescription?.isNotEmpty == true ? productDescription : null,
      imageUrls: images == null
          ? null
          : List<String>.from(
              images!.map((image) => image.link).where((imageUrl) => imageUrl != null),
            ),
      attributeIconUrls: icons,
      options: prices != null
          ? [
              for (final option in prices!)
                GsaModelSaleItem(
                  name: option.size,
                  availability: [
                    (
                      locationId: stocks?.firstWhereOrNull((stock) => stock.size == option.size)?.shop,
                      count: stocks?.firstWhereOrNull((stock) => stock.size == option.size)?.available,
                    ),
                  ]..removeWhere(
                      (availabilityInfo) => availabilityInfo.locationId == null && availabilityInfo.count == null,
                    ),
                  price: GsaModelPrice(
                    currencyType: GsaModelPriceCurrencyType.eur,
                    centum: option.oldPrice != null && option.oldPrice != 0 ? option.oldPrice : option.price,
                    discount: option.oldPrice != null && option.oldPrice != 0 && option.price != null
                        ? GsaModelDiscount(centum: option.price! - option.oldPrice!)
                        : null,
                  ),
                ),
            ]
          : null,
      tags: tags,
      informationList: attributes != null
          ? [
              for (final attribute in attributes!)
                if (attribute.attribute != null && attribute.values?.isNotEmpty == true)
                  for (final attributeValue in attribute.values!)
                    if (attributeValue.value != null)
                      (
                        label: attribute.attribute!,
                        description: attributeValue.value!,
                      ),
            ]
          : null,
    );
  }
}

class GivModelProductAttribute {
  String? attribute;
  List<GivModelProductValue>? values;

  GivModelProductAttribute({
    this.attribute,
    this.values,
  });

  factory GivModelProductAttribute.fromRawJson(String str) => GivModelProductAttribute.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GivModelProductAttribute.fromJson(Map<String, dynamic> json) => GivModelProductAttribute(
        attribute: json['attribute'],
        values: json['values'] == null
            ? []
            : List<GivModelProductValue>.from(
                json['values']!.map(
                  (x) => GivModelProductValue.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        'attribute': attribute,
        'values': values == null ? [] : List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class GivModelProductValue {
  String? value;

  GivModelProductValue({
    this.value,
  });

  factory GivModelProductValue.fromRawJson(String str) => GivModelProductValue.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GivModelProductValue.fromJson(Map<String, dynamic> json) => GivModelProductValue(
        value: json['value'],
      );

  Map<String, dynamic> toJson() => {
        'value': value,
      };
}

class GivModelProductImage {
  String? link;
  String? type;

  GivModelProductImage({
    this.link,
    this.type,
  });

  factory GivModelProductImage.fromRawJson(String str) => GivModelProductImage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GivModelProductImage.fromJson(Map<String, dynamic> json) => GivModelProductImage(
        link: json['link'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'link': link,
        'type': type,
      };
}

class GivModelProductPrice {
  String? size;
  int? price;
  int? oldPrice;

  GivModelProductPrice({
    this.size,
    this.price,
    this.oldPrice,
  });

  factory GivModelProductPrice.fromRawJson(String str) => GivModelProductPrice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GivModelProductPrice.fromJson(Map<String, dynamic> json) => GivModelProductPrice(
        size: json['size'],
        price: json['price'],
        oldPrice: json['oldPrice'],
      );

  Map<String, dynamic> toJson() => {
        'size': size,
        'price': price,
        'oldPrice': oldPrice,
      };
}

class GivModelProductStock {
  String? size;
  int? available;
  String? shop;

  GivModelProductStock({
    this.size,
    this.available,
    this.shop,
  });

  factory GivModelProductStock.fromRawJson(String str) => GivModelProductStock.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GivModelProductStock.fromJson(Map<String, dynamic> json) => GivModelProductStock(
        size: json['size'],
        available: json['available'],
        shop: json['shop'],
      );

  Map<String, dynamic> toJson() => {
        'size': size,
        'available': available,
        'shop': shop,
      };
}
