// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsaModelAddress _$GsaModelAddressFromJson(Map<String, dynamic> json) =>
    GsaModelAddress(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      streetName: json['streetName'] as String?,
      houseNumber: json['houseNumber'] as String?,
      zipCode: json['zipCode'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      note: json['note'] as String?,
      personalDetails: json['personalDetails'] == null
          ? null
          : GsaModelPerson.fromJson(
              json['personalDetails'] as Map<String, dynamic>),
      contactDetails: json['contactDetails'] == null
          ? null
          : GsaModelContact.fromJson(
              json['contactDetails'] as Map<String, dynamic>),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..consentIds = (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..displayName = json['displayName'] as String?;

Map<String, dynamic> _$GsaModelAddressToJson(GsaModelAddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'displayName': instance.displayName,
      'streetName': instance.streetName,
      'houseNumber': instance.houseNumber,
      'zipCode': instance.zipCode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'note': instance.note,
      'personalDetails': instance.personalDetails?.toJson(),
      'contactDetails': instance.contactDetails?.toJson(),
    };

GsaModelCategory _$GsaModelCategoryFromJson(Map<String, dynamic> json) =>
    GsaModelCategory(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      name: json['name'] as String?,
      featured: json['featured'] as bool?,
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..consentIds = (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..description = json['description'] as String?;

Map<String, dynamic> _$GsaModelCategoryToJson(GsaModelCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'name': instance.name,
      'featured': instance.featured,
      'description': instance.description,
    };

GsaModelClient _$GsaModelClientFromJson(Map<String, dynamic> json) =>
    GsaModelClient(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      personalDetails: json['personalDetails'] == null
          ? null
          : GsaModelPerson.fromJson(
              json['personalDetails'] as Map<String, dynamic>),
      contactDetails: json['contactDetails'] == null
          ? null
          : GsaModelContact.fromJson(
              json['contactDetails'] as Map<String, dynamic>),
      deliveryAddresses: (json['deliveryAddresses'] as List<dynamic>?)
          ?.map((e) => GsaModelAddress.fromJson(e as Map<String, dynamic>))
          .toList(),
      invoiceAddresses: (json['invoiceAddresses'] as List<dynamic>?)
          ?.map((e) => GsaModelAddress.fromJson(e as Map<String, dynamic>))
          .toList(),
      originData: GsaModelClient._originDataFromJson(json['originData']),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..consentIds = (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaModelClientToJson(GsaModelClient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'personalDetails': instance.personalDetails?.toJson(),
      'contactDetails': instance.contactDetails?.toJson(),
      'deliveryAddresses':
          instance.deliveryAddresses?.map((e) => e.toJson()).toList(),
      'invoiceAddresses':
          instance.invoiceAddresses?.map((e) => e.toJson()).toList(),
      'originData': GsaModelClient._originDataToJson(instance.originData),
    };

GsaModelOrderDraft _$GsaModelOrderDraftFromJson(Map<String, dynamic> json) =>
    GsaModelOrderDraft(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => GsaModelSaleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      client: json['client'] == null
          ? null
          : GsaModelClient.fromJson(json['client'] as Map<String, dynamic>),
      deliveryType: json['deliveryType'] == null
          ? null
          : GsaModelSaleItem.fromJson(
              json['deliveryType'] as Map<String, dynamic>),
      paymentType: json['paymentType'] == null
          ? null
          : GsaModelSaleItem.fromJson(
              json['paymentType'] as Map<String, dynamic>),
      couponCode: json['couponCode'] as String?,
      price: json['price'] == null
          ? null
          : GsaModelPrice.fromJson(json['price'] as Map<String, dynamic>),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..categoryId = json['categoryId'] as String?
      ..consentIds = (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..deliveryAddress = json['deliveryAddress'] == null
          ? null
          : GsaModelAddress.fromJson(
              json['deliveryAddress'] as Map<String, dynamic>)
      ..invoiceAddress = json['invoiceAddress'] == null
          ? null
          : GsaModelAddress.fromJson(
              json['invoiceAddress'] as Map<String, dynamic>)
      ..orderProcessor = json['orderProcessor'] == null
          ? null
          : GsaModelMerchant.fromJson(
              json['orderProcessor'] as Map<String, dynamic>);

Map<String, dynamic> _$GsaModelOrderDraftToJson(GsaModelOrderDraft instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'client': instance.client?.toJson(),
      'deliveryAddress': instance.deliveryAddress?.toJson(),
      'invoiceAddress': instance.invoiceAddress?.toJson(),
      'deliveryType': instance.deliveryType?.toJson(),
      'paymentType': instance.paymentType?.toJson(),
      'orderProcessor': instance.orderProcessor?.toJson(),
      'couponCode': instance.couponCode,
      'price': instance.price?.toJson(),
    };

GsaModelConsent _$GsaModelConsentFromJson(Map<String, dynamic> json) =>
    GsaModelConsent(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      version: json['version'] as String?,
      text: json['text'] as String?,
      publishTimeIso8601: json['publishTimeIso8601'] as String?,
      deadlineTimeIso8601: json['deadlineTimeIso8601'] as String?,
      consented: json['consented'] as bool?,
      acknowledged: json['acknowledged'] as bool?,
      requisite: json['requisite'] as bool?,
      originUrl: json['originUrl'] as String?,
    )
      ..deleted = json['deleted'] as bool?
      ..categoryId = json['categoryId'] as String?
      ..consentIds = (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaModelConsentToJson(GsaModelConsent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'version': instance.version,
      'text': instance.text,
      'publishTimeIso8601': instance.publishTimeIso8601,
      'deadlineTimeIso8601': instance.deadlineTimeIso8601,
      'consented': instance.consented,
      'acknowledged': instance.acknowledged,
      'requisite': instance.requisite,
    };

GsaModelContact _$GsaModelContactFromJson(Map<String, dynamic> json) =>
    GsaModelContact(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      email: json['email'] as String?,
      phoneCountryCode: json['phoneCountryCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      note: json['note'] as String?,
      personalDetails: json['personalDetails'] == null
          ? null
          : GsaModelPerson.fromJson(
              json['personalDetails'] as Map<String, dynamic>),
      addressDetails: json['addressDetails'] == null
          ? null
          : GsaModelAddress.fromJson(
              json['addressDetails'] as Map<String, dynamic>),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..consentIds = (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaModelContactToJson(GsaModelContact instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'email': instance.email,
      'phoneCountryCode': instance.phoneCountryCode,
      'phoneNumber': instance.phoneNumber,
      'note': instance.note,
      'personalDetails': instance.personalDetails?.toJson(),
      'addressDetails': instance.addressDetails?.toJson(),
    };

GsaModelLegalEntity _$GsaModelLegalEntityFromJson(Map<String, dynamic> json) =>
    GsaModelLegalEntity(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      name: json['name'] == null
          ? null
          : GsaModelTranslated.fromJson(json['name'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : GsaModelAddress.fromJson(json['address'] as Map<String, dynamic>),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..categoryId = json['categoryId'] as String?
      ..consentIds = (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaModelLegalEntityToJson(
        GsaModelLegalEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'name': instance.name?.toJson(),
      'address': instance.address?.toJson(),
    };

GsaModelMerchant _$GsaModelMerchantFromJson(Map<String, dynamic> json) =>
    GsaModelMerchant(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      name: json['name'] as String?,
      contact: json['contact'] == null
          ? null
          : GsaModelContact.fromJson(json['contact'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : GsaModelAddress.fromJson(json['address'] as Map<String, dynamic>),
      logoImageUrl: json['logoImageUrl'] as String?,
      logoImageSmallUrl: json['logoImageSmallUrl'] as String?,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => GsaModelReview.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..consentIds = (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaModelMerchantToJson(GsaModelMerchant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'name': instance.name,
      'contact': instance.contact?.toJson(),
      'address': instance.address?.toJson(),
      'logoImageUrl': instance.logoImageUrl,
      'logoImageSmallUrl': instance.logoImageSmallUrl,
      'reviews': instance.reviews?.map((e) => e.toJson()).toList(),
    };

GsaModelPerson _$GsaModelPersonFromJson(Map<String, dynamic> json) =>
    GsaModelPerson(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      gender: json['gender'] as String?,
      dateOfBirthIso8601: json['dateOfBirthIso8601'] as String?,
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..consentIds = (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaModelPersonToJson(GsaModelPerson instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'dateOfBirthIso8601': instance.dateOfBirthIso8601,
    };

GsaModelPrice _$GsaModelPriceFromJson(Map<String, dynamic> json) =>
    GsaModelPrice(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      currencyType: $enumDecodeNullable(
          _$GsaModelPriceCurrencyTypeEnumMap, json['currencyType']),
      centum: (json['centum'] as num?)?.toInt(),
      discount: json['discount'] == null
          ? null
          : GsaModelDiscount.fromJson(json['discount'] as Map<String, dynamic>),
      clientVisible: json['clientVisible'] as bool?,
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..categoryId = json['categoryId'] as String?
      ..consentIds = (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..promoDiscount = json['promoDiscount'] == null
          ? null
          : GsaModelPromotionalDiscount.fromJson(
              json['promoDiscount'] as Map<String, dynamic>);

Map<String, dynamic> _$GsaModelPriceToJson(GsaModelPrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'currencyType': _$GsaModelPriceCurrencyTypeEnumMap[instance.currencyType],
      'centum': instance.centum,
      'discount': instance.discount?.toJson(),
      'promoDiscount': instance.promoDiscount?.toJson(),
      'clientVisible': instance.clientVisible,
    };

const _$GsaModelPriceCurrencyTypeEnumMap = {
  GsaModelPriceCurrencyType.eur: 'eur',
  GsaModelPriceCurrencyType.usd: 'usd',
  GsaModelPriceCurrencyType.jpy: 'jpy',
};

GsaModelDiscount _$GsaModelDiscountFromJson(Map<String, dynamic> json) =>
    GsaModelDiscount(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      currencyType: $enumDecodeNullable(
          _$GsaModelPriceCurrencyTypeEnumMap, json['currencyType']),
      centum: (json['centum'] as num?)?.toInt(),
      timeStartIso8601: json['timeStartIso8601'] as String?,
      timeEndIso8601: json['timeEndIso8601'] as String?,
      consentIds: (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaModelDiscountToJson(GsaModelDiscount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'currencyType': _$GsaModelPriceCurrencyTypeEnumMap[instance.currencyType],
      'centum': instance.centum,
      'timeStartIso8601': instance.timeStartIso8601,
      'timeEndIso8601': instance.timeEndIso8601,
    };

GsaModelPromotionalDiscount _$GsaModelPromotionalDiscountFromJson(
        Map<String, dynamic> json) =>
    GsaModelPromotionalDiscount(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      centum: (json['centum'] as num?)?.toInt(),
      timeStartIso8601: json['timeStartIso8601'] as String?,
      timeEndIso8601: json['timeEndIso8601'] as String?,
      consentIds: (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..couponCode = json['couponCode'] as String?;

Map<String, dynamic> _$GsaModelPromotionalDiscountToJson(
        GsaModelPromotionalDiscount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'centum': instance.centum,
      'timeStartIso8601': instance.timeStartIso8601,
      'timeEndIso8601': instance.timeEndIso8601,
      'couponCode': instance.couponCode,
    };

GsaModelPromoBanner _$GsaModelPromoBannerFromJson(Map<String, dynamic> json) =>
    GsaModelPromoBanner(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      contentUrl: json['contentUrl'] as String?,
      photoUrl: json['photoUrl'] as String?,
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..categoryId = json['categoryId'] as String?
      ..consentIds = (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaModelPromoBannerToJson(
        GsaModelPromoBanner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'label': instance.label,
      'description': instance.description,
      'contentUrl': instance.contentUrl,
      'photoUrl': instance.photoUrl,
    };

GsaModelReview _$GsaModelReviewFromJson(Map<String, dynamic> json) =>
    GsaModelReview(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..categoryId = json['categoryId'] as String?
      ..consentIds = (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..rating = (json['rating'] as num?)?.toDouble()
      ..comment = json['comment'] as String?
      ..timeCreatedIso8601 = json['timeCreatedIso8601'] as String?;

Map<String, dynamic> _$GsaModelReviewToJson(GsaModelReview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'rating': instance.rating,
      'comment': instance.comment,
      'timeCreatedIso8601': instance.timeCreatedIso8601,
    };

GsaModelSaleItem _$GsaModelSaleItemFromJson(Map<String, dynamic> json) =>
    GsaModelSaleItem(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      name: json['name'] as String?,
      productCode: json['productCode'] as String?,
      amount: GsaModelSaleItem._amountFromJson(json['amount']),
      measure: json['measure'] as String?,
      description: json['description'] as String?,
      disclaimer: json['disclaimer'] as String?,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      thumbnailUrls: (json['thumbnailUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      attributeIconUrls: (json['attributeIconUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      price: json['price'] == null
          ? null
          : GsaModelPrice.fromJson(json['price'] as Map<String, dynamic>),
      availability: (json['availability'] as List<dynamic>?)
          ?.map((e) => _$recordConvert(
                e,
                ($jsonValue) => (
                  count: ($jsonValue['count'] as num?)?.toInt(),
                  locationId: $jsonValue['locationId'] as String?,
                ),
              ))
          .toList(),
      maxCount: (json['maxCount'] as num?)?.toInt(),
      featured: json['featured'] as bool?,
      delivered: json['delivered'] as bool?,
      digital: json['digital'] as bool?,
      payable: json['payable'] as bool?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => GsaModelSaleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => GsaModelReview.fromJson(e as Map<String, dynamic>))
          .toList(),
      deliveryTimeMilliseconds:
          (json['deliveryTimeMilliseconds'] as num?)?.toInt(),
      informationList: (json['informationList'] as List<dynamic>?)
          ?.map((e) => _$recordConvert(
                e,
                ($jsonValue) => (
                  description: $jsonValue['description'] as String,
                  label: $jsonValue['label'] as String,
                ),
              ))
          .toList(),
      originData: GsaModelSaleItem._originDataFromJson(json['originData']),
      originUrl: json['originUrl'] as String?,
      consentIds: (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    )
      ..deleted = json['deleted'] as bool?
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..condition = json['condition'] as String?;

Map<String, dynamic> _$GsaModelSaleItemToJson(GsaModelSaleItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'name': instance.name,
      'productCode': instance.productCode,
      'amount': instance.amount,
      'measure': instance.measure,
      'description': instance.description,
      'disclaimer': instance.disclaimer,
      'imageUrls': instance.imageUrls,
      'thumbnailUrls': instance.thumbnailUrls,
      'attributeIconUrls': instance.attributeIconUrls,
      'price': instance.price?.toJson(),
      'availability': instance.availability
          ?.map((e) => <String, dynamic>{
                'count': e.count,
                'locationId': e.locationId,
              })
          .toList(),
      'maxCount': instance.maxCount,
      'featured': instance.featured,
      'delivered': instance.delivered,
      'digital': instance.digital,
      'payable': instance.payable,
      'options': instance.options?.map((e) => e.toJson()).toList(),
      'reviews': instance.reviews?.map((e) => e.toJson()).toList(),
      'deliveryTimeMilliseconds': instance.deliveryTimeMilliseconds,
      'condition': instance.condition,
      'informationList': instance.informationList
          ?.map((e) => <String, dynamic>{
                'description': e.description,
                'label': e.label,
              })
          .toList(),
      'originData': GsaModelSaleItem._originDataToJson(instance.originData),
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);

GsaModelSalePoint _$GsaModelSalePointFromJson(Map<String, dynamic> json) =>
    GsaModelSalePoint(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      name: json['name'] == null
          ? null
          : GsaModelTranslated.fromJson(json['name'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : GsaModelAddress.fromJson(json['address'] as Map<String, dynamic>),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..categoryId = json['categoryId'] as String?
      ..consentIds = (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaModelSalePointToJson(GsaModelSalePoint instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'name': instance.name?.toJson(),
      'address': instance.address?.toJson(),
    };

GsaModelShopSearch _$GsaModelShopSearchFromJson(Map<String, dynamic> json) =>
    GsaModelShopSearch(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      searchTerm: json['searchTerm'] as String?,
      sortCategoryId: json['sortCategoryId'] as String?,
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..consentIds = (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaModelShopSearchToJson(GsaModelShopSearch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'searchTerm': instance.searchTerm,
      'sortCategoryId': instance.sortCategoryId,
    };

GsaModelTranslated _$GsaModelTranslatedFromJson(Map<String, dynamic> json) =>
    GsaModelTranslated(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      values: (json['values'] as List<dynamic>)
          .map((e) => _$recordConvert(
                e,
                ($jsonValue) => (
                  languageId: $jsonValue['languageId'] as String,
                  value: $jsonValue['value'] as String,
                ),
              ))
          .toList(),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..categoryId = json['categoryId'] as String?
      ..consentIds = (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaModelTranslatedToJson(GsaModelTranslated instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'values': instance.values
          .map((e) => <String, dynamic>{
                'languageId': e.languageId,
                'value': e.value,
              })
          .toList(),
    };

GsaModelUser _$GsaModelUserFromJson(Map<String, dynamic> json) => GsaModelUser(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      username: json['username'] as String?,
      personalDetails: json['personalDetails'] == null
          ? null
          : GsaModelPerson.fromJson(
              json['personalDetails'] as Map<String, dynamic>),
      contact: json['contact'] == null
          ? null
          : GsaModelContact.fromJson(json['contact'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : GsaModelAddress.fromJson(json['address'] as Map<String, dynamic>),
      deliveryAddresses: (json['deliveryAddresses'] as List<dynamic>?)
          ?.map((e) => GsaModelAddress.fromJson(e as Map<String, dynamic>))
          .toList(),
      invoiceAddresses: (json['invoiceAddresses'] as List<dynamic>?)
          ?.map((e) => GsaModelAddress.fromJson(e as Map<String, dynamic>))
          .toList(),
      originData: GsaModelUser._originDataFromJson(json['originData']),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..consentIds = (json['consentIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..tags =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs =
          (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaModelUserToJson(GsaModelUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'username': instance.username,
      'personalDetails': instance.personalDetails?.toJson(),
      'contact': instance.contact?.toJson(),
      'address': instance.address?.toJson(),
      'deliveryAddresses':
          instance.deliveryAddresses?.map((e) => e.toJson()).toList(),
      'invoiceAddresses':
          instance.invoiceAddresses?.map((e) => e.toJson()).toList(),
      'originData': GsaModelUser._originDataToJson(instance.originData),
    };
