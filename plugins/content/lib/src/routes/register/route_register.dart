import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_services/services.dart';

/// Route providing user authentication options, such as login, registration, or guest user login.
///
class GsaRouteRegister extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteRegister({
    super.key,
    this.username,
    this.password,
  });

  /// Prefilled data.
  ///
  final String? username, password;

  @override
  State<GsaRouteRegister> createState() => _GsaRouteRegisterState();
}

class _GsaRouteRegisterState extends GsaRouteState<GsaRouteRegister> {
  final _formKey = GlobalKey<FormState>();

  final _usernameTextController = TextEditingController(),
      _passwordTextController = TextEditingController(),
      _confirmPasswordTextController = TextEditingController();

  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: GsaWidgetText(widget.displayName)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const GsaWidgetText(
              'Register an Account',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            const GsaWidgetText(
              'Registering an account grants you access to exclusive benefits and features.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
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
              controller: _usernameTextController,
              labelText: 'Username',
              validator: GsaServiceInputValidation.instance.email,
            ),
            const SizedBox(height: 12),
            GsaWidgetTextField(
              controller: _passwordTextController,
              labelText: 'Password',
              validator: GsaServiceInputValidation.instance.password,
            ),
            const SizedBox(height: 12),
            GsaWidgetTextField(
              controller: _confirmPasswordTextController,
              labelText: 'Confirm Password',
              validator: GsaServiceInputValidation.instance.email,
            ),
            const SizedBox(height: 20),
            GsaWidgetTermsConfirmation(
              value: _termsAccepted,
              onValueChanged: (value) {
                _termsAccepted = value;
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FilledButton(
                child: Text('Continue'),
                onPressed: () async {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    super.dispose();
  }
}
