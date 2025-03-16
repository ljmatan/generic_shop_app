import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:generic_shop_app_content/src/common/widgets/overlays/widget_overlay.dart';
import 'package:generic_shop_app_services/services.dart';

/// Widget overlay displaying user privacy policy and terms and conditions consent content.
///
class GsaWidgetOverlayConsent extends GsaWidgetOverlay {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetOverlayConsent({
    super.key,
  });

  @override
  bool get barrierDismissible => GsaServiceConsent.instance.hasMandatoryConsent;

  @override
  State<GsaWidgetOverlayConsent> createState() => _GsaWidgetOverlayConsentState();
}

class _GsaWidgetOverlayConsentState extends State<GsaWidgetOverlayConsent> {
  final _cookieIds = {
    GsaServiceCacheId.mandatoryCookiesConsent:
        'Mandatory cookies are required to use our products and are necessary for our sites to work as intended.',
    GsaServiceCacheId.functionalCookiesConsent:
        'Functional cookies enhance the usability and performance of our products by enabling various functionalities.',
    GsaServiceCacheId.statisticalCookiesConsent:
        'Statistical cookies collect anonymous data to analyze and understand how visitors interact with our services.',
    GsaServiceCacheId.marketingCookiesConsent:
        'Marketing cookies are utilized to tailor advertisements and promotional content to your interests.',
  };

  late List<bool> _cookieIdConsentStatus;

  @override
  void initState() {
    super.initState();
    _cookieIdConsentStatus = [
      for (final cookieId in _cookieIds.entries) cookieId.key == GsaServiceCacheId.mandatoryCookiesConsent || cookieId.key.value == true,
    ];
  }

  final _scrollController = ScrollController();

  Future<void> _acceptAll() async {
    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 20,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
    setState(() {
      for (int i = 0; i < _cookieIdConsentStatus.length; i++) {
        _cookieIdConsentStatus[i] = true;
      }
    });
  }

  Future<void> _declineOptional() async {
    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 20,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
    setState(() {
      for (int i = 0; i < _cookieIdConsentStatus.length; i++) {
        if (_cookieIds.entries.elementAt(i).key != GsaServiceCacheId.mandatoryCookiesConsent) {
          _cookieIdConsentStatus[i] = false;
        }
      }
    });
  }

  Future<void> _acceptSelection() async {
    if (_scrollController.position.pixels < _scrollController.position.maxScrollExtent - 20) {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 20,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      for (final id in _cookieIds.entries.indexed) {
        await id.$2.key.setValue(_cookieIdConsentStatus[id.$1]);
      }
      GsaServiceConsent.instance.onConsentStatusChanged();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: GsaServiceConsent.instance.consentStatus.mandatoryCookies() != null,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const GsaWidgetText('Cookie Notice', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                      const SizedBox(height: 12),
                      const Divider(height: 0),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .6),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              GsaWidgetText.rich([
                                const GsaWidgetTextSpan(
                                  'We use cookies and similar technologies to help provide and improve content.\n\n'
                                  'You have control over the optional cookies that we use, '
                                  'and you can review or change your choices at any time.\n\n'
                                  'Learn more about cookies and how we use them by reviewing our ',
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                GsaWidgetTextSpan(
                                  'Cookie Policy',
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
                                const GsaWidgetTextSpan(', ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                GsaWidgetTextSpan(
                                  'Privacy Policy',
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
                                const GsaWidgetTextSpan(', and ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                GsaWidgetTextSpan(
                                  'Terms and Conditions',
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
                                const GsaWidgetTextSpan('.', style: TextStyle(color: Colors.grey, fontSize: 12)),
                              ]),
                              const SizedBox(height: 20),
                              for (final cookieId in _cookieIds.entries.indexed)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: GsaWidgetSwitch(
                                    label: GsaWidgetText(
                                      cookieId.$2.key.displayName,
                                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                                    ),
                                    child: GsaWidgetText(
                                      cookieId.$2.value,
                                      style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 10),
                                    ),
                                    enabled: cookieId.$2.key != GsaServiceCacheId.mandatoryCookiesConsent,
                                    value: _cookieIdConsentStatus[cookieId.$1],
                                    onTap: (value) {
                                      setState(() {
                                        _cookieIdConsentStatus[cookieId.$1] = !_cookieIdConsentStatus[cookieId.$1];
                                      });
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
                        child: FilledButton(
                          child: const GsaWidgetText(
                            'CONFIRM SELECTION',
                            style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w900),
                          ),
                          onPressed: () => _acceptSelection(),
                        ),
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.fastEaseInToSlowEaseOut,
                        child: _cookieIdConsentStatus.every((consentStatus) => consentStatus)
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: TextButton(
                                  child: const GsaWidgetText(
                                    'DECLINE OPTIONAL',
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                                  ),
                                  onPressed: () => _declineOptional(),
                                ),
                              )
                            : const SizedBox(),
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.fastEaseInToSlowEaseOut,
                        child: _cookieIdConsentStatus.any((consentStatus) => !consentStatus)
                            ? Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextButton(
                                    child: const GsaWidgetText('ACCEPT ALL', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
                                    onPressed: () => _acceptAll(),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
