part of '../route_shop.dart';

class _WidgetPromoCarousel extends StatefulWidget {
  const _WidgetPromoCarousel();

  @override
  State<_WidgetPromoCarousel> createState() => _WidgetPromoCarouselState();
}

class _WidgetPromoCarouselState extends State<_WidgetPromoCarousel> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive {
    return true;
  }

  late Future<
      Iterable<
          ({
            GsaModelPromoBanner banner,
            dart_typed_data.Uint8List? photoBytes,
          })>> _getBannersFuture;

  final _carouselItems = <({
    GsaModelPromoBanner banner,
    dart_typed_data.Uint8List? photoBytes,
  })>{};

  int _carouselItemIndex = 0;

  late dart_async.Timer _fadeTimer;

  @override
  void initState() {
    super.initState();
    _getBannersFuture = Future(
      () async {
        if (GsaPlugin.of(context).api?.getPromoBanners == null) {
          throw UnimplementedError(
            'Promo carousel content endpoint not implemented for ${GsaPlugin.of(context).id}.',
          );
        } else {
          final banners = await GsaPlugin.of(context).api!.getPromoBanners!();
          _carouselItems.addAll(
            [
              for (final banner in banners)
                (
                  banner: banner,
                  photoBytes: banner.photoBase64 == null
                      ? null
                      : dart_convert.base64Decode(
                          banner.photoBase64!,
                        ),
                ),
            ],
          );
          return _carouselItems;
        }
      },
    );
    _fadeTimer = dart_async.Timer.periodic(
      const Duration(seconds: 4),
      (_) {
        if (_carouselItems.length > 1) {
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
    super.build(context);
    if (GsaPlugin.of(context).api?.getPromoBanners == null) return const SizedBox();
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
                              borderRadius: GsaPlugin.of(context).theme.borderRadius,
                            ),
                            child: ClipRRect(
                              borderRadius: GsaPlugin.of(context).theme.borderRadius,
                              child: Stack(
                                children: [
                                  if (carouselItemUrl.$2.banner.photoUrl != null)
                                    GsaWidgetImage.network(
                                      carouselItemUrl.$2.banner.photoUrl!,
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      fit: BoxFit.cover,
                                    )
                                  else if (carouselItemUrl.$2.photoBytes != null)
                                    GsaWidgetImage.bytes(
                                      carouselItemUrl.$2.photoBytes!,
                                      type: GsaWidgetImageByteType.jpg,
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      fit: BoxFit.cover,
                                    ),
                                  if (carouselItemUrl.$2.banner.contentUrl != null)
                                    const Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Icon(
                                        Icons.info_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  if (carouselItemUrl.$2.banner.label != null || carouselItemUrl.$2.banner.description != null)
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          boxShadow: kElevationToShadow[16],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: GsaPlugin.of(context).theme.borderRadius.bottomLeft,
                                            bottomRight: GsaPlugin.of(context).theme.borderRadius.bottomRight,
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
                                              if (carouselItemUrl.$2.banner.label != null)
                                                GsaWidgetText(
                                                  carouselItemUrl.$2.banner.label!,
                                                ),
                                              if (carouselItemUrl.$2.banner.description != null) ...[
                                                if (carouselItemUrl.$2.banner.label != null) const SizedBox(height: 4),
                                                GsaWidgetText(
                                                  carouselItemUrl.$2.banner.description!,
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
                      onTap: carouselItemUrl.$2.banner.contentUrl != null
                          ? () {
                              GsaRouteWebView(
                                url: carouselItemUrl.$2.banner.contentUrl!,
                                urlPath: Uri.parse(carouselItemUrl.$2.banner.contentUrl!).path,
                                title: carouselItemUrl.$2.banner.label ?? 'Reading',
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
