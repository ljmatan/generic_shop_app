import 'package:flutter/material.dart';
import 'package:generic_shop_app/config.dart';
import 'package:generic_shop_app/view/src/common/theme.dart';
import 'package:generic_shop_app/view/src/common/view_builder.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app/view/src/routes/splash/route_splash.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

@pragma('vm:entry-point')
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GsaConfig.init();
  runApp(const Gsa());
}

/// The default application builder, class name name standing for "**G**eneric **S**hop **A**pp".
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
      navigatorKey: GsarRoute.navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => GsaViewBuilder(child!),
      navigatorObservers: [GsarRoute.navigatorObserver],
      home: GsaRouteSplash(),
      theme: GsaTheme.data,
      onGenerateRoute: (settings) {
        final primary = settings.name?.split('/')[0];
      },
    );
  }
}
