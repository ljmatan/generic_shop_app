import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_services/services.dart';

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

  /// Function implemented for application runtime setup.
  ///
  Future<void> _initialise() async {
    await GsaConfig.provider.plugin.init();
    Future.delayed(
      Duration.zero,
      () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return GsaConfig.provider.plugin.initialRoute();
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
          await const GsaWidgetOverlayConsent().openDialog(context);
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
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: GsaWidgetError(
                snapshot.error.toString(),
                retry: () {
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
