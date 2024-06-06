library router;

import 'dart:io' as dart_io;

import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;

enum GsamRouterType {
  public,
  api,
  resources,
}

extension GsamRouterTypeExt on GsamRouterType {
  /// Returns the specified [shelf_router.Router] instance for this instance.
  ///
  shelf_router.Router get router {
    return GsamRouter._routers[GsamRouterType.values.indexOf(this)];
  }

  /// Ports specified as enabled for this router instance.
  ///
  List<int> get ports {
    switch (this) {
      case GsamRouterType.public:
        return [
          // Default HTTP port.
          80,
          // Default HTTPS port.
          8443,
        ];
      case GsamRouterType.api:
        return [
          // Default development port.
          49152,
          // Testing / QA port.
          49153,
        ];
      case GsamRouterType.resources:
        return [
          // Default resources port.
          49154,
        ];
    }
  }
}

/// Central point for the server resource routing services.
///
class GsamRouter {
  GsamRouter._();

  /// URL-parameter with a regular expression that matches every request.
  ///
  static const _dynamicUrl = '/<ignored|.*>';

  /// Router instances declared for each [_GsamRouterType] value.
  ///
  static final _routers = [
    for (final _ in GsamRouterType.values)
      shelf_router.Router()
        ..options(_dynamicUrl, (_) => shelf.Response.ok(null))
        ..head(_dynamicUrl, (_) => shelf.Response.ok(null))
  ];

  /// Allocate the URL routing service resourcess,
  /// and start serving requests with the specified [router] parameters.
  ///
  static Future<void> init() async {
    for (final routerType in GsamRouterType.values) {
      final handler = shelf.Pipeline().addHandler(routerType.router.call);
      for (final port in routerType.ports) {
        await shelf_io.serve(
          handler,
          dart_io.InternetAddress.anyIPv4,
          port,
          poweredByHeader: null,
        );
      }
    }
  }
}
