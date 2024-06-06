part of '../models.dart';

/// Model class specifying the parameters for the checkout process.
///
@JsonSerializable(explicitToJson: true)
class GsaaModelOrderDraft extends _Model {
  // ignore: public_member_api_docs
  GsaaModelOrderDraft({
    required super.id,
    required super.originId,
    required this.items,
    required this.personalDetails,
    required this.contactDetails,
    required this.deliveryAddress,
    required this.invoiceAddress,
    required this.deliveryType,
    required this.paymentType,
    required this.couponCode,
    required this.price,
  });

  /// List of products in the order.
  ///
  List<GsaaModelSaleItem> items;

  /// User personal details.
  ///
  GsaaModelPerson? personalDetails;

  /// User contact details.
  ///
  GsaaModelContact? contactDetails;

  /// Delivery and invoice addresses specified for the order.
  ///
  GsaaModelAddress? deliveryAddress, invoiceAddress;

  /// The type of delivery option specified for the order.
  ///
  GsaaModelSaleItem? deliveryType;

  /// Payment type specified for the order.
  ///
  GsaaModelSaleItem? paymentType;

  /// The specified merchant / executor for this order.
  ///
  GsaaModelMerchant? orderProcessor;

  /// Coupon code applied to this order.
  ///
  String? couponCode;

  /// Total cart price, including any discount or promo info.
  ///
  GsaaModelPrice? price;

  /// Whether this order is deliverable with the current configuration.
  ///
  bool get deliverable {
    return items.every((item) => item.delivered != false);
  }

  /// Whether this order is payable with the current configuration.
  ///
  bool get payable {
    return items.every((item) => item.payable != false) && deliveryType?.payable != false;
  }

  /// Clears the order by removing all of the items and personal details from the order draft.
  ///
  void clear() {
    items.clear();
    personalDetails = null;
    contactDetails = null;
    deliveryAddress = null;
    invoiceAddress = null;
    deliveryType = null;
    paymentType = null;
    couponCode = null;
    price = null;
  }

  // ignore: public_member_api_docs
  factory GsaaModelOrderDraft.fromJson(Map json) {
    return _$GsaaModelOrderDraftFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaaModelOrderDraftToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaaModelOrderDraft.mock() {
    return GsaaModelOrderDraft(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      items: [],
      personalDetails: GsaaModelPerson.mock(),
      contactDetails: GsaaModelContact.mock(),
      deliveryAddress: GsaaModelAddress.mock(),
      invoiceAddress: GsaaModelAddress.mock(),
      deliveryType: GsaaModelSaleItem.mock(),
      couponCode: _Model._generateRandomString(8),
      paymentType: GsaaModelSaleItem.mock(),
      price: null,
    );
  }
}
