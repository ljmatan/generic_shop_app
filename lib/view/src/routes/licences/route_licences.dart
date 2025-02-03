import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Route for display of the 3rd-party software licence and attribution information.
///
class GsaRouteLicences extends GsaRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteLicences({super.key});

  @override
  State<GsaRouteLicences> createState() => _GsaRouteLicencesState();
}

class _GsaRouteLicencesState extends GsarRouteState<GsaRouteLicences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.displayName)));
  }
}
