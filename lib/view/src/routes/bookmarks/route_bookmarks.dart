import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

class GsaRouteBookmarks extends GsarRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteBookmarks({super.key});

  @override
  State<GsaRouteBookmarks> createState() => _GsaRouteBookmarksState();

  @override
  String get routeId => 'bookmarks';

  @override
  String get displayName => 'Bookmarks';
}

class _GsaRouteBookmarksState extends GsarRouteState<GsaRouteBookmarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
    );
  }
}
