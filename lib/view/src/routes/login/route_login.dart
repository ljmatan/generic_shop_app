import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/common/widgets/actions/widget_switch.dart';
import 'package:generic_shop_app/view/src/common/widgets/actions/widget_text_field.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_text.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';

/// Route providing user authentication options, such as login, registration, or guest user login.
///
class GsaRouteLogin extends GsaRoute {
  // ignore: public_member_api_docs
  const GsaRouteLogin({super.key});

  @override
  State<GsaRouteLogin> createState() => _GsaRouteLoginState();

  @override
  String get routeId => 'auth';

  @override
  String get displayName => 'Authentication';
}

class _GsaRouteLoginState extends GsaRouteState<GsaRouteLogin> {
  final _emailTextController = TextEditingController(), _passwordTextController = TextEditingController();

  bool _userAgreementAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 60,
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 36),
              const Align(
                alignment: Alignment.centerLeft,
                child: GsaWidgetText(
                  'Account Details',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              GsaWidgetTextField(
                controller: _emailTextController,
                autofocus: true,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.email,
                  color: Theme.of(context).primaryColor,
                ),
                validator: GsaaServiceInputValidation.instance.email,
              ),
              const SizedBox(height: 16),
              GsaWidgetTextField(
                controller: _passwordTextController,
                labelText: 'Password',
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: Icon(
                  Icons.lock,
                  color: Theme.of(context).primaryColor,
                ),
                validator: GsaaServiceInputValidation.instance.password,
              ),
              const SizedBox(height: 24),
              StatefulBuilder(
                builder: (context, setState) {
                  return GsaWidgetSwitch(
                    label: const GsaWidgetText(
                      'User Agreement',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    child: GsaWidgetText.rich(
                      [
                        const GsaWidgetTextSpan(
                          'I understand and agree to the ',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        GsaWidgetTextSpan(
                          'terms and conditions',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('terms-and-conditions');
                          },
                        ),
                        const GsaWidgetTextSpan(
                          ', ',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        GsaWidgetTextSpan(
                          'cookie policy',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('privacy-policy');
                          },
                        ),
                        const GsaWidgetTextSpan(
                          ', and ',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        GsaWidgetTextSpan(
                          'privacy policy',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('cookie-policy');
                          },
                        ),
                        const GsaWidgetTextSpan(
                          '.',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    value: _userAgreementAccepted,
                    onTap: (value) => setState(() => _userAgreementAccepted = value),
                  );
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton(
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.of(context).pushNamed('register');
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
                        onPressed: () {},
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }
}
