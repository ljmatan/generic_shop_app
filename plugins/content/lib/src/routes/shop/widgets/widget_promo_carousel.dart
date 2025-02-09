part of '../route_shop.dart';

class _WidgetPromoCarousel extends StatefulWidget {
  const _WidgetPromoCarousel();

  @override
  State<_WidgetPromoCarousel> createState() => __WidgetPromoCarouselState();
}

class __WidgetPromoCarouselState extends State<_WidgetPromoCarousel> {
  final _carouselItemUrls = const <String>{
    'https://www.froddo.com/media/nova-kolekcija-blog-aw24.jpg',
    'https://www.froddo.com/demo-2/img/ivancicadd.jpg',
    'https://www.froddo.com/demo-2/img/7X-OKO-ZEMLJE.webp',
    'https://www.froddo.com/demo-2/img/8d65e5d8e8a6f49319eb17ee76950cbb.jpg',
    'https://www.froddo.com/demo-2/img/6df54f473a3b30c1a45feee9f30ac2be.jpg',
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
