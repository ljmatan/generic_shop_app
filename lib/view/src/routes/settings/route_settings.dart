import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Route displaying the application personalization settings.
///
class GsaRouteSettings extends GsarRoute {
  // ignore: public_member_api_docs
  const GsaRouteSettings({super.key});

  @override
  State<GsaRouteSettings> createState() => _GsaRouteSettingsState();

  @override
  String get routeId => 'settings';

  @override
  String get displayName => 'Settings';
}

class _GsaRouteSettingsState extends GsarRouteState<GsaRouteSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
    );
  }
}
