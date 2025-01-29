import 'package:generic_shop_app_architecture/gsar.dart';

/// Shop search parameters.
///
@GsarModelMacro()
class GsaaModelShopSearch {
  // ignore: public_member_api_docs
  GsaaModelShopSearch({
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
    return searchTerm?.isNotEmpty == true;
  }

  /// Clears any applied filters.
  ///
  void clear() {
    searchTerm = null;
    sortCategoryId = null;
  }
}
