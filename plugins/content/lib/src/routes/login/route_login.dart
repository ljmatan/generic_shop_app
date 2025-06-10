import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_data/data.dart';
import 'package:generic_shop_app_froddo_b2b/gfb.dart';
import 'package:generic_shop_app_ivancica/api/api.dart';
import 'package:generic_shop_app_services/services.dart';

/// Route providing user authentication options, such as login, registration, or guest user login.
///
class GsaRouteLogin extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteLogin({super.key});

  @override
  State<GsaRouteLogin> createState() => _GsaRouteLoginState();
}

class _GsaRouteLoginState extends GsaRouteState<GsaRouteLogin> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController(), _passwordTextController = TextEditingController();

  bool _userAgreementAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GsaWidgetAppBar(
            label: widget.displayName,
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
                child: Form(
                  key: _formKey,
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
                        validator: GsaServiceInputValidation.instance.email,
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
                        validator: switch (GsaConfig.provider) {
                          GsaConfigProvider.ivancica => null,
                          _ => GsaServiceInputValidation.instance.password,
                        },
                      ),
                      TextButton(
                        style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(
                            EdgeInsets.zero,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(height: 10),
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
                                child: const GsaWidgetText(
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
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() == true) {
                                    const GsaWidgetOverlayContentBlocking().openDialog(context);
                                    try {
                                      switch (GsaConfig.provider) {
                                        case GsaConfigProvider.ivancica:
                                          final user = await GivApiUser.instance.login(
                                            email: _emailTextController.text,
                                            password: _passwordTextController.text,
                                          );
                                          GsaDataUser.instance.user = user;
                                          break;
                                        case GsaConfigProvider.froddoB2b:
                                          final user = await GfbApiUser.instance.login(
                                            email: _emailTextController.text,
                                            password: _passwordTextController.text,
                                          );
                                          GsaDataUser.instance.user = user;
                                          break;
                                        default:
                                          throw UnimplementedError(
                                            'Login method for ${GsaConfig.provider} not implemented.',
                                          );
                                      }
                                      Navigator.pop(context);
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) {
                                            return GsaConfig.provider.plugin.initialRoute();
                                          },
                                        ),
                                        (route) => false,
                                      );
                                    } catch (e) {
                                      debugPrint('Error logging in: $e');
                                      Navigator.pop(context);
                                      GsaWidgetOverlayAlert(
                                        message: '$e',
                                      ).openDialog(context);
                                    }
                                  }
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
