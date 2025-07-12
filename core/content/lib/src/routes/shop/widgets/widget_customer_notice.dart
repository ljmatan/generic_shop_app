part of '../route_shop.dart';

class _WidgetCustomerNotice extends StatefulWidget {
  const _WidgetCustomerNotice();

  @override
  State<_WidgetCustomerNotice> createState() => _WidgetCustomerNoticeState();
}

class _WidgetCustomerNoticeState extends State<_WidgetCustomerNotice> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const GsaWidgetHeadline('Customer Notice'),
        const SizedBox(height: 6),
        GsaWidgetText(
          'The information provided on this application is for informational purposes only. '
          'While we strive to ensure the accuracy and reliability of the presented data, '
          'we cannot guarantee its completeness or suitability for any specific purpose.\n\n'
          'All listings on this app belong to third-party providers, and transactions are handled exclusively by them.',
          textAlign: TextAlign.justify,
          style: const TextStyle(
            height: 1.7,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 14),
        for (final content in <({
          String label,
          String urlPath,
          String url,
        })>{
          if (GsaConfig.plugin.documentUrls?.termsAndConditions != null)
            (
              label: 'Terms and Conditions',
              urlPath: 'terms-and-conditions',
              url: GsaConfig.plugin.documentUrls!.termsAndConditions!,
            ),
          if (GsaConfig.plugin.documentUrls?.privacyPolicy != null)
            (
              label: 'Privacy Policy',
              urlPath: 'privacy-policy',
              url: GsaConfig.plugin.documentUrls!.privacyPolicy!,
            ),
          if (GsaConfig.plugin.documentUrls?.cookieNotice != null)
            (
              label: 'Cookie Policy',
              urlPath: 'cookie-policy',
              url: GsaConfig.plugin.documentUrls!.cookieNotice!,
            ),
          if (GsaConfig.plugin.documentUrls?.helpAndFaq != null)
            (
              label: 'Help and FAQ',
              urlPath: 'help-and-faq',
              url: GsaConfig.plugin.documentUrls!.helpAndFaq!,
            ),
        })
          InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: GsaWidgetText(
                  content.label,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => GsaRouteWebView(
                    url: content.url,
                    urlPath: content.urlPath,
                    title: content.label,
                  ),
                ),
              );
            },
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}
