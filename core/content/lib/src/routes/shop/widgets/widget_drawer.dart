part of '../route_shop.dart';

class _WidgetDrawer extends StatefulWidget {
  const _WidgetDrawer();

  @override
  State<_WidgetDrawer> createState() => _WidgetDrawerState();
}

class _WidgetDrawerState extends State<_WidgetDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width < 750 ? MediaQuery.of(context).size.width * .8 : 600,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          20 + MediaQuery.of(context).padding.top,
          16,
          20 + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: Row(
                    children: [
                      const CircleAvatar(
                        child: Center(
                          child: Icon(Icons.person_2_outlined),
                        ),
                      ),
                      const SizedBox(width: 14),
                      GsaWidgetText(
                        GsaDataUser.instance.user?.personalDetails?.formattedName ?? 'Login',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    if (GsaDataUser.instance.authenticated) {
                      const GsaRouteUserProfile().push();
                    } else {
                      const GsaRouteAuth().push();
                    }
                  },
                ),
                const SizedBox(height: 30),
                for (int i = 0; i < 2; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GsaWidgetText(
                            i == 0 ? 'Language' : 'Currency',
                            style: const TextStyle(),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: GsaWidgetDropdown(
                              valueAt: i == 0
                                  ? GsaServiceI18NLanguage.values.indexOf(GsaConfig.language)
                                  : GsaModelPriceCurrencyType.values.indexOf(GsaConfig.currency),
                              children: i == 0
                                  ? [
                                      for (final language in GsaServiceI18NLanguage.values)
                                        (
                                          id: language.name,
                                          label: language.displayName,
                                          onTap: () {
                                            GsaConfig.languageNotifier.value = language;
                                            context.routeState?.rebuildAllRoutes();
                                          },
                                        ),
                                    ]
                                  : [
                                      for (final currency in GsaModelPriceCurrencyType.values)
                                        (
                                          id: currency.name,
                                          label: currency.displayName,
                                          onTap: () {
                                            GsaConfig.currencyNotifier.value = currency;
                                            context.routeState?.rebuildAllRoutes();
                                          },
                                        ),
                                    ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: MediaQuery.of(context).size.width < 1000 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  for (final action in {
                    (
                      label: 'Cookies',
                      onTap: () {
                        Navigator.pop(context);
                        const GsaWidgetOverlayConsent().openDialog(context);
                      },
                    ),
                    if (GsaDataMerchant.instance.merchant != null)
                      (
                        label: 'Contact',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, 'contact');
                        },
                      ),
                    if (GsaConfig.plugin.documentUrls?.helpAndFaq != null)
                      (
                        label: 'Help & FAQ',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, 'help');
                        },
                      ),
                    (
                      label: 'Settings',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, 'settings');
                      },
                    ),
                    (
                      label: 'Licences',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, 'licences');
                      },
                    ),
                    if (GsaConfig.plugin.documentUrls?.termsAndConditions != null)
                      (
                        label: 'Terms and Conditions',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, 'privacy-policy');
                        },
                      ),
                    if (GsaConfig.plugin.documentUrls?.privacyPolicy != null)
                      (
                        label: 'Privacy Policy',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, 'privacy-policy');
                        },
                      ),
                  })
                    TextButton(
                      child: GsaWidgetText(
                        action.label,
                        style: const TextStyle(
                          decorationColor: Colors.grey,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: action.onTap,
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 16, 14, 0),
                    child: GsaWidgetText.rich(
                      [
                        const GsaWidgetTextSpan(
                          'Version ',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        GsaWidgetTextSpan(
                          GsaConfig.version,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
