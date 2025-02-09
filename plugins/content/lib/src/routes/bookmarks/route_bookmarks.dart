import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// Screen displaying user bookmark list (or wishlist), enabling further processing options.
///
class GsaRouteBookmarks extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteBookmarks({super.key});

  @override
  State<GsaRouteBookmarks> createState() => _GsaRouteBookmarksState();
}

class _GsaRouteBookmarksState extends GsaRouteState<GsaRouteBookmarks> {
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
