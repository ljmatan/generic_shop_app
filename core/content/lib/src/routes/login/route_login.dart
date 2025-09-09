import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

part 'i18n/route_login_i18n.dart';

/// Route providing user authentication options, such as login, registration, or guest user login.
///
class GsaRouteLogin extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteLogin({super.key});

  @override
  bool get enabled {
    if (GsaRoute.navigatorContext == null) {
      throw Exception(
        'Navigator context not available.',
      );
    }
    return GsaPlugin.of(GsaRoute.navigatorContext!).features.authentication;
  }

  @override
  State<GsaRouteLogin> createState() => _GsaRouteLoginState();
}

class _GsaRouteLoginState extends GsaRouteState<GsaRouteLogin> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _emailTextController, _passwordTextController;

  late bool _userAgreementRequired;

  final _termsSwitchKey = GlobalKey<GsaWidgetSwitchState>();

  late bool _userAgreementAccepted;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController(
      text: switch (GsaPlugin.of(GsaRoute.navigatorContext!).client) {
        GsaPluginClient.froddoB2b => kDebugMode ? 'hyper@hyper.hr' : null,
        _ => null,
      },
    );
    _passwordTextController = TextEditingController(
      text: switch (GsaPlugin.of(GsaRoute.navigatorContext!).client) {
        GsaPluginClient.froddoB2b => kDebugMode ? '1234' : null,
        _ => null,
      },
    );
    _userAgreementRequired = <String?>{
      GsaPlugin.of(GsaRoute.navigatorContext!).documentUrls?.cookieNotice,
      GsaPlugin.of(GsaRoute.navigatorContext!).documentUrls?.termsAndConditions,
      GsaPlugin.of(GsaRoute.navigatorContext!).documentUrls?.privacyPolicy,
    }.any(
      (document) {
        return document != null;
      },
    );
    _userAgreementAccepted = !_userAgreementRequired;
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GsaWidgetAppBar(
            label: GsaRouteLoginI18N.appBarTitle.value.display,
          ),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: Theme.of(context).maxOverlayInlineWidth,
                ),
                child: SingleChildScrollView(
                  padding: Theme.of(context).paddings.listView(),
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GsaWidgetText(
                            GsaRouteLoginI18N.accountDetailsTitle.value.display,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        GsaWidgetTextField(
                          controller: _emailTextController,
                          autofocus: true,
                          labelText: GsaRouteLoginI18N.emailInputFieldTitle.value.display,
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
                          labelText: GsaRouteLoginI18N.passwordInputFieldTitle.value.display,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                          ),
                          validator: (value) {
                            return GsaServiceInputValidation.instance.password(
                              context,
                              input: value,
                            );
                          },
                        ),
                        if (<GsaPluginClient>{}.contains(GsaPlugin.of(context).client)) ...[
                          const SizedBox(height: 10),
                          GsaWidgetButton.text(
                            label: GsaRouteLoginI18N.openForgotPasswordScreenButtonTitle.value.display,
                            onTap: () {},
                          ),
                        ],
                        if (_userAgreementRequired) ...[
                          const SizedBox(height: 10),
                          GsaWidgetTermsConfirmation(
                            key: _termsSwitchKey,
                            value: _userAgreementAccepted,
                            includeCookieAgreement: true,
                            onValueChanged: (value) {
                              setState(() {
                                _userAgreementAccepted = value;
                              });
                            },
                          ),
                        ],
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (GsaPlugin.of(context).features.registration) ...[
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GsaWidgetButton.outlined(
                                    label: GsaRouteLoginI18N.openRegisterScreenButtonTitle.value.display,
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
                                  GsaRouteLoginI18N.authenticationOptionSeparator.value.display,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                            Expanded(
                              child: Align(
                                alignment: GsaPlugin.of(context).features.registration ? Alignment.centerLeft : Alignment.center,
                                child: GsaWidgetButton.outlined(
                                  label: GsaRouteLoginI18N.loginButtonTitle.value.display,
                                  onTap: () async {
                                    final formsValidated = _formKey.currentState?.validate() == true;
                                    final termsValidated = _userAgreementRequired ? _termsSwitchKey.currentState?.validate() == true : true;
                                    if (formsValidated && termsValidated) {
                                      FocusScope.of(context).unfocus();
                                      const GsaWidgetOverlayContentBlocking().openDialog();
                                      try {
                                        if (GsaPlugin.of(context).api?.loginWithUsernameAndPassword == null) {
                                          throw Exception(
                                            'GsaPlugin.of(context).loginWithUsernameAndPassword '
                                            'not applied for plugin ${GsaPlugin.of(context).id}.',
                                          );
                                        }
                                        await GsaPlugin.of(context).api!.loginWithUsernameAndPassword!(
                                          username: _emailTextController.text,
                                          password: _passwordTextController.text,
                                        );
                                        Navigator.pop(GsaRoute.navigatorContext ?? context);
                                        GsaPlugin.of(context)
                                            .routes
                                            .initialRoute(
                                              GsaRoute.navigatorContext ?? context,
                                            )
                                            .push(replacement: true);
                                      } catch (e) {
                                        GsaServiceLogging.instance.logError('Error logging in:\n$e');
                                        Navigator.pop(GsaRoute.navigatorContext ?? context);
                                        GsaWidgetOverlayAlert(
                                          '$e',
                                        ).openDialog();
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (GsaPlugin.of(context).features.guestLogin) ...[
                          const SizedBox(height: 8),
                          GsaWidgetButton.text(
                            label: GsaRouteLoginI18N.continueAsGuestButtonTitle.value.display,
                            onTap: () {
                              const GsaRouteShop().push(replacement: true);
                            },
                          ),
                        ],
                      ],
                    ),
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
