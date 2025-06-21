part of '../route_shop.dart';

class _WidgetPromoCarousel extends StatefulWidget {
  const _WidgetPromoCarousel();

  @override
  State<_WidgetPromoCarousel> createState() => _WidgetPromoCarouselState();
}

class _WidgetPromoCarouselState extends State<_WidgetPromoCarousel> {
  late Future<List<GsaModelPromoBanner>> _getBannersFuture;

  final _carouselItems = <GsaModelPromoBanner>[];

  int _carouselItemIndex = 0;

  late Timer _fadeTimer;

  @override
  void initState() {
    super.initState();
    _getBannersFuture = Future<List<GsaModelPromoBanner>>(
      () async {
        if (GsaConfig.plugin.getPromoBanners == null) {
          throw UnimplementedError(
            'Promo carousel content endpoint not implemented for ${GsaConfig.plugin.id}.',
          );
        } else {
          return GsaConfig.plugin.getPromoBanners!();
        }
      },
    ).then(
      (value) {
        _carouselItems.addAll(value);
        return value;
      },
    );
    _fadeTimer = Timer.periodic(
      const Duration(seconds: 4),
      (_) {
        if (_carouselItems.isNotEmpty) {
          setState(
            () {
              if (_carouselItemIndex + 1 == _carouselItems.length) {
                _carouselItemIndex = 0;
              } else {
                _carouselItemIndex++;
              }
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeIn,
      child: FutureBuilder(
        future: _getBannersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done || snapshot.hasError) {
            if (snapshot.hasError) {
              debugPrint('${snapshot.error}');
            }
            return const SizedBox();
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Stack(
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
                                  if (carouselItemUrl.$2.photoUrl != null)
                                    GsaWidgetImage.network(
                                      carouselItemUrl.$2.photoUrl!,
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      fit: BoxFit.cover,
                                    ),
                                  if (carouselItemUrl.$2.contentUrl != null)
                                    const Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Icon(
                                        Icons.info_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  if (carouselItemUrl.$2.label != null || carouselItemUrl.$2.description != null)
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
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (carouselItemUrl.$2.label != null)
                                                GsaWidgetText(
                                                  carouselItemUrl.$2.label!,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              if (carouselItemUrl.$2.description != null) ...[
                                                if (carouselItemUrl.$2.label != null) const SizedBox(height: 4),
                                                GsaWidgetText(
                                                  carouselItemUrl.$2.description!,
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                ),
                                              ],
                                            ],
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
                      onTap: carouselItemUrl.$2.contentUrl != null
                          ? () {
                              GsaRouteWebView(
                                url: carouselItemUrl.$2.contentUrl!,
                                urlPath: Uri.parse(carouselItemUrl.$2.contentUrl!).path,
                                title: carouselItemUrl.$2.label ?? 'Reading',
                              ).push();
                            }
                          : null,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _fadeTimer.cancel();
    super.dispose();
  }
}
