import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../services.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

class GsaServiceBookmarks extends GsaService {
  GsaServiceBookmarks._();

  static final _instance = GsaServiceBookmarks._();

  /// Globally-accessible class instance.
  ///
  static GsaServiceBookmarks get instance => _instance() as GsaServiceBookmarks;

  /// Runtime-accessible list of bookmarked sale item IDs.
  ///
  final bookmarks = <String>{};

  /// Notifier in charge of providing updates with the total number of bookmarked items.
  ///
  late ValueNotifier<int> notifierBookmarkCount;

  @override
  Future<void> init() async {
    await super.init();
    bookmarks.addAll(
      GsaServiceCacheId.bookmarks.value ?? [],
    );
    notifierBookmarkCount = ValueNotifier<int>(bookmarks.length);
  }

  final controllerUpdate = StreamController.broadcast();

  /// Adds a unique bookmark ID to the cached list of bookmarks.
  ///
  Future<void> addBookmark(String saleItemId) async {
    bookmarks.add(saleItemId);
    await GsaServiceCacheId.bookmarks.setValue(bookmarks.toList());
    notifierBookmarkCount.value = bookmarks.length;
    controllerUpdate.add(saleItemId);
  }

  /// Removes the bookmark ID from the cached list of bookmarks.
  ///
  Future<void> removeBookmark(String saleItemId) async {
    bookmarks.add(saleItemId);
    await GsaServiceCacheId.bookmarks.setValue(bookmarks.toList());
    notifierBookmarkCount.value = bookmarks.length;
    controllerUpdate.add(saleItemId);
  }

  /// Determines whether the given ID is cached to the device as a bookmark.
  ///
  bool isFavorited(String saleItemId) {
    return bookmarks.contains(saleItemId);
  }
}
