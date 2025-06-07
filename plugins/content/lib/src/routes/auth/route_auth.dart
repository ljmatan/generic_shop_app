import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// Authentication options screen, used for displaying user authentication options.
///
class GsaRouteAuth extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteAuth({super.key});

  @override
  GsaRouteState<GsaRouteAuth> createState() => _GsaRouteAuthState();
}

class _GsaRouteAuthState extends GsaRouteState<GsaRouteAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GsaWidgetText(
          widget.displayName,
        ),
      ),
      body: Center(
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
                    color: Theme.of(context).colorScheme.tertiary,
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
                        for (final info in const <(String, String)>{
                          (
                            'Sign up',
                            'Enjoy special perks and a tailored experience.',
                          ),
                          (
                            'Log in',
                            'Pick up right where you left off.',
                          ),
                          (
                            'Continue as a guest',
                            'No commitment, just pure access.',
                          ),
                        }) ...[
                          GsaWidgetTextSpan(
                            info.$1,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GsaWidgetTextSpan(
                            ' - ${info.$2}\n',
                          ),
                        ],
                        GsaWidgetTextSpan(
                          '\nYour journey starts now!',
                        ),
                      ],
                      style: TextStyle(
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
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton(
                        child: const GsaWidgetText(
                          'Register',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          GsaRouteRegister().push();
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: GsaWidgetText(
                      'or',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: OutlinedButton(
                        child: const GsaWidgetText(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          GsaRouteLogin().push();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextButton(
                child: const GsaWidgetText(
                  'Continue as Guest',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  GsaRouteShop().push(replacement: true);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
