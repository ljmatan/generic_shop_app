import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_text.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Route displaying the application onboarding guide and other relevant information.
///
class GsaRouteOnboarding extends GsaRoute {
  /// Default, unmamed widget constructor.
  ///
  const GsaRouteOnboarding({super.key});

  @override
  State<GsaRouteOnboarding> createState() => _GsaRouteOnboardingState();
}

class _GsaRouteOnboardingState extends GsarRouteState<GsaRouteOnboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: GsaWidgetText(widget.displayName)));
  }
}
