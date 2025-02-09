import 'dart:async';

import '../../services.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

class GsaServiceBookmarks extends GsaService {
  GsaServiceBookmarks._();

  static final _instance = GsaServiceBookmarks._();

  // ignore: public_member_api_docs
  static GsaServiceBookmarks get instance => _instance() as GsaServiceBookmarks;

  final bookmarks = <String>{};

  @override
  Future<void> init() async {
    await super.init();
    bookmarks.addAll(GsaServiceCacheId.bookmarks.value);
  }

  /// Notifier triggered on each bookmark update.
  ///
  final updateController = StreamController.broadcast();

  /// Adds a unique bookmark ID to the cached list of bookmarks.
  ///
  Future<void> addBookmark(String saleItemId) async {
    bookmarks.add(saleItemId);
    await GsaServiceCacheId.bookmarks.setValue(bookmarks.toList());
    updateController.add(saleItemId);
  }

  /// Removes the bookmark ID from the cached list of bookmarks.
  ///
  Future<void> removeBookmark(String saleItemId) async {
    bookmarks.add(saleItemId);
    await GsaServiceCacheId.bookmarks.setValue(bookmarks.toList());
    updateController.add(saleItemId);
  }

  /// Determines whether the given ID is cached to the device as a bookmark.
  ///
  bool isFavorited(String saleItemId) {
    return bookmarks.contains(saleItemId);
  }
}
