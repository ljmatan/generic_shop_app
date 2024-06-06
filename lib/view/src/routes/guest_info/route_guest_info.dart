import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app/data/data.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_text.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app/view/src/common/widgets/actions/widget_switch.dart';
import 'package:generic_shop_app/view/src/common/widgets/actions/widget_text_field.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_phone_number_input.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_terms_confirmation.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';

/// Route for entering the guest user information, to be used in checkout process.
///
class GsaRouteGuestInfo extends GsaRoute {
  // ignore: public_member_api_docs
  const GsaRouteGuestInfo({super.key});

  @override
  State<GsaRouteGuestInfo> createState() => _GsaRouteGuestInfoState();

  @override
  String get routeId => 'guest-info';

  @override
  String get displayName => 'User Info';
}

class _GsaRouteGuestInfoState extends GsaRouteState<GsaRouteGuestInfo> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController, _lastNameController, _emailController, _phoneNumberController;

  late String _prefix;

  final _termsAcceptedValueNotifier = ValueNotifier<bool>(false);
  final _termsCheckboxKey = GlobalKey<GsaWidgetSwitchState>();

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(
      text: GsaDataUser.instance.user?.personalDetails?.firstName ?? (kDebugMode ? 'First' : null),
    );
    _lastNameController = TextEditingController(
      text: GsaDataUser.instance.user?.personalDetails?.lastName ?? (kDebugMode ? 'Last' : null),
    );
    _emailController = TextEditingController(
      text: GsaDataUser.instance.user?.contact?.email ?? (kDebugMode ? 'example@email.com' : null),
    );
    _phoneNumberController = TextEditingController(
      text: GsaDataUser.instance.user?.contact?.phoneNumber ?? (kDebugMode ? '12345678' : null),
    );
    _prefix = GsaDataUser.instance.user?.contact?.phoneCountryCode ?? '1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.all(20),
          children: [
            const GsaWidgetText(
              'The personal data you provide in the checkout process will be processed and shared with the order provider and any '
              'affiliated companies for the purpose of completing your transaction and delivering your order.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Personal Details',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16),
            GsaWidgetTextField(
              controller: _firstNameController,
              labelText: 'First Name',
              validator: (input) => GsaaServiceInputValidation.instance.firstName(input!),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 24),
              child: GsaWidgetTextField(
                controller: _lastNameController,
                labelText: 'Last Name',
                validator: (input) => GsaaServiceInputValidation.instance.firstName(input!),
              ),
            ),
            const Text(
              'Contact Details',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: GsaWidgetTextField(
                controller: _emailController,
                labelText: 'E-Mail',
                keyboardType: TextInputType.emailAddress,
                validator: (input) => GsaaServiceInputValidation.instance.email(input!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: GsaWidgetPhoneNumberInput(
                prefix: () => _prefix,
                setPrefix: (value) => _prefix = value,
                phoneNumberController: _phoneNumberController,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _termsAcceptedValueNotifier,
              builder: (context, value, child) {
                return GsaWidgetTermsConfirmation(
                  key: UniqueKey(),
                  checkboxKey: _termsCheckboxKey,
                  value: _termsAcceptedValueNotifier.value,
                  onValueChanged: (value) => _termsAcceptedValueNotifier.value = value,
                );
              },
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        icon: const Icon(Icons.check),
        label: const GsaWidgetText(
          'SUBMIT',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
        onPressed: () {
          if (_termsCheckboxKey.currentState?.validate() != true) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent + 20,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
            );
            return;
          }
          if (_formKey.currentState?.validate() != true) {
            FocusManager.instance.primaryFocus?.unfocus();
            FocusScope.of(context).unfocus();
          } else {
            Navigator.of(context).pushNamed('checkout');
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _termsAcceptedValueNotifier.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
