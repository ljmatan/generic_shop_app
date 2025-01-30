import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app/config.dart';
import 'package:generic_shop_app/services/services.dart';
import 'package:generic_shop_app/view/src/common/theme.dart';
import 'package:generic_shop_app/view/src/common/widgets/overlays/widget_overlay_consent.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_error.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// A builder for inserting widgets above the [Navigator].
///
/// The responsibilities of this builder widget are:
///
/// - Implements the user app access logic (cookies and display handling)
/// - Manage the color of the system status and navigation bars
/// - Dinamically adjust text size according to the screen size
/// - Provide access point to the debug route with QA builds
///
class GsaViewBuilder extends StatefulWidget {
  // ignore: public_member_api_docs
  const GsaViewBuilder(
    this.child, {
    super.key,
  });

  /// Route generated by the [MaterialApp.home] or [MaterialApp.onGenerateRoute] property.
  ///
  final Widget child;

  @override
  State<GsaViewBuilder> createState() => _GsaViewBuilderState();
}

class _GsaViewBuilderState extends State<GsaViewBuilder> {
  /// Handles the specified (URL) route initialisation and ensures the app resource allocation.
  ///
  /// As the widget defined in this class is placed above all other content,
  /// this [Future] will also handle the user privacy consent process.
  ///
  Future<void> _setupSession() async {
    await GsaConfig.init();
    await GsarService.initAll();
    await GsarData.initAll();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Handle platform theme brightness changes.
    final systemBrightness = MediaQuery.of(context).platformBrightness;
    if (systemBrightness != GsaTheme.platformBrightness) {
      setState(() => GsaTheme.platformBrightness = systemBrightness);
    }
  }

  /// Variable holding the current tap count in the last 3 seconds.
  ///
  /// If the QA build mode is enabled, the "debug" route will be opened on 10 taps in 3 seconds.
  ///
  int _recordedNumberOfTaps = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: GsaTheme.systemUiOverlayStyle,
      child: Theme(
        data: GsaTheme.data,
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
              MediaQuery.of(context).size.width < 400
                  ? 1
                  : MediaQuery.of(context).size.width < 600
                      ? 1.1
                      : MediaQuery.of(context).size.width < 800
                          ? 1.2
                          : MediaQuery.of(context).size.width < 1000
                              ? 1.3
                              : MediaQuery.of(context).size.width < 1400
                                  ? 1.4
                                  : 1.6,
            ),
          ),
          child: Listener(
            child: FutureBuilder(
              future: _setupSession(),
              builder: (context, setupResponse) {
                if (setupResponse.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (setupResponse.hasError) {
                  return Material(
                    child: GsaWidgetError(
                      setupResponse.error.toString(),
                    ),
                  );
                }
                return widget.child;
              },
            ),
            onPointerDown: GsaConfig.qaBuild
                ? (_) {
                    _recordedNumberOfTaps++;
                    if (_recordedNumberOfTaps == 10) {
                      _recordedNumberOfTaps = 0;
                      GsaRouteDebug().navigate();
                    } else {
                      Future.delayed(
                        const Duration(seconds: 3),
                        () => _recordedNumberOfTaps--,
                      );
                    }
                  }
                : null,
          ),
        ),
      ),
    );
  }
}
