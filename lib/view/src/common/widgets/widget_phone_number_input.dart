import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/common/widgets/actions/widget_dropdown.dart';
import 'package:generic_shop_app/view/src/common/widgets/actions/widget_text_field.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';

/// Widget for displaying of phone number input forms.
///
class GsaWidgetPhoneNumberInput extends StatefulWidget {
  // ignore: public_member_api_docs
  const GsaWidgetPhoneNumberInput({
    super.key,
    required this.prefix,
    required this.setPrefix,
    required this.phoneNumberController,
  });

  /// Phone number prefix.
  ///
  final String Function() prefix;

  /// Method for setting the phone number prefix with a user-specified dropdown value.
  ///
  final Function(String) setPrefix;

  /// The text editing controller handling phone number input changes.
  ///
  final TextEditingController phoneNumberController;

  @override
  State<GsaWidgetPhoneNumberInput> createState() => _GsaWidgetPhoneNumberInputState();
}

class _GsaWidgetPhoneNumberInputState extends State<GsaWidgetPhoneNumberInput> {
  static const _phonePrefixes = ['1', '33', '34', '385', '49'];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GsaWidgetDropdown(
            padding: 20,
            valueAt: _phonePrefixes.indexOf(widget.prefix()),
            height: 52,
            children: [
              for (var i = 0; i < _phonePrefixes.length; i++)
                (
                  label: '+${_phonePrefixes[i]}',
                  id: null,
                  onTap: () => widget.setPrefix(_phonePrefixes[i]),
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: GsaWidgetTextField(
            controller: widget.phoneNumberController,
            keyboardType: TextInputType.number,
            labelText: 'Phone Number',
            validator: (phoneNumber) {
              return GsaaServiceInputValidation.instance.phoneNumber(widget.prefix() + phoneNumber!);
            },
          ),
        ),
      ],
    );
  }
}
