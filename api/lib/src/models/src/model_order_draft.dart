import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Model class specifying the parameters for the checkout process.
///
@GsarModelMacro()
class GsaaModelOrderDraft {
  GsaaModelOrderDraft({
    this.items,
    this.personalDetails,
    this.contactDetails,
    this.deliveryAddress,
    this.invoiceAddress,
    this.deliveryType,
    this.paymentType,
    this.couponCode,
    this.price,
  });

  /// List of products in the order.
  ///
  List<GsaaModelSaleItem>? items;

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
    return items?.every((item) => item.delivered != false) == true;
  }

  /// Whether this order is payable with the current configuration.
  ///
  bool get payable {
    return items?.every((item) => item.payable != false) == true && deliveryType?.payable != false;
  }

  /// Clears the order by removing all of the items and personal details from the order draft.
  ///
  void clear() {
    items?.clear();
    personalDetails = null;
    contactDetails = null;
    deliveryAddress = null;
    invoiceAddress = null;
    deliveryType = null;
    paymentType = null;
    couponCode = null;
    price = null;
  }
}
