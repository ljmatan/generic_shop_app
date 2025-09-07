import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

/// The default application builder,
/// class name name standing for "**G**eneric **S**hop **A**pp".
///
class Gsa extends StatefulWidget {
  /// Entrypoint to the Flutter SDK application services,
  /// integrating a [State] object which implements the [MaterialApp] and [Navigator] widgets as root objects.
  ///
  const Gsa({super.key});

  @override
  State<Gsa> createState() => GsaState();
}

class GsaState extends State<Gsa> {
  /// Property holding the value of the runtime resource allocation method.
  ///
  Future<void> _initFuture = GsaConfig.init();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Material(
            child: Center(
              child: GsaWidgetLoadingIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Material(
              child: Center(
                child: GsaWidgetError(
                  snapshot.error.toString(),
                  retry: () {
                    setState(() {
                      _initFuture = GsaConfig.init();
                    });
                  },
                ),
              ),
            ),
          );
        }

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
      },
    );
  }
}
