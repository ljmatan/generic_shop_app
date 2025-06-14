import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// The default application builder,
/// class name name standing for "**G**eneric **S**hop **A**pp".
///
class Gsa extends StatefulWidget {
  /// Entrypoint to the Flutter SDK application services,
  /// integrating a [State] object which implements the [MaterialApp] and [Navigator] widgets as root objects.
  ///
  const Gsa({super.key});

  @override
  State<Gsa> createState() => _GsaState();
}

class _GsaState extends State<Gsa> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GsaRoute.navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => GsaViewBuilder(child!),
      navigatorObservers: [GsaRoute.navigatorObserver],
      home: const GsaRouteSplash(),
      theme: GsaTheme.instance.data,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) {
            late GsaRouteType route;
            try {
              route = GsaConfig.plugin.routes!.firstWhere((route) => route.routeId == settings.name);
            } catch (e) {
              route = GsaRoutes.values.firstWhere((route) => route.routeId == settings.name);
            }
            return route.widget();
          },
        );
      },
    );
  }
}
