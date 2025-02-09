import 'dart:async';

import 'package:flutter/material.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:generic_shop_app_services/services.dart';

/// A button providing bookmarking / favorite functionalities.
///
class GsaWidgetBookmarkButton extends StatefulWidget {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetBookmarkButton(
    this.saleItem, {
    super.key,
    this.child,
  });

  /// Sale item specified as bookmarking subject.
  ///
  final GsaModelSaleItem saleItem;

  /// Optional child widget used for display instead of the default bookmark icon.
  ///
  final Widget Function(bool bookmarked)? child;

  @override
  State<GsaWidgetBookmarkButton> createState() => _GsaWidgetBookmarkButtonState();
}

class _GsaWidgetBookmarkButtonState extends State<GsaWidgetBookmarkButton> {
  late bool _bookmarked;

  late StreamSubscription _subscriptionBookmarkUpdates;

  @override
  void initState() {
    super.initState();
    _bookmarked = GsaServiceBookmarks.instance.isFavorited(widget.saleItem.id ?? '');
    _subscriptionBookmarkUpdates = GsaServiceBookmarks.instance.controllerUpdate.stream.listen(
      (bookmarkId) {
        if (bookmarkId == widget.saleItem.id) setState(() => _bookmarked = !_bookmarked);
      },
    );
  }

  Future<void> _onBookmarkStateChange() async {
    if (_bookmarked) {
      await GsaServiceBookmarks.instance.removeBookmark(widget.saleItem.id ?? '');
    } else {
      await GsaServiceBookmarks.instance.addBookmark(widget.saleItem.id ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child == null
        ? IconButton(
            icon: _bookmarked
                ? Icon(
                    Icons.favorite,
                    color: Theme.of(context).primaryColor,
                  )
                : const Icon(
                    Icons.favorite_outline,
                    color: Colors.grey,
                  ),
            onPressed: () async {
              await _onBookmarkStateChange();
            },
          )
        : InkWell(
            child: widget.child!(_bookmarked),
            onTap: () async {
              await _onBookmarkStateChange();
            },
          );
  }

  @override
  void dispose() {
    _subscriptionBookmarkUpdates.cancel();
    super.dispose();
  }
}
