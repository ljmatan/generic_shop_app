import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';

extension GsaServiceI18nExt on String {
  ///
  ///
  String translated(BuildContext context) {
    Type? routeType = context.findAncestorStateOfType<GsaRouteState>()?.widget.runtimeType;
    routeType ??= context.widget.runtimeType;
    return translatedFromType(routeType);
  }
}
