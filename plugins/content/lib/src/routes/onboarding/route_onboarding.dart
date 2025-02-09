import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Route displaying the application onboarding guide and other relevant information.
///
class GsaRouteOnboarding extends GsacRoute {
  /// Default, unmamed widget constructor.
  ///
  const GsaRouteOnboarding({super.key});

  @override
  State<GsaRouteOnboarding> createState() => _GsaRouteOnboardingState();
}

class _GsaRouteOnboardingState extends GsaRouteState<GsaRouteOnboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: GsaWidgetText(widget.displayName)));
  }
}
