part of '../route_shop.dart';

class _WidgetPromoCarousel extends StatefulWidget {
  const _WidgetPromoCarousel();

  @override
  State<_WidgetPromoCarousel> createState() => __WidgetPromoCarouselState();
}

class __WidgetPromoCarouselState extends State<_WidgetPromoCarousel> {
  final _carouselItems = <({
    String imageUrl,
    ({
      String? title,
      String url,
    })? linkedContent,
  })>[
    (
      imageUrl: 'https://www.froddo.com/demo-2/img/7X-OKO-ZEMLJE.webp',
      linkedContent: null,
    ),
    (
      imageUrl: 'https://www.froddo.com/demo-2/img/ee8addfa5aa6fae16399af560656b758.jpg',
      linkedContent: (
        title: 'Froddo Barefoot shoes',
        url: 'https://www.froddo.com/barefoot',
      ),
    ),
    (
      imageUrl: 'https://img.freepik.com/free-photo/girls-with-father_1098-15657.jpg',
      linkedContent: (
        title: 'Stress-Free Routines to Help Kids Thrive Throughout the Day',
        url: 'https://www.froddo.com/stress-free-routines-to-help-kids-thrive-throughout-the-day',
      ),
    ),
    (
      imageUrl: 'https://img.freepik.com/free-photo/flat-lay-nutritious-cute-children-s-menu_23-2149522900.jpg',
      linkedContent: (
        title: 'Lunch Box Magic: Creative & Healthy Ideas to Keep Your Child Excited for Lunchtime',
        url: 'https://www.froddo.com/lunch-box-magic-creative-healthy-ideas-to-keep-your-child-excited-for-lunchtime',
      ),
    ),
    (
      imageUrl: 'https://www.froddo.com/demo-2/img/ivancicadd.jpg',
      linkedContent: (
        title: 'Our Commitment to a Sustainable Future: Setting Science-Based Targets for Emission Reduction',
        url: 'https://www.froddo.com/our-commitment-to-a-sustainable-future-setting-science-based-targets-for-emission-reduction',
      ),
    ),
  ];

  int _carouselItemIndex = 0;

  late Timer _fadeTimer;

  @override
  void initState() {
    super.initState();
    _fadeTimer = Timer.periodic(
      const Duration(seconds: 4),
      (_) {
        setState(
          () {
            if (_carouselItemIndex + 1 == _carouselItems.length) {
              _carouselItemIndex = 0;
            } else {
              _carouselItemIndex++;
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: FutureBuilder(
          future: Future(() {}),
          builder: (context, carouselItems) {
            return Stack(
              children: [
                for (final carouselItemUrl in _carouselItems.indexed)
                  GestureDetector(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeIn,
                      opacity: carouselItemUrl.$1 == _carouselItemIndex ? 1 : 0,
                      child: Center(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            boxShadow: kElevationToShadow[1],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: [
                                GsaWidgetImage.network(
                                  carouselItemUrl.$2.imageUrl,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fitWidth,
                                ),
                                if (carouselItemUrl.$2.linkedContent?.url != null)
                                  const Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Icon(
                                      Icons.info_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                if (carouselItemUrl.$2.linkedContent?.title != null)
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        boxShadow: kElevationToShadow[16],
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        child: GsaWidgetText(
                                          carouselItemUrl.$2.linkedContent!.title!,
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: carouselItemUrl.$2.linkedContent?.url != null
                        ? () {
                            GsaRouteWebView(
                              url: carouselItemUrl.$2.linkedContent!.url,
                              urlPath: Uri.parse(carouselItemUrl.$2.linkedContent!.url).path,
                              title: carouselItemUrl.$2.linkedContent?.title ?? 'Reading',
                            ).push();
                          }
                        : null,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fadeTimer.cancel();
    super.dispose();
  }
}
