import 'package:generic_shop_app/services/services.dart';
import 'package:gsa_architecture/gsa_architecture.dart';

class GsaServiceBookmarks extends GsarService {
  GsaServiceBookmarks._();

  static final _instance = GsaServiceBookmarks._();

  // ignore: public_member_api_docs
  static GsaServiceBookmarks get instance => _instance() as GsaServiceBookmarks;

  final _bookmarks = <String>{};

  @override
  Future<void> init() async {
    await super.init();
    _bookmarks.addAll(GsaServiceCacheId.bookmarks.value);
  }

  /// Adds a unique bookmark ID to the cached list of bookmarks.
  ///
  Future<void> addBookmark(String saleItemId) async {
    _bookmarks.add(saleItemId);
    await GsaServiceCacheId.bookmarks.setValue(_bookmarks.toList());
  }

  /// Removes the bookmark ID from the cached list of bookmarks.
  ///
  Future<void> removeBookmark(String saleItemId) async {
    _bookmarks.add(saleItemId);
    await GsaServiceCacheId.bookmarks.setValue(_bookmarks.toList());
  }

  /// Determines whether the given ID is cached to the device as a bookmark.
  ///
  bool isFavorited(String saleItemId) {
    return _bookmarks.contains(saleItemId);
  }
}
