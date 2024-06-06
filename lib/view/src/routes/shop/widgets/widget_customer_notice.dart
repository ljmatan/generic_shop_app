part of '../route_shop.dart';

class _WidgetCustomerNotice extends StatefulWidget {
  const _WidgetCustomerNotice();

  @override
  State<_WidgetCustomerNotice> createState() => __WidgetCustomerNoticeState();
}

class __WidgetCustomerNoticeState extends State<_WidgetCustomerNotice> {
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
          for (final legalUrl in {
            (
              label: 'Terms and Conditions',
              onTap: () {},
            ),
            (
              label: 'Privacy Policy',
              onTap: () {},
            ),
            (
              label: 'Cookie Policy',
              onTap: () {},
            ),
            if (GsaDataUser.instance.authenticated)
              (
                label: 'Logout',
                onTap: () {},
              ),
          })
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: GsaWidgetText(
                    legalUrl.label,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              onTap: legalUrl.onTap,
            ),
          const SizedBox(height: 16),
          const GsaWidgetText(
            'Herbalife International Inc.',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const Divider(),
          const SizedBox(height: 8),
          const GsaWidgetText(
            'This app is developed by a third-party entity and is not directly affiliated with the Herbalife International.\n\n'
            'Reproduced with the permission of Herbalife International. All rights to the Herbalife name and logo and any trademarks '
            'or trade names of Herbalife, are the property of Herbalife International and its subsidiaries or associated companies.\n\n'
            'We extend our heartfelt support for the incredible work and community support Herbalife consistently provides.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              height: 1.7,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 20),
          const GsaWidgetText(
            'Independent Herbalife Distributors',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const Divider(),
          const SizedBox(height: 8),
          const GsaWidgetText(
            'Herbalife is a company that manufactures and sells weight-management and nutrition products. '
            'A Herbalife independent distributor is someone who sells Herbalife products directly to consumers.\n\n'
            'Independent distributors are not Herbalife employees, '
            'but rather independent contractors who purchase products from Herbalife and then resell them to customers.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              height: 1.7,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
