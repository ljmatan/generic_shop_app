part of '../models.dart';

/// Shop search parameters.
///
@JsonSerializable(explicitToJson: true)
class GsaModelShopSearch extends _Model {
  // ignore: public_member_api_docs
  GsaModelShopSearch({
    super.id,
    super.originId,
    required this.searchTerm,
    required this.sortCategoryId,
  }) : categoryIds = {};

  /// Text search term applied to this search instance.
  ///
  String? searchTerm;

  /// Collection of specified category identifiers to be applied.
  ///
  Set<String> categoryIds;

  /// The identifier for the sort option.
  ///
  String? sortCategoryId;

  /// Determines whether any filters are applied.
  ///
  bool get active {
    return searchTerm?.isNotEmpty == true && searchTerm!.length > 2 || categoryIds.isNotEmpty;
  }

  /// Returns the number of applied filters.
  ///
  int? get appliedCount {
    int count = 0;
    if (searchTerm != null && searchTerm!.length > 2) count++;
    return count == 0 ? null : count;
  }

  /// Clears any applied filters.
  ///
  void clear() {
    searchTerm = null;
    categoryIds.clear();
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
      sortCategoryId: sortCategoryId,
    );
  }
}
