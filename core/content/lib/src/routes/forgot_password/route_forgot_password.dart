import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/arch.dart';

class GsaRouteForgotPassword extends GsacRoute {
  const GsaRouteForgotPassword({super.key});

  @override
  GsaRouteState<GsaRouteForgotPassword> createState() {
    return _GsaRouteForgotPasswordState();
  }
}

class _GsaRouteForgotPasswordState extends GsaRouteState<GsaRouteForgotPassword> {
  @override
  Widget view(BuildContext context) {
    return const Placeholder();
  }
}
