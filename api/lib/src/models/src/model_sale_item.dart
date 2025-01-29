import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Object representing any sale item such as products, delivery services, etc.
///
@GsarModelMacro()
class GsaaModelSaleItem {
  // ignore: public_member_api_docs
  GsaaModelSaleItem({
    this.id,
    this.name,
    this.amount,
    this.measure,
    this.descriptionShort,
    this.descriptionLong,
    this.disclaimer,
    this.thumbnailUrl,
    this.imageUrl,
    this.price,
    this.cartCount,
    this.availableCount,
    this.maxCount,
    this.featured,
    this.delivered,
    this.digital,
    this.payable,
    this.options,
    this.reviews,
    this.deliveryTimeMilliseconds,
  });

  String? id;

  String? categoryId;

  /// Item display name.
  ///
  String? name;

  /// The amount for sale with the given [measure].
  ///
  num? amount;

  /// Item measure (e.g., kg, lbs, m, etc.) for the given [amount].
  ///
  String? measure;

  /// Formatted representation of the amount and measure of the sale item.
  ///
  String? get amountMeasureFormatted {
    String value = '';
    if (amount != null) value += '$amount';
    if (measure != null) value += (amount != null ? ' ' : '') + '$measure ';
    return value.isEmpty ? null : value;
  }

  /// Client-facing item description.
  ///
  String? descriptionShort, descriptionLong;

  /// Product disclaimer, usually representing a legally-required notice.
  ///
  String? disclaimer;

  /// Item graphical representation.
  ///
  String? thumbnailUrl, imageUrl;

  /// Price associated with the item.
  ///
  GsaaModelPrice? price;

  /// The amount of the current item in the cart or order draft.
  ///
  int? cartCount;

  /// The number of available items for sale.
  ///
  int? availableCount;

  /// Maximum count of products to purchase in a single checkout session.
  ///
  int? maxCount;

  /// Whether this item is marked as a featured item.
  ///
  bool? featured;

  /// Whether this item is offered with delivery.
  ///
  bool? delivered;

  /// Whether the item is offered in digital format.
  ///
  bool? digital;

  /// Whether the payment options are applicable for this item.
  ///
  bool? payable;

  /// List of associated [GsaaModelSaleItemOption] objects.
  ///
  List<GsaaModelSaleItem>? options;

  /// List of available reviews for this sale item.
  ///
  List<GsaaModelReview>? reviews;

  /// Delivery time for the sale item in milliseconds.
  ///
  int? deliveryTimeMilliseconds;

  /// Item condition (new, used, refurbished, etc.).
  ///
  String? condition;
}
