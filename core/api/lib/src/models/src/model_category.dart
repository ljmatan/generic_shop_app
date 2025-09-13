part of '../models.dart';

/// Object category specifier.
///
/// Various types of objects can be marked with the category identifier, associating the pair together.
///
@JsonSerializable(explicitToJson: true)
class GsaModelCategory extends _Model {
  // ignore: public_member_api_docs
  GsaModelCategory({
    required super.id,
    super.originId,
    super.categoryId,
    required this.name,
    this.description,
    this.featured,
  });

  /// Display name for the given category.
  ///
  String? name;

  /// Whether this category is marked as featured.
  ///
  bool? featured;

  /// General category information in text format.
  ///
  String? description;

  // ignore: public_member_api_docs
  factory GsaModelCategory.fromJson(Map json) {
    return _$GsaModelCategoryFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelCategoryToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaModelCategory.mock() {
    return GsaModelCategory(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      categoryId: null,
      name: _Model._generateRandomString(8),
      featured: Random().nextBool(),
    );
  }
}
