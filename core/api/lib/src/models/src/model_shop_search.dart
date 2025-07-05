part of '../models.dart';

/// Shop search parameters.
///
@JsonSerializable(explicitToJson: true)
class GsaModelShopSearch extends _Model {
  // ignore: public_member_api_docs
  GsaModelShopSearch({
    super.id,
    super.originId,
    required super.categoryId,
    required this.searchTerm,
    required this.sortCategoryId,
  });

  /// Text search term applied to this search instance.
  ///
  String? searchTerm;

  /// The identifier for the sort option.
  ///
  String? sortCategoryId;

  /// Determines whether any filters are applied.
  ///
  bool get active {
    return searchTerm?.isNotEmpty == true && searchTerm!.length > 2 || categoryId != null;
  }

  /// Clears any applied filters.
  ///
  void clear() {
    searchTerm = null;
    categoryId = null;
    sortCategoryId = null;
  }

  // ignore: public_member_api_docs
  factory GsaModelShopSearch.fromJson(Map json) {
    return _$GsaModelShopSearchFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelShopSearchToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaModelShopSearch.mock({
    String? categoryId,
    String? subcategoryId,
    String? sortCategoryId,
  }) {
    return GsaModelShopSearch(
      searchTerm: _Model._generateRandomString(3),
      categoryId: categoryId,
      sortCategoryId: sortCategoryId,
    );
  }
}
