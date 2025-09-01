import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_services/services.dart';

part 'i18n/widget_cookie_consent_i18n.dart';

/// Visual element containing the required, legal consent
/// asking for user cookie storage permission.
///
class GsaWidgetCookieConsent extends StatefulWidget {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetCookieConsent({super.key});

  @override
  State<GsaWidgetCookieConsent> createState() => _GsaWidgetCookieConsentState();
}

class _GsaWidgetCookieConsentState extends State<GsaWidgetCookieConsent> {
  final _cookieIds = <({
    bool enabled,
    GsaServiceCacheEntry cacheEntry,
    String label,
  })>{
    (
      enabled: GsaConfig.plugin.enabledCookieTypes.mandatory,
      cacheEntry: GsaServiceCacheEntry.cookieConsentMandatory,
      label: GsaWidgetCookieConsentI18N.mandatoryCookiesDescription.value.display,
    ),
    (
      enabled: GsaConfig.plugin.enabledCookieTypes.functional,
      cacheEntry: GsaServiceCacheEntry.cookieConsentFunctional,
      label: GsaWidgetCookieConsentI18N.functionalCookiesDescription.value.display,
    ),
    (
      enabled: GsaConfig.plugin.enabledCookieTypes.statistical,
      cacheEntry: GsaServiceCacheEntry.cookieConsentStatistical,
      label: GsaWidgetCookieConsentI18N.statisticalCookiesDescription.value.display,
    ),
    (
      enabled: GsaConfig.plugin.enabledCookieTypes.marketing,
      cacheEntry: GsaServiceCacheEntry.cookieConsentMarketing,
      label: GsaWidgetCookieConsentI18N.marketingCookiesDescription.value.display,
    ),
  };

  late List<bool> _cookieIdConsentStatus;

  @override
  void initState() {
    super.initState();
    _cookieIdConsentStatus = _cookieIds.map(
      (cookieId) {
        final isMandatory = cookieId.cacheEntry == GsaServiceCacheEntry.cookieConsentMandatory;
        final userAccepted = cookieId.cacheEntry.value == true;
        return cookieId.enabled && (isMandatory || userAccepted);
      },
    ).toList();
  }

  final _scrollController = ScrollController();

  Future<void> _acceptAll() async {
    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 20,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
    setState(
      () {
        for (int i = 0; i < _cookieIdConsentStatus.length; i++) {
          if (_cookieIds.elementAt(i).enabled) {
            _cookieIdConsentStatus[i] = true;
          }
        }
      },
    );
  }

  Future<void> _declineOptional() async {
    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 20,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
    setState(
      () {
        for (int i = 0; i < _cookieIdConsentStatus.length; i++) {
          final cookie = _cookieIds.elementAt(i);
          if (cookie.enabled && cookie.cacheEntry != GsaServiceCacheEntry.cookieConsentMandatory) {
            _cookieIdConsentStatus[i] = false;
          }
        }
      },
    );
  }

  Future<void> _acceptSelection() async {
    if (_scrollController.position.pixels < _scrollController.position.maxScrollExtent - 20) {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 20,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      for (final id in _cookieIds.indexed) {
        await id.$2.cacheEntry.setValue(_cookieIdConsentStatus[id.$1]);
      }
      GsaServiceConsent.instance.onConsentStatusChanged();
      Navigator.pop(context);
      GsaServiceAppTrackingTransparency.instance.requestConsent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: GsaServiceConsent.instance.consentStatus.mandatoryCookies() != null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GsaWidgetText(
            GsaWidgetCookieConsentI18N.title.value.display,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 0),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * .6,
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  GsaWidgetText.rich(
                    [
                      GsaWidgetTextSpan(
                        GsaWidgetCookieConsentI18N.descriptionIntro.value.display,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      GsaWidgetTextSpan(
                        GsaWidgetCookieConsentI18N.descriptionCookiePolicyLink.value.display,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('cookie-policy');
                        },
                      ),
                      const GsaWidgetTextSpan(
                        ', ',
                        interpolated: true,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      GsaWidgetTextSpan(
                        GsaWidgetCookieConsentI18N.descriptionPrivacyPolicyLink.value.display,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('privacy-policy');
                        },
                      ),
                      const GsaWidgetTextSpan(
                        ', ',
                        interpolated: true,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      GsaWidgetTextSpan(
                        GsaWidgetCookieConsentI18N.descriptionAddition.value.display,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const GsaWidgetTextSpan(
                        ' ',
                        interpolated: true,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      GsaWidgetTextSpan(
                        GsaWidgetCookieConsentI18N.descriptionTermsAndConditionsLink.value.display,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('terms-and-conditions');
                        },
                      ),
                      const GsaWidgetTextSpan(
                        '.',
                        interpolated: true,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  for (final cookieId in _cookieIds.indexed)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GsaWidgetSwitch(
                        label: GsaWidgetText(
                          cookieId.$2.cacheEntry.displayName,
                          style: TextStyle(
                            color: cookieId.$2.enabled ? null : Colors.grey,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        child: GsaWidgetText(
                          cookieId.$2.label,
                          style: TextStyle(
                            color: cookieId.$2.enabled ? null : Colors.grey,
                            fontWeight: FontWeight.w300,
                            fontSize: 10,
                          ),
                        ),
                        enabled: cookieId.$2.enabled && cookieId.$2.cacheEntry != GsaServiceCacheEntry.cookieConsentMandatory,
                        value: _cookieIdConsentStatus[cookieId.$1],
                        onTap: (value) {
                          setState(
                            () {
                              _cookieIdConsentStatus[cookieId.$1] = !_cookieIdConsentStatus[cookieId.$1];
                            },
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          const Divider(height: 0),
          const SizedBox(height: 12),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: GsaWidgetButton.outlined(
              label: GsaWidgetCookieConsentI18N.confirmSelectionButtonLabel.value.display,
              onTap: () => _acceptSelection(),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastEaseInToSlowEaseOut,
            child: _cookieIdConsentStatus.indexed.every(
              (consentStatus) {
                return consentStatus.$2 || !_cookieIds.elementAt(consentStatus.$1).enabled;
              },
            )
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: GsaWidgetButton.text(
                      label: GsaWidgetCookieConsentI18N.declineOptionalButtonLabel.value.display,
                      onTap: () => _declineOptional(),
                    ),
                  )
                : const SizedBox(),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastEaseInToSlowEaseOut,
            child: _cookieIdConsentStatus.indexed.any(
              (consentStatus) {
                return !consentStatus.$2 && _cookieIds.elementAt(consentStatus.$1).enabled;
              },
            )
                ? Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: GsaWidgetButton.text(
                        label: GsaWidgetCookieConsentI18N.acceptAllButtonLabel.value.display,
                        onTap: () => _acceptAll(),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
