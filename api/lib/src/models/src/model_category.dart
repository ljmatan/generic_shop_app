import 'package:generic_shop_app_architecture/gsar.dart';

/// Object category specifier.
///
/// Various types of objects can be marked with the category identifier, associating the pair together.
///
@GsarModelMacro()
class GsaaModelCategory {
  // ignore: public_member_api_docs
  GsaaModelCategory({
    this.id,
    this.name,
    this.featured,
    this.description,
  });

  String? id;

  /// Display name for the given category.
  ///
  String? name;

  /// Whether this category is marked as featured.
  ///
  bool? featured;

  /// General category information in text format.
  ///
  String? description;
}
