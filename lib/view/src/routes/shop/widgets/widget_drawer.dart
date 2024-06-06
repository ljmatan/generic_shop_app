part of '../route_shop.dart';

class _WidgetDrawer extends StatefulWidget {
  const _WidgetDrawer();

  @override
  State<_WidgetDrawer> createState() => __WidgetDrawerState();
}

class __WidgetDrawerState extends State<_WidgetDrawer> {
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
                    Navigator.of(context).pushNamed(GsaDataUser.instance.authenticated ? 'profile' : 'auth');
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
                                  ? GsaaServiceI18NLanguage.values.indexOf(GsaConfig.language)
                                  : GsaaServiceCurrencyType.values.indexOf(GsaConfig.currency),
                              children: i == 0
                                  ? [
                                      for (final language in GsaaServiceI18NLanguage.values)
                                        (
                                          id: language.name,
                                          label: language.displayName,
                                          onTap: () {
                                            GsaRoute.rebuildAll();
                                            GsaConfig.languageNotifier.value = language;
                                          },
                                        ),
                                    ]
                                  : [
                                      for (final currency in GsaaServiceCurrencyType.values)
                                        (
                                          id: currency.name,
                                          label: currency.displayName,
                                          onTap: () {
                                            GsaRoute.rebuildAll();
                                            GsaConfig.currencyNotifier.value = currency;
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
                        GsaWidgetOverlayConsent.open(context);
                      },
                    ),
                    (
                      label: 'Contact',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, 'contact');
                      },
                    ),
                    (
                      label: 'Privacy Policy',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, 'privacy-policy');
                      },
                    ),
                    (
                      label: 'Help',
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
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Version ',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: GsaConfig.version,
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
      ),
    );
  }
}
