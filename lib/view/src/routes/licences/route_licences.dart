import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';

/// Route for display of the 3rd-party software licence and attribution information.
///
class GsaRouteLicences extends GsaRoute {
  // ignore: public_member_api_docs
  const GsaRouteLicences({super.key});

  @override
  State<GsaRouteLicences> createState() => _GsaRouteLicencesState();

  @override
  String get routeId => 'licences';

  @override
  String get displayName => 'Licences';
}

class _GsaRouteLicencesState extends GsaRouteState<GsaRouteLicences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
    );
  }
}
