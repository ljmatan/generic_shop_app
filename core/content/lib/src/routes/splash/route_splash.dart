import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

/// Route dislaying all of the logged information, implemented for debugging purposes.
///
class GsaRouteSplash extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteSplash({super.key});

  @override
  GsaRouteState<GsaRouteSplash> createState() => _GsaRouteSplashState();
}

class _GsaRouteSplashState extends GsaRouteState<GsaRouteSplash> {
  /// Defines whether the application content is ready for initialisation and display.
  ///
  bool _readyToInitialise = GsaServiceConsent.instance.hasMandatoryConsent;

  /// Whether the plugin service setup method has been executed successfully.
  ///
  /// The method would normally not fail, so in case of initialisation retry,
  /// it will not be called again.
  ///
  bool _serviceSetupComplete = false;

  /// Function implemented for application runtime setup.
  ///
  Future<void> _initialise() async {
    if (!_serviceSetupComplete) {
      await GsaPlugin.of(context).setupService(context);
      _serviceSetupComplete = true;
    }
    await GsaPlugin.of(context).init();
    Future.delayed(
      Duration.zero,
      () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return GsaPlugin.of(context).routes.initialRoute(context);
            },
          ),
          (route) => false,
        );
      },
    );
    return;
  }

  /// Property holding the [Future] state of the [_initialise] method.
  ///
  late Future<void> _initialiser;

  @override
  void initState() {
    super.initState();
    if (_readyToInitialise) {
      _initialiser = _initialise();
    } else {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          await const GsaWidgetOverlayCookieConsent().openDialog();
          setState(
            () {
              _readyToInitialise = true;
              _initialiser = _initialise();
            },
          );
        },
      );
    }
  }

  @override
  Widget view(BuildContext context) {
    if (!_readyToInitialise) return const SizedBox();
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initialiser,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: GsaWidgetLoadingIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: GsaWidgetError(
                snapshot.error.toString(),
                action: () {
                  _initialiser = _initialise();
                  setState(() {});
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
