part of '../route_shop.dart';

class _WidgetBanner extends StatefulWidget {
  const _WidgetBanner();

  @override
  State<_WidgetBanner> createState() => _WidgetBannerState();
}

class _WidgetBannerState extends State<_WidgetBanner> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color.lerp(Theme.of(context).primaryColor, Colors.white, .5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: GsaWidgetText.rich(
              [
                GsaWidgetTextSpan(
                  'Login',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                  ),
                  onTap: () {
                    GsaRouteLogin().push();
                  },
                ),
                const GsaWidgetTextSpan(
                  ' or ',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                GsaWidgetTextSpan(
                  'Register',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                  ),
                  onTap: () {
                    GsaRouteRegister().push();
                  },
                ),
                const GsaWidgetTextSpan(
                  ' to Receive Special Offers and Promotions.',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        GsaRouteAuth().push();
      },
    );
  }
}
