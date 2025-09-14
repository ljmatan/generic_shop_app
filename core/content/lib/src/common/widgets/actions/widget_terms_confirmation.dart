import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

class GsaWidgetTermsConfirmation extends StatefulWidget {
  const GsaWidgetTermsConfirmation({
    super.key,
    required this.value,
    required this.onValueChanged,
    this.checkboxKey,
    this.includeCookieAgreement = false,
  });

  /// Initially-specified checkbox value.
  ///
  final bool value;

  /// Method invoked on each value update.
  ///
  final Function(bool newValue) onValueChanged;

  /// Key handling the [GsaWidgetSwitch] state.
  ///
  final GlobalKey<GsaWidgetSwitchState>? checkboxKey;

  /// Property defining whether a legal document entry is required for agreement display.
  ///
  final bool includeCookieAgreement;

  @override
  State<GsaWidgetTermsConfirmation> createState() {
    return _GsaWidgetTermsConfirmationState();
  }
}

class _GsaWidgetTermsConfirmationState extends State<GsaWidgetTermsConfirmation> {
  @override
  Widget build(BuildContext context) {
    final plugin = GsaPlugin.of(context);
    if (plugin.documentUrls?.termsAndConditions == null &&
        plugin.documentUrls?.privacyPolicy == null &&
        (!widget.includeCookieAgreement || plugin.documentUrls?.cookieNotice == null)) {
      return const SizedBox();
    }
    return GsaWidgetSwitch(
      key: widget.checkboxKey,
      value: widget.value,
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
          if (plugin.documentUrls?.termsAndConditions != null) ...[
            GsaWidgetTextSpan(
              'Terms and Conditions',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.underline,
              ),
              onTap: () {
                GsaRouteLegalConsent.termsAndConditions(
                  url: plugin.documentUrls!.termsAndConditions!,
                ).push();
              },
            ),
          ],
          if (plugin.documentUrls?.privacyPolicy != null) ...[
            if (plugin.documentUrls?.termsAndConditions != null)
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
                GsaRouteLegalConsent.privacyPolicy(
                  url: plugin.documentUrls!.privacyPolicy!,
                ).push();
              },
            ),
          ],
          if (widget.includeCookieAgreement && plugin.documentUrls?.cookieNotice != null) ...[
            if (plugin.documentUrls?.termsAndConditions != null || plugin.documentUrls?.privacyPolicy != null)
              const GsaWidgetTextSpan(
                ' and ',
              ),
            GsaWidgetTextSpan(
              'Cookie Agreement',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.underline,
              ),
              onTap: () {
                GsaRouteLegalConsent.cookieAgreement(
                  url: plugin.documentUrls!.cookieNotice!,
                ).push();
              },
            ),
          ],
          const GsaWidgetTextSpan(
            '.',
            interpolated: true,
          ),
        ],
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
      onTap: (newValue) {
        widget.onValueChanged(newValue);
      },
    );
  }
}
