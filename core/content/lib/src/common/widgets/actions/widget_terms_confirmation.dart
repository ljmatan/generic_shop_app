import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

class GsaWidgetTermsConfirmation extends StatelessWidget {
  const GsaWidgetTermsConfirmation({
    super.key,
    required this.value,
    required this.onValueChanged,
    this.checkboxKey,
    this.includeTermsAndConditions = true,
    this.includePrivacyPolicy = true,
    this.includeCookieAgreement = false,
  });

  final bool value;

  final Function(bool value) onValueChanged;

  final GlobalKey<GsaWidgetSwitchState>? checkboxKey;

  /// Property defining whether a legal document entry is required for agreement display.
  ///
  final bool includeTermsAndConditions, includePrivacyPolicy, includeCookieAgreement;

  @override
  Widget build(BuildContext context) {
    return GsaWidgetSwitch(
      key: checkboxKey,
      value: value,
      label: GsaWidgetText(
        'User Agreement',
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
      child: GsaWidgetText.rich(
        [
          const GsaWidgetTextSpan(
            'I confirm that I have reviewed and agree to abide by the ',
          ),
          GsaWidgetTextSpan(
            'Terms and Conditions',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
            onTap: () {
              Navigator.of(context).pushNamed('terms-and-conditions');
            },
          ),
          const GsaWidgetTextSpan(
            ' and ',
          ),
          GsaWidgetTextSpan(
            'Privacy Policy',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).primaryColor,
              decoration: TextDecoration.underline,
            ),
            onTap: () {
              Navigator.of(context).pushNamed('privacy-policy');
            },
          ),
          const GsaWidgetTextSpan(
            '.',
          ),
        ],
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
      onTap: (value) => onValueChanged(value),
    );
  }
}
