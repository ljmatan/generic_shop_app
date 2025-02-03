// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsaaModelAddress _$GsaaModelAddressFromJson(Map<String, dynamic> json) => GsaaModelAddress(
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
      personalDetails: json['personalDetails'] == null ? null : GsaaModelPerson.fromJson(json['personalDetails'] as Map<String, dynamic>),
      contactDetails: json['contactDetails'] == null ? null : GsaaModelContact.fromJson(json['contactDetails'] as Map<String, dynamic>),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..consentIds = (json['consentIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs = (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..displayName = json['displayName'] as String?;

Map<String, dynamic> _$GsaaModelAddressToJson(GsaaModelAddress instance) => <String, dynamic>{
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

GsaaModelCategory _$GsaaModelCategoryFromJson(Map<String, dynamic> json) => GsaaModelCategory(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      name: json['name'] as String?,
      featured: json['featured'] as bool?,
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..consentIds = (json['consentIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs = (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..description = json['description'] as String?;

Map<String, dynamic> _$GsaaModelCategoryToJson(GsaaModelCategory instance) => <String, dynamic>{
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

GsaaModelOrderDraft _$GsaaModelOrderDraftFromJson(Map<String, dynamic> json) => GsaaModelOrderDraft(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      items: (json['items'] as List<dynamic>).map((e) => GsaaModelSaleItem.fromJson(e as Map<String, dynamic>)).toList(),
      personalDetails: json['personalDetails'] == null ? null : GsaaModelPerson.fromJson(json['personalDetails'] as Map<String, dynamic>),
      contactDetails: json['contactDetails'] == null ? null : GsaaModelContact.fromJson(json['contactDetails'] as Map<String, dynamic>),
      deliveryAddress: json['deliveryAddress'] == null ? null : GsaaModelAddress.fromJson(json['deliveryAddress'] as Map<String, dynamic>),
      invoiceAddress: json['invoiceAddress'] == null ? null : GsaaModelAddress.fromJson(json['invoiceAddress'] as Map<String, dynamic>),
      deliveryType: json['deliveryType'] == null ? null : GsaaModelSaleItem.fromJson(json['deliveryType'] as Map<String, dynamic>),
      paymentType: json['paymentType'] == null ? null : GsaaModelSaleItem.fromJson(json['paymentType'] as Map<String, dynamic>),
      couponCode: json['couponCode'] as String?,
      price: json['price'] == null ? null : GsaaModelPrice.fromJson(json['price'] as Map<String, dynamic>),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..categoryId = json['categoryId'] as String?
      ..consentIds = (json['consentIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs = (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..orderProcessor = json['orderProcessor'] == null ? null : GsaaModelMerchant.fromJson(json['orderProcessor'] as Map<String, dynamic>);

Map<String, dynamic> _$GsaaModelOrderDraftToJson(GsaaModelOrderDraft instance) => <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'personalDetails': instance.personalDetails?.toJson(),
      'contactDetails': instance.contactDetails?.toJson(),
      'deliveryAddress': instance.deliveryAddress?.toJson(),
      'invoiceAddress': instance.invoiceAddress?.toJson(),
      'deliveryType': instance.deliveryType?.toJson(),
      'paymentType': instance.paymentType?.toJson(),
      'orderProcessor': instance.orderProcessor?.toJson(),
      'couponCode': instance.couponCode,
      'price': instance.price?.toJson(),
    };

GsaaModelConsent _$GsaaModelConsentFromJson(Map<String, dynamic> json) => GsaaModelConsent(
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
      ..consentIds = (json['consentIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs = (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaaModelConsentToJson(GsaaModelConsent instance) => <String, dynamic>{
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

GsaaModelContact _$GsaaModelContactFromJson(Map<String, dynamic> json) => GsaaModelContact(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      email: json['email'] as String?,
      phoneCountryCode: json['phoneCountryCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      note: json['note'] as String?,
      personalDetails: json['personalDetails'] == null ? null : GsaaModelPerson.fromJson(json['personalDetails'] as Map<String, dynamic>),
      addressDetails: json['addressDetails'] == null ? null : GsaaModelAddress.fromJson(json['addressDetails'] as Map<String, dynamic>),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..consentIds = (json['consentIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs = (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaaModelContactToJson(GsaaModelContact instance) => <String, dynamic>{
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

GsaModelLegalEntity _$GsaModelLegalEntityFromJson(Map<String, dynamic> json) => GsaModelLegalEntity(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      name: json['name'] == null ? null : GsaaModelTranslated.fromJson(json['name'] as Map<String, dynamic>),
      address: json['address'] == null ? null : GsaaModelAddress.fromJson(json['address'] as Map<String, dynamic>),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..categoryId = json['categoryId'] as String?
      ..consentIds = (json['consentIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs = (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaModelLegalEntityToJson(GsaModelLegalEntity instance) => <String, dynamic>{
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

GsaaModelMerchant _$GsaaModelMerchantFromJson(Map<String, dynamic> json) => GsaaModelMerchant(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      name: json['name'] as String?,
      contact: json['contact'] == null ? null : GsaaModelContact.fromJson(json['contact'] as Map<String, dynamic>),
      address: json['address'] == null ? null : GsaaModelAddress.fromJson(json['address'] as Map<String, dynamic>),
      logoImageUrl: json['logoImageUrl'] as String?,
      logoImageSmallUrl: json['logoImageSmallUrl'] as String?,
      reviews: (json['reviews'] as List<dynamic>?)?.map((e) => GsaaModelReview.fromJson(e as Map<String, dynamic>)).toList(),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..consentIds = (json['consentIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs = (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaaModelMerchantToJson(GsaaModelMerchant instance) => <String, dynamic>{
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

GsaaModelPerson _$GsaaModelPersonFromJson(Map<String, dynamic> json) => GsaaModelPerson(
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
      ..consentIds = (json['consentIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs = (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaaModelPersonToJson(GsaaModelPerson instance) => <String, dynamic>{
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

GsaaModelPrice _$GsaaModelPriceFromJson(Map<String, dynamic> json) => GsaaModelPrice(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      originalPriceId: json['originalPriceId'] as String?,
      centum: (json['centum'] as num?)?.toInt(),
      discount: json['discount'] == null ? null : GsaaModelDiscount.fromJson(json['discount'] as Map<String, dynamic>),
      clientVisible: json['clientVisible'] as bool?,
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..categoryId = json['categoryId'] as String?
      ..consentIds = (json['consentIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs = (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..promoDiscount =
          json['promoDiscount'] == null ? null : GsaaModelPromotionalDiscount.fromJson(json['promoDiscount'] as Map<String, dynamic>);

Map<String, dynamic> _$GsaaModelPriceToJson(GsaaModelPrice instance) => <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'originalPriceId': instance.originalPriceId,
      'centum': instance.centum,
      'discount': instance.discount?.toJson(),
      'promoDiscount': instance.promoDiscount?.toJson(),
      'clientVisible': instance.clientVisible,
    };

GsaaModelDiscount _$GsaaModelDiscountFromJson(Map<String, dynamic> json) => GsaaModelDiscount(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      centum: (json['centum'] as num?)?.toInt(),
      timeStartIso8601: json['timeStartIso8601'] as String?,
      timeEndIso8601: json['timeEndIso8601'] as String?,
      consentIds: (json['consentIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs = (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaaModelDiscountToJson(GsaaModelDiscount instance) => <String, dynamic>{
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
    };

GsaaModelPromotionalDiscount _$GsaaModelPromotionalDiscountFromJson(Map<String, dynamic> json) => GsaaModelPromotionalDiscount(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      centum: (json['eurCents'] as num?)?.toInt(),
      timeStartIso8601: json['timeStartIso8601'] as String?,
      timeEndIso8601: json['timeEndIso8601'] as String?,
      consentIds: (json['consentIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs = (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..couponCode = json['couponCode'] as String?;

Map<String, dynamic> _$GsaaModelPromotionalDiscountToJson(GsaaModelPromotionalDiscount instance) => <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'eurCents': instance.centum,
      'timeStartIso8601': instance.timeStartIso8601,
      'timeEndIso8601': instance.timeEndIso8601,
      'couponCode': instance.couponCode,
    };

GsaaModelReview _$GsaaModelReviewFromJson(Map<String, dynamic> json) => GsaaModelReview(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..categoryId = json['categoryId'] as String?
      ..consentIds = (json['consentIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs = (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..rating = (json['rating'] as num?)?.toDouble()
      ..comment = json['comment'] as String?
      ..timeCreatedIso8601 = json['timeCreatedIso8601'] as String?;

Map<String, dynamic> _$GsaaModelReviewToJson(GsaaModelReview instance) => <String, dynamic>{
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

GsaaModelSaleItem _$GsaaModelSaleItemFromJson(Map<String, dynamic> json) => GsaaModelSaleItem(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      name: json['name'] as String?,
      amount: GsaaModelSaleItem._amountFromJson(json['amount']),
      measure: json['measure'] as String?,
      description: json['description'] as String?,
      disclaimer: json['disclaimer'] as String?,
      imageUrls: (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList(),
      thumbnailUrls: (json['thumbnailUrls'] as List<dynamic>?)?.map((e) => e as String).toList(),
      price: json['price'] == null ? null : GsaaModelPrice.fromJson(json['price'] as Map<String, dynamic>),
      cartCount: (json['cartCount'] as num?)?.toInt(),
      availableCount: (json['availableCount'] as num?)?.toInt(),
      maxCount: (json['maxCount'] as num?)?.toInt(),
      featured: json['featured'] as bool?,
      delivered: json['delivered'] as bool?,
      digital: json['digital'] as bool?,
      payable: json['payable'] as bool?,
      options: (json['options'] as List<dynamic>?)?.map((e) => GsaaModelSaleItem.fromJson(e as Map<String, dynamic>)).toList(),
      reviews: (json['reviews'] as List<dynamic>?)?.map((e) => GsaaModelReview.fromJson(e as Map<String, dynamic>)).toList(),
      deliveryTimeMilliseconds: (json['deliveryTimeMilliseconds'] as num?)?.toInt(),
      informationList: (json['informationList'] as List<dynamic>?)
          ?.map((e) => _$recordConvert(
                e,
                ($jsonValue) => (
                  description: $jsonValue['description'] as String,
                  label: $jsonValue['label'] as String,
                ),
              ))
          .toList(),
      originUrl: json['originUrl'] as String?,
      consentIds: (json['consentIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    )
      ..deleted = json['deleted'] as bool?
      ..logs = (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..condition = json['condition'] as String?;

Map<String, dynamic> _$GsaaModelSaleItemToJson(GsaaModelSaleItem instance) => <String, dynamic>{
      'id': instance.id,
      'originId': instance.originId,
      'originUrl': instance.originUrl,
      'deleted': instance.deleted,
      'categoryId': instance.categoryId,
      'consentIds': instance.consentIds,
      'tags': instance.tags,
      'logs': instance.logs,
      'name': instance.name,
      'amount': instance.amount,
      'measure': instance.measure,
      'description': instance.description,
      'disclaimer': instance.disclaimer,
      'imageUrls': instance.imageUrls,
      'thumbnailUrls': instance.thumbnailUrls,
      'price': instance.price?.toJson(),
      'cartCount': instance.cartCount,
      'availableCount': instance.availableCount,
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
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);

GsaaModelSalePoint _$GsaaModelSalePointFromJson(Map<String, dynamic> json) => GsaaModelSalePoint(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      name: json['name'] == null ? null : GsaaModelTranslated.fromJson(json['name'] as Map<String, dynamic>),
      address: json['address'] == null ? null : GsaaModelAddress.fromJson(json['address'] as Map<String, dynamic>),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..categoryId = json['categoryId'] as String?
      ..consentIds = (json['consentIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs = (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaaModelSalePointToJson(GsaaModelSalePoint instance) => <String, dynamic>{
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

GsaaModelShopSearch _$GsaaModelShopSearchFromJson(Map<String, dynamic> json) => GsaaModelShopSearch(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      searchTerm: json['searchTerm'] as String?,
      sortCategoryId: json['sortCategoryId'] as String?,
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..consentIds = (json['consentIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs = (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaaModelShopSearchToJson(GsaaModelShopSearch instance) => <String, dynamic>{
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

GsaaModelTranslated _$GsaaModelTranslatedFromJson(Map<String, dynamic> json) => GsaaModelTranslated(
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
      ..consentIds = (json['consentIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs = (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaaModelTranslatedToJson(GsaaModelTranslated instance) => <String, dynamic>{
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

GsaaModelUser _$GsaaModelUserFromJson(Map<String, dynamic> json) => GsaaModelUser(
      id: json['id'] as String?,
      originId: json['originId'] as String?,
      categoryId: json['categoryId'] as String?,
      username: json['username'] as String?,
      personalDetails: json['personalDetails'] == null ? null : GsaaModelPerson.fromJson(json['personalDetails'] as Map<String, dynamic>),
      contact: json['contact'] == null ? null : GsaaModelContact.fromJson(json['contact'] as Map<String, dynamic>),
      address: json['address'] == null ? null : GsaaModelAddress.fromJson(json['address'] as Map<String, dynamic>),
      deliveryAddresses:
          (json['deliveryAddresses'] as List<dynamic>?)?.map((e) => GsaaModelAddress.fromJson(e as Map<String, dynamic>)).toList(),
      invoiceAddresses:
          (json['invoiceAddresses'] as List<dynamic>?)?.map((e) => GsaaModelAddress.fromJson(e as Map<String, dynamic>)).toList(),
    )
      ..originUrl = json['originUrl'] as String?
      ..deleted = json['deleted'] as bool?
      ..consentIds = (json['consentIds'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..tags = (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..logs = (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GsaaModelUserToJson(GsaaModelUser instance) => <String, dynamic>{
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
      'deliveryAddresses': instance.deliveryAddresses?.map((e) => e.toJson()).toList(),
      'invoiceAddresses': instance.invoiceAddresses?.map((e) => e.toJson()).toList(),
    };
