import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';

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
          child: widget.child,
          onPointerDown: GsaConfig.qaBuild
              ? (_) {
                  _recordedNumberOfTaps++;
                  if (_recordedNumberOfTaps == 10) {
                    _recordedNumberOfTaps = 0;
                    GsaRouteDebug().push();
                  } else {
                    Future.delayed(
                      const Duration(seconds: 3),
                      () {
                        if (_recordedNumberOfTaps > 0) _recordedNumberOfTaps--;
                      },
                    );
                  }
                }
              : null,
        ),
      ),
    );
  }
}
