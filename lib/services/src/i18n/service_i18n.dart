import 'package:flutter/material.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';
import 'package:gsa_architecture/gsar.dart';

extension GsaServiceI18nExt on String {
  ///
  ///
  String translated(BuildContext context) {
    Type? routeType = context.findAncestorStateOfType<GsarRouteState>()?.widget.runtimeType;
    routeType ??= context.widget.runtimeType;
    return translatedFromType(routeType);
  }
}
