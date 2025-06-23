part of '../models.dart';

/// Model class specifying the parameters for the checkout process.
///
@JsonSerializable(explicitToJson: true)
class GsaModelOrderDraft extends _Model {
  // ignore: public_member_api_docs
  GsaModelOrderDraft({
    super.id,
    super.originId,
    required this.items,
    this.client,
    this.deliveryType,
    this.paymentType,
    this.couponCode,
    this.price,
  });

  /// List of products in the order.
  ///
  List<GsaModelSaleItem> items;

  /// Client specified for this checkout order.
  ///
  GsaModelClient? client;

  /// Delivery and invoice addresses specified for the order.
  ///
  GsaModelAddress? deliveryAddress, invoiceAddress;

  /// The type of delivery option specified for the order.
  ///
  GsaModelSaleItem? deliveryType;

  /// Payment type specified for the order.
  ///
  GsaModelSaleItem? paymentType;

  /// The specified merchant / executor for this order.
  ///
  GsaModelMerchant? orderProcessor;

  /// Coupon code applied to this order.
  ///
  String? couponCode;

  /// Total cart price, including any discount or promo info.
  ///
  GsaModelPrice? price;

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
    client = null;
    deliveryType = null;
    paymentType = null;
    couponCode = null;
    price = null;
  }

  // ignore: public_member_api_docs
  factory GsaModelOrderDraft.fromJson(Map json) {
    return _$GsaModelOrderDraftFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelOrderDraftToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaModelOrderDraft.mock() {
    return GsaModelOrderDraft(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      items: [],
      client: GsaModelClient.mock(),
      deliveryType: GsaModelSaleItem.mock(),
      couponCode: _Model._generateRandomString(8),
      paymentType: GsaModelSaleItem.mock(),
      price: null,
    );
  }
}
