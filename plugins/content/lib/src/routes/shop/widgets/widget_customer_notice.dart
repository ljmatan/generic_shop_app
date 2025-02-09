part of '../route_shop.dart';

class _WidgetCustomerNotice extends StatefulWidget {
  const _WidgetCustomerNotice();

  @override
  State<_WidgetCustomerNotice> createState() => _WidgetCustomerNoticeState();
}

class _WidgetCustomerNoticeState extends State<_WidgetCustomerNotice> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GsaWidgetHeadline('Customer Notice'),
          const SizedBox(height: 6),
          const GsaWidgetText(
            'The information provided on this application is for informational purposes only. '
            'While we strive to ensure the accuracy and reliability of the presented data, '
            'we cannot guarantee its completeness or suitability for any specific purpose.\n\n'
            'All listings on this app belong to third-party providers, and transactions are handled exclusively by them.',
            textAlign: TextAlign.justify,
            style: TextStyle(
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
            if (GsaConfig.provider.documentUrls.termsAndConditions != null)
              (
                label: 'Terms and Conditions',
                urlPath: 'terms-and-conditions',
                url: GsaConfig.provider.documentUrls.termsAndConditions!,
              ),
            if (GsaConfig.provider.documentUrls.privacyPolicy != null)
              (
                label: 'Privacy Policy',
                urlPath: 'privacy-policy',
                url: GsaConfig.provider.documentUrls.privacyPolicy!,
              ),
            if (GsaConfig.provider.documentUrls.cookieNotice != null)
              (
                label: 'Cookie Policy',
                urlPath: 'cookie-policy',
                url: GsaConfig.provider.documentUrls.cookieNotice!,
              ),
            if (GsaConfig.provider.documentUrls.helpAndFaq != null)
              (
                label: 'Help and FAQ',
                urlPath: 'help-and-faq',
                url: GsaConfig.provider.documentUrls.helpAndFaq!,
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
      ),
    );
  }
}
