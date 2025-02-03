import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/view.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Screen displaying user bookmark list (or wishlist), enabling further processing options.
///
class GsaRouteBookmarks extends GsaRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteBookmarks({super.key});

  @override
  State<GsaRouteBookmarks> createState() => _GsaRouteBookmarksState();
}

class _GsaRouteBookmarksState extends GsarRouteState<GsaRouteBookmarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.displayName,
        ),
      ),
    );
  }
}
