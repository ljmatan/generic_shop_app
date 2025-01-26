import 'package:flutter/material.dart';
import 'package:gsa_architecture/gsar.dart';

/// Route for display of the 3rd-party software licence and attribution information.
///
class GsaRouteLicences extends GsarRoute {
  // ignore: public_member_api_docs
  const GsaRouteLicences({super.key});

  @override
  State<GsaRouteLicences> createState() => _GsaRouteLicencesState();

  @override
  String get routeId => 'licences';

  @override
  String get displayName => 'Licences';
}

class _GsaRouteLicencesState extends GsarRouteState<GsaRouteLicences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
    );
  }
}
