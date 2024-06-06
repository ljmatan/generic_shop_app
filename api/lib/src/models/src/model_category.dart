part of '../models.dart';

/// Object category specifier.
///
/// Various types of objects can be marked with the category identifier, associating the pair together.
///
@JsonSerializable(explicitToJson: true)
class GsaaModelCategory extends _Model {
  // ignore: public_member_api_docs
  GsaaModelCategory({
    required super.id,
    required super.originId,
    required super.categoryId,
    required this.name,
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
  factory GsaaModelCategory.fromJson(Map json) {
    return _$GsaaModelCategoryFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaaModelCategoryToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaaModelCategory.mock() {
    return GsaaModelCategory(
      id: _Model._generateRandomString(8),
      originId: _Model._generateRandomString(8),
      categoryId: null,
      name: _Model._generateRandomString(8),
      featured: Random().nextBool(),
    );
  }
}
