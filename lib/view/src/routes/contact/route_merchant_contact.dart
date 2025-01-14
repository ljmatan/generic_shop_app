import 'package:flutter/material.dart';
import 'package:generic_shop_app/services/src/i18n/service_i18n.dart';
import 'package:generic_shop_app/view/src/common/widgets/actions/widget_text_field.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_text.dart';
import 'package:generic_shop_app/view/src/routes/routes.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';

/// Route for displaying of the contact input forms and general merchant contact information.
///
class GsaRouteMerchantContact extends GsaRoute {
  // ignore: public_member_api_docs
  const GsaRouteMerchantContact({super.key});

  @override
  State<GsaRouteMerchantContact> createState() => _GsaRouteMerchantContactState();

  @override
  String get routeId => 'contact';

  @override
  String get displayName => 'Contact';
}

class _GsaRouteMerchantContactState extends GsaRouteState<GsaRouteMerchantContact> {
  final _messageController = TextEditingController(), _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.displayName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.vertical -
              MediaQuery.of(context).viewInsets.bottom -
              kToolbarHeight,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: GsaWidgetText(
                    'We may share your message and email with our partner companies to help us field your questions and offer support.\n\n'
                    'Your details are used to respond to your inquiries or assist you with the products and services.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GsaWidgetTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: GsaaServiceInputValidation.instance.email,
                    ),
                    const SizedBox(height: 12),
                    GsaWidgetTextField(
                      controller: _messageController,
                      labelText: 'Message',
                      minLines: 3,
                      maxLines: 3,
                      keyboardType: TextInputType.text,
                      validator: (input) {
                        if (input == null || input.trim().replaceAll('  ', ' ').length < 10) {
                          return 'Please verify your input.'.translated(context);
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                        child: const GsaWidgetText('Send'),
                        onPressed: () async {},
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
