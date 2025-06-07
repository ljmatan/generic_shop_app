import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_fitness_tracker/src/view/routes/_routes.dart';

/// Fitness Tracker app "Welcome" screen.
///
class GftRouteSplash extends GftRoute {
  /// Default, unnamed widget constructor.
  ///
  const GftRouteSplash({super.key});

  @override
  State<GftRouteSplash> createState() => _GftRouteSplashState();
}

class _GftRouteSplashState extends GsaRouteState<GftRouteSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const GsaWidgetFlairBlobBackground(
            centerOverlay: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'iFit Club',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Personalized plans, real results.\n\n'
                  'Let\'s build a better lifestyle together.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    const GftRouteOnboarding().push(
                      replacement: true,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
