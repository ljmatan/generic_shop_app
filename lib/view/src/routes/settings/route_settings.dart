import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Route displaying the application personalization settings.
///
class GsaRouteSettings extends GsaRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteSettings({super.key});

  @override
  State<GsaRouteSettings> createState() => _GsaRouteSettingsState();
}

class _GsaRouteSettingsState extends GsarRouteState<GsaRouteSettings> {
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
