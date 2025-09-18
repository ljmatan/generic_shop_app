import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:generic_shop_app_architecture/arch.dart';

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
  Future<void> init(BuildContext context) async {
    await super.init(context);
    bookmarks.addAll(
      GsaServiceCacheEntry.bookmarks.value ?? [],
    );
    notifierBookmarkCount = ValueNotifier<int>(bookmarks.length);
  }

  /// Controller object used for updating [Stream] subscriber state on bookmark updates.
  ///
  final controllerUpdate = StreamController<String?>.broadcast();

  /// Adds a unique bookmark ID to the cached list of bookmarks.
  ///
  Future<void> addBookmark(String saleItemId) async {
    bookmarks.add(saleItemId);
    await GsaServiceCacheEntry.bookmarks.setValue(bookmarks.toList());
    notifierBookmarkCount.value = bookmarks.length;
    controllerUpdate.add(saleItemId);
  }

  /// Removes the bookmark ID from the cached list of bookmarks.
  ///
  Future<void> removeBookmark(String saleItemId) async {
    bookmarks.remove(saleItemId);
    await GsaServiceCacheEntry.bookmarks.setValue(bookmarks.toList());
    notifierBookmarkCount.value = bookmarks.length;
    controllerUpdate.add(saleItemId);
  }

  /// Determines whether the given ID is cached to the device as a bookmark.
  ///
  bool isFavorited(String saleItemId) {
    return bookmarks.contains(saleItemId);
  }
}
