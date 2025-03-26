import 'dart:convert';

import 'package:generic_shop_app_api/generic_shop_app_api.dart';

class GliModelProduct {
  String? id;
  int? type;
  String? className;
  String? currency;
  String? name;
  String? slug;
  String? description;
  String? shortDescription;
  String? price;
  dynamic priceWithDiscount;
  String? pricePerUnitOfMeasure;
  dynamic alternativeUnitOfMeasure;
  int? availability;
  dynamic variantLabel;
  String? lowestPrice;
  int? vatRate;
  String? code;
  String? harvest;
  double? weight;
  dynamic appliedDiscount;
  List<List<GliModelProductCategory>>? productCategories;
  List<String>? piktograms;
  List<GliModelProductVariant>? variants;
  String? media;
  int? rating;
  bool? userLiked;
  String? unitOfMeasure;
  int? reviewsCount;
  DateTime? createdAt;
  DateTime? updatedAt;

  GliModelProduct({
    this.id,
    this.type,
    this.className,
    this.currency,
    this.name,
    this.slug,
    this.description,
    this.shortDescription,
    this.price,
    this.priceWithDiscount,
    this.pricePerUnitOfMeasure,
    this.alternativeUnitOfMeasure,
    this.availability,
    this.variantLabel,
    this.lowestPrice,
    this.vatRate,
    this.code,
    this.harvest,
    this.weight,
    this.appliedDiscount,
    this.productCategories,
    this.piktograms,
    this.variants,
    this.media,
    this.rating,
    this.userLiked,
    this.unitOfMeasure,
    this.reviewsCount,
    this.createdAt,
    this.updatedAt,
  });

  factory GliModelProduct.fromRawJson(String str) => GliModelProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GliModelProduct.fromJson(Map<String, dynamic> json) => GliModelProduct(
        id: json["id"],
        type: json["type"],
        className: json["class_name"],
        currency: json["currency"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        shortDescription: json["short_description"],
        price: json["price"],
        priceWithDiscount: json["price_with_discount"],
        pricePerUnitOfMeasure: json["price_per_unit_of_measure"],
        alternativeUnitOfMeasure: json["alternative_unit_of_measure"],
        availability: json["availability"],
        variantLabel: json["variant_label"],
        lowestPrice: json["lowest_price"],
        vatRate: json["vat_rate"],
        code: json["code"],
        harvest: json["harvest"],
        weight: json["weight"]?.toDouble(),
        appliedDiscount: json["applied_discount"],
        productCategories: json["product_categories"] == null
            ? []
            : List<List<GliModelProductCategory>>.from(json["product_categories"]!
                .map((x) => List<GliModelProductCategory>.from(x.map((x) => GliModelProductCategory.fromJson(x))))),
        piktograms: json["piktograms"] == null ? [] : List<String>.from(json["piktograms"]!.map((x) => x)),
        variants: json["variants"] == null
            ? []
            : List<GliModelProductVariant>.from(json["variants"]!.map((x) => GliModelProductVariant.fromJson(x))),
        media: json["media"],
        rating: json["rating"],
        userLiked: json["user_liked"],
        unitOfMeasure: json["unit_of_measure"],
        reviewsCount: json["reviews_count"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "class_name": className,
        "currency": currency,
        "name": name,
        "slug": slug,
        "description": description,
        "short_description": shortDescription,
        "price": price,
        "price_with_discount": priceWithDiscount,
        "price_per_unit_of_measure": pricePerUnitOfMeasure,
        "alternative_unit_of_measure": alternativeUnitOfMeasure,
        "availability": availability,
        "variant_label": variantLabel,
        "lowest_price": lowestPrice,
        "vat_rate": vatRate,
        "code": code,
        "harvest": harvest,
        "weight": weight,
        "applied_discount": appliedDiscount,
        "product_categories": productCategories == null
            ? []
            : List<dynamic>.from(productCategories!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "piktograms": piktograms == null ? [] : List<dynamic>.from(piktograms!.map((x) => x)),
        "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "media": media,
        "rating": rating,
        "user_liked": userLiked,
        "unit_of_measure": unitOfMeasure,
        "reviews_count": reviewsCount,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  /// Encodes the class to the [GsaModelSaleItem] type, supported by the GSA project.
  ///
  GsaModelSaleItem toSupportedType() {
    return GsaModelSaleItem(
      id: id,
      name: name,
      description: description?.isNotEmpty == true ? description : null,
      imageUrls: media == null
          ? null
          : <String>[
              media!,
            ],
      options: variants != null
          ? [
              for (final option in variants!)
                GsaModelSaleItem(
                  name: option.parentName,
                  imageUrls: option.media != null ? <String>[option.media!] : null,
                  price: GsaModelPrice(
                    currencyType: GsaModelPriceCurrencyType.eur,
                    centum: option.price?.isNotEmpty == true ? (double.parse(option.price!) * 100).round() : null,
                  ),
                ),
            ]
          : null,
      price: GsaModelPrice(
        currencyType: GsaModelPriceCurrencyType.eur,
        centum: price?.isNotEmpty == true ? (double.parse(price!) * 100).round() : null,
      ),
    );
  }
}

class GliModelProductCategory {
  String? id;
  String? name;
  String? slug;
  String? description;
  bool? adultOnly;
  bool? extraCost;
  DateTime? createdAt;
  DateTime? updatedAt;

  GliModelProductCategory({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.adultOnly,
    this.extraCost,
    this.createdAt,
    this.updatedAt,
  });

  factory GliModelProductCategory.fromRawJson(String str) => GliModelProductCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GliModelProductCategory.fromJson(Map<String, dynamic> json) => GliModelProductCategory(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        adultOnly: json["adult_only"],
        extraCost: json["extra_cost"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "adult_only": adultOnly,
        "extra_cost": extraCost,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class GliModelProductVariant {
  String? id;
  String? className;
  String? parentName;
  String? parentCode;
  String? productId;
  String? name;
  String? price;
  dynamic priceWithDiscount;
  String? lowestPrice;
  double? weight;
  bool? userLiked;
  String? media;
  DateTime? createdAt;
  DateTime? updatedAt;

  GliModelProductVariant({
    this.id,
    this.className,
    this.parentName,
    this.parentCode,
    this.productId,
    this.name,
    this.price,
    this.priceWithDiscount,
    this.lowestPrice,
    this.weight,
    this.userLiked,
    this.media,
    this.createdAt,
    this.updatedAt,
  });

  factory GliModelProductVariant.fromRawJson(String str) => GliModelProductVariant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GliModelProductVariant.fromJson(Map<String, dynamic> json) => GliModelProductVariant(
        id: json["id"],
        className: json["class_name"],
        parentName: json["parent_name"],
        parentCode: json["parent_code"],
        productId: json["product_id"],
        name: json["name"],
        price: json["price"],
        priceWithDiscount: json["price_with_discount"],
        lowestPrice: json["lowest_price"],
        weight: json["weight"]?.toDouble(),
        userLiked: json["user_liked"],
        media: json["media"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "class_name": className,
        "parent_name": parentName,
        "parent_code": parentCode,
        "product_id": productId,
        "name": name,
        "price": price,
        "price_with_discount": priceWithDiscount,
        "lowest_price": lowestPrice,
        "weight": weight,
        "user_liked": userLiked,
        "media": media,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
