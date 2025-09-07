import 'package:flutter/material.dart';
import 'package:generic_shop_app_fitness_tracker/fitness_tracker.dart';

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
  Widget view(BuildContext context) {
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
                GsaWidgetText(
                  'iFit Club',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                GsaWidgetText(
                  'Personalized plans, real results.\n\n'
                  'Let\'s build a better lifestyle together.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                GsaWidgetButton.filled(
                  label: 'Get Started',
                  onTap: () {
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
