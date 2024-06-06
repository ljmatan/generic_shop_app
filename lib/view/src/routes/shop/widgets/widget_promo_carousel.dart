part of '../route_shop.dart';

class _WidgetPromoCarousel extends StatefulWidget {
  const _WidgetPromoCarousel();

  @override
  State<_WidgetPromoCarousel> createState() => __WidgetPromoCarouselState();
}

class __WidgetPromoCarouselState extends State<_WidgetPromoCarousel> {
  final _carouselItemUrls = const <String>{
    'https://pbs.twimg.com/media/F8xUybwXIAA-pQ-?format=jpg',
    'https://www.zenskirecenziraj.com/data/public/2023-04/herbalife-zenskirecenziraj-iskustva.png',
    'https://www.futurefit.co.uk/wp-content/uploads/2023/03/herbalife-review-future-fit.jpeg',
    'https://media.zenfs.com/en/prnewswire.com/a9f40e0e5c3738ada0194b6e5eb98029',
  };

  final _carouselItems = [];

  Future<void> _getCarouselData() async {
    await Future.wait([]);
  }

  int _carouselItemIndex = 0;

  late Timer _fadeTimer;

  @override
  void initState() {
    super.initState();
    _fadeTimer = Timer.periodic(
      const Duration(seconds: 4),
      (_) {
        setState(() {
          if (_carouselItemIndex + 1 == _carouselItemUrls.length) {
            _carouselItemIndex = 0;
          } else {
            _carouselItemIndex++;
          }
        });
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
                for (final carouselItemUrl in _carouselItemUrls.indexed)
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeIn,
                    opacity: carouselItemUrl.$1 == _carouselItemIndex ? 1 : 0,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            GsaWidgetImage.network(
                              carouselItemUrl.$2,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fitWidth,
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.info_rounded,
                                  color: Colors.white,
                                ),
                                onPressed: () async {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
