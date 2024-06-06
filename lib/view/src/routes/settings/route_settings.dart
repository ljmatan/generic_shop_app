import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';

/// Route displaying the application personalization settings.
///
class GsaRouteSettings extends GsaRoute {
  // ignore: public_member_api_docs
  const GsaRouteSettings({super.key});

  @override
  State<GsaRouteSettings> createState() => _GsaRouteSettingsState();

  @override
  String get routeId => 'settings';

  @override
  String get displayName => 'Settings';
}

class _GsaRouteSettingsState extends GsaRouteState<GsaRouteSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
    );
  }
}
