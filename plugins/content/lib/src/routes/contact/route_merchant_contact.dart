import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_services/services.dart';

/// Route for displaying of the contact input forms and general merchant contact information.
///
class GsaRouteMerchantContact extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteMerchantContact({super.key});

  @override
  State<GsaRouteMerchantContact> createState() => _GsaRouteMerchantContactState();
}

class _GsaRouteMerchantContactState extends GsaRouteState<GsaRouteMerchantContact> {
  final _messageController = TextEditingController(), _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GsaWidgetAppBar(
            label: widget.displayName,
          ),
          Expanded(
            child: SingleChildScrollView(
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
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GsaWidgetTextField(
                            controller: _emailController,
                            labelText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: GsaServiceInputValidation.instance.email,
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
                            child: OutlinedButton(child: const GsaWidgetText('Send'), onPressed: () async {}),
                          ),
                          SizedBox(height: MediaQuery.of(context).padding.bottom),
                        ],
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
    _messageController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
