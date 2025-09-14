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
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
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
                    if (GsaPlugin.of(context).features.authentication) ...[
                      InkWell(
                        child: Row(
                          children: [
                            const CircleAvatar(
                              child: Center(
                                child: Icon(Icons.person_2_outlined),
                              ),
                            ),
                            const SizedBox(width: 14),
                            GsaWidgetText.rich(
                              [
                                if (GsaDataUser.instance.user?.personalDetails?.formattedName != null)
                                  GsaWidgetTextSpan(
                                    GsaDataUser.instance.user!.personalDetails!.formattedName!,
                                    interpolated: true,
                                  ),
                                const GsaWidgetTextSpan(
                                  'Login',
                                ),
                              ],
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
                    ],
                    for (final dropdownMenuOption in <({
                      String label,
                      int initialSelectionIndex,
                      List<GsaWidgetDropdownEntry> dropdownEntries,
                    })>{
                      (
                        label: 'Language',
                        initialSelectionIndex: GsaServiceI18NLanguage.values.indexOf(GsaConfig.language),
                        dropdownEntries: [
                          for (final language in GsaServiceI18NLanguage.values)
                            GsaWidgetDropdownEntry(
                              id: language.name,
                              label: language.displayName,
                              onTap: () {
                                GsaConfig.languageNotifier.value = language;
                                context.routeState?.rebuildAllRoutes();
                              },
                            ),
                        ],
                      ),
                      (
                        label: 'Theme',
                        initialSelectionIndex: Theme.of(context).brightness == Brightness.light ? 0 : 1,
                        dropdownEntries: [
                          for (final themeOption in <({
                            String label,
                            Brightness value,
                          })>{
                            (
                              label: 'Light',
                              value: Brightness.light,
                            ),
                            (
                              label: 'Dark',
                              value: Brightness.dark,
                            ),
                          })
                            GsaWidgetDropdownEntry(
                              id: themeOption.label,
                              label: themeOption.label,
                              onTap: () async {
                                GsaPlugin.of(context).theme.brightness = themeOption.value;
                                context.findAncestorStateOfType<GsaState>()?.setState(() {});
                                try {
                                  await GsaServiceCacheEntry.themeBrightness.setValue(themeOption.value.name);
                                } catch (e) {
                                  GsaServiceLogging.instance.logGeneral(
                                    'Failed to cached theme brightness data:\n$e',
                                  );
                                }
                              },
                            ),
                        ],
                      ),
                      if (GsaPlugin.of(context).features.currencyConversion)
                        (
                          label: 'Currency',
                          initialSelectionIndex: GsaModelPriceCurrencyType.values.indexOf(
                            GsaConfig.currency,
                          ),
                          dropdownEntries: [
                            for (final currency in GsaModelPriceCurrencyType.values)
                              GsaWidgetDropdownEntry(
                                id: currency.name,
                                label: currency.displayName,
                                onTap: () {
                                  GsaConfig.currencyNotifier.value = currency;
                                  context.routeState?.rebuildAllRoutes();
                                },
                              ),
                          ],
                        ),
                    }) ...[
                      Row(
                        children: [
                          GsaWidgetText(
                            dropdownMenuOption.label,
                            style: const TextStyle(),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: GsaWidgetDropdownButton(
                                key: UniqueKey(),
                                initialSelectionIndex: dropdownMenuOption.initialSelectionIndex,
                                children: dropdownMenuOption.dropdownEntries,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: GsaTheme.of(context).dimensions.smallScreen ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                    children: [
                      for (final action in {
                        (
                          label: 'Cookies',
                          onTap: () {
                            Navigator.pop(context);
                            const GsaWidgetOverlayCookieConsent().openDialog();
                          },
                        ),
                        if (GsaDataMerchant.instance.merchant != null)
                          (
                            label: 'Contact',
                            onTap: () {
                              Navigator.pop(context);
                              const GsaRouteMerchantContact().push();
                            },
                          ),
                        if (GsaPlugin.of(context).documentUrls?.helpAndFaq != null)
                          (
                            label: 'Help & FAQ',
                            onTap: () {
                              Navigator.pop(context);
                              const GsaRouteHelp().push();
                            },
                          ),
                        (
                          label: 'Licences',
                          onTap: () {
                            Navigator.pop(context);
                            const GsaRouteLicences().push();
                          },
                        ),
                        if (GsaPlugin.of(context).documentUrls?.termsAndConditions != null)
                          (
                            label: 'Terms and Conditions',
                            onTap: () {
                              Navigator.pop(context);
                              GsaRouteLegalConsent.termsAndConditions(
                                url: GsaPlugin.of(context).documentUrls!.termsAndConditions!,
                              ).push();
                            },
                          ),
                        if (GsaPlugin.of(context).documentUrls?.privacyPolicy != null)
                          (
                            label: 'Privacy Policy',
                            onTap: () {
                              Navigator.pop(context);
                              GsaRouteLegalConsent.privacyPolicy(
                                url: GsaPlugin.of(context).documentUrls!.privacyPolicy!,
                              ).push();
                            },
                          ),
                        if (GsaPlugin.of(context).documentUrls?.cookieNotice != null)
                          (
                            label: 'Cookie Notice',
                            onTap: () {
                              Navigator.pop(context);
                              GsaRouteLegalConsent.cookieAgreement(
                                url: GsaPlugin.of(context).documentUrls!.cookieNotice!,
                              ).push();
                            },
                          ),
                      })
                        InkWell(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: GsaTheme.of(context).paddings.content.small,
                              ),
                              child: GsaWidgetText(
                                action.label,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          onTap: action.onTap,
                        ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: GsaTheme.of(context).paddings.content.regular,
                        ),
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
        ),
      ),
    );
  }
}
