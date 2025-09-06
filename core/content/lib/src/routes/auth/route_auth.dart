import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// Authentication options screen, used for displaying user authentication options.
///
class GsaRouteAuth extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteAuth({super.key});

  @override
  bool get enabled {
    return GsaConfig.authenticationEnabled;
  }

  @override
  GsaRouteState<GsaRouteAuth> createState() => _GsaRouteAuthState();
}

class _GsaRouteAuthState extends GsaRouteState<GsaRouteAuth> {
  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (Navigator.of(context).canPop())
            GsaWidgetAppBar(
              label: widget.displayName,
            ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GsaWidgetLogo(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: GsaWidgetText.rich(
                            [
                              const GsaWidgetTextSpan(
                                'Join a community that puts you first.\n\n'
                                'With a free account, you\'ll unlock exclusive features, personalized content, '
                                'and a seamless experience across all your devices. Whether you\'re here to explore, connect, or get things done faster, '
                                'we\'ve got you covered.\n\n',
                              ),
                              for (final info in <(String, String)>{
                                if (GsaConfig.registrationEnabled)
                                  (
                                    'Sign up',
                                    'Enjoy special perks and a tailored experience.',
                                  ),
                                (
                                  'Log in',
                                  'Pick up right where you left off.',
                                ),
                                if (GsaConfig.guestLoginEnabled)
                                  (
                                    'Continue as a guest',
                                    'No commitment, just pure access.',
                                  ),
                              }) ...[
                                GsaWidgetTextSpan(
                                  info.$1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                GsaWidgetTextSpan(
                                  ' - ${info.$2}\n',
                                ),
                              ],
                              const GsaWidgetTextSpan(
                                '\nYour journey starts now!',
                              ),
                            ],
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (GsaConfig.registrationEnabled) ...[
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GsaWidgetButton.outlined(
                                label: 'Register',
                                onTap: () {
                                  Navigator.popUntil(context, (route) => route.isFirst);
                                  const GsaRouteRegister().push();
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GsaWidgetText(
                              'or',
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                        Expanded(
                          child: Align(
                            alignment: GsaConfig.registrationEnabled ? Alignment.centerLeft : Alignment.center,
                            child: GsaWidgetButton.outlined(
                              label: 'Login',
                              onTap: () {
                                Navigator.popUntil(context, (route) => route.isFirst);
                                const GsaRouteLogin().push();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (GsaConfig.guestLoginEnabled) ...[
                      const SizedBox(height: 8),
                      GsaWidgetButton.text(
                        label: 'Continue as Guest',
                        onTap: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                          const GsaRouteShop().push(replacement: true);
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
