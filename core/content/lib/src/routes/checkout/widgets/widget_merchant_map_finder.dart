part of '../route_checkout.dart';

class _WidgetMerchantMapFinder extends StatefulWidget {
  const _WidgetMerchantMapFinder({
    required this.notice,
    required this.goToNextStep,
  });

  final GsaModelTranslated? notice;

  final Function goToNextStep;

  @override
  State<_WidgetMerchantMapFinder> createState() => _WidgetMerchantMapFinderState();
}

class _WidgetMerchantMapFinderState extends State<_WidgetMerchantMapFinder> {
  final _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future(() {}),
      builder: (context, snapshot) {
        return Stack(
          children: [
            Column(
              children: [
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Column(
                      children: [
                        GsaWidgetTextField(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).primaryColor,
                          ),
                          hintText: 'Search for a location',
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      FlutterMap(
                        mapController: _mapController,
                        options: const MapOptions(
                          initialCenter: LatLng(45.8150, 15.9819),
                          initialZoom: 12,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://c.tile.thunderforest.com/transport/{z}/{x}/{y}.png?apikey=6e5478c8a4f54c779f85573c0e399391',
                            userAgentPackageName: 'ljub.as.generic.shop.app',
                          ),
                          MarkerLayer(
                            markers: List.generate(20, (index) => GsaModelMerchant.mock())
                                .map(
                                  (merchant) => Marker(
                                    point: LatLng(merchant.address?.latitude ?? 0, merchant.address?.longitude ?? 0),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        const DecoratedBox(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white38,
                                                blurRadius: 15,
                                                spreadRadius: 3,
                                              ),
                                            ],
                                          ),
                                          child: SizedBox(width: 80, height: 80),
                                        ),
                                        InkWell(
                                          borderRadius: BorderRadius.circular(10),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: Padding(
                                                padding: const EdgeInsets.all(4),
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: SizedBox(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: MediaQuery.of(context).size.height,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            _mapController.move(
                                              LatLng(merchant.address?.latitude ?? 0, merchant.address?.longitude ?? 0),
                                              _mapController.camera.zoom,
                                            );
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) {
                                                return Padding(
                                                  padding: const EdgeInsets.fromLTRB(20, 26, 20, 12),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          if (merchant.logoImageSmallUrl != null || merchant.logoImageUrl != null)
                                                            Padding(
                                                              padding: const EdgeInsets.only(right: 10),
                                                              child: CircleAvatar(
                                                                radius: 25,
                                                                foregroundImage: NetworkImage(
                                                                  <String>{
                                                                    'https://d2studios.net/wp-content/uploads/blog/2015/01/Professional-Portrait-of-a-Ruggedly-Handsome-CEO.jpg',
                                                                    'https://image14.photobiz.com/10164/3_20180601100153_22858585_large.jpg',
                                                                    'https://amelieclements.com/wp-content/uploads/2022/02/business-portrait-woman-photographer-zurich-professional-headshot-amelie-clements-corporate-photoshoot-portfolio-apercu.jpg',
                                                                    'https://static1.squarespace.com/static/5af4da35a2772cc078f7e05b/60df488dd265c20054e76732/60df488de63d186be345059c/1625245859624/001_+Tara_LYCP0001_1.jpg?format=1500w',
                                                                  }.elementAt(Random().nextInt(4)),
                                                                  // TODO: FIX
                                                                  // merchant.logoImageSmallUrl ?? merchant.logoImageUrl!,
                                                                ),
                                                              ),
                                                            ),
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      GsaWidgetText(
                                                                        'Ime Prezime', // TODO: FIX merchant.name ?? 'N/A',
                                                                        style: const TextStyle(
                                                                          fontWeight: FontWeight.w700,
                                                                          fontSize: 16,
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          GsaWidgetText(
                                                                            '5.0',
                                                                            style: TextStyle(
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                          Icon(
                                                                            Icons.star,
                                                                            size: 12,
                                                                            color: Colors.amber,
                                                                          ),
                                                                          GsaWidgetText(
                                                                            ' (968)',
                                                                            style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 12,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      GsaWidgetText(
                                                                        'Supervisor Level 5',
                                                                        style: TextStyle(
                                                                          fontSize: 10,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                  icon: Transform.flip(
                                                                    flipX: true,
                                                                    child: Icon(
                                                                      Icons.call_outlined,
                                                                      color: Theme.of(context).primaryColor,
                                                                    ),
                                                                  ),
                                                                  onPressed: merchant.contact?.phoneNumber != null
                                                                      ? () async {
                                                                          await GsaServiceUrlLauncher.instance.launchCall(
                                                                            (merchant.contact?.phoneCountryCode != null
                                                                                    ? '+${merchant.contact!.phoneCountryCode}'
                                                                                    : '') +
                                                                                '${merchant.contact!.phoneNumber}',
                                                                          );
                                                                        }
                                                                      : null,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 10),
                                                      GsaWidgetText(
                                                        'A Herbalife Independent Distributor is someone who sells Herbalife '
                                                        'nutrition products like shakes and supplements directly to customers. '
                                                        'Independent Herbalife Distributors are not employed by Herbalife.',
                                                        style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 10),
                                                      SizedBox(
                                                        width: MediaQuery.of(context).size.width,
                                                        child: FilledButton(
                                                          child: GsaWidgetText(
                                                            'SELECT',
                                                            style: const TextStyle(
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                            widget.goToNextStep();
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(context).padding.bottom,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                      if (widget.notice != null)
                        Positioned(
                          left: 12,
                          top: 12,
                          right: 12,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: GsaWidgetText(
                                widget.notice!.intl(),
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
              ],
            ),
          ],
        );
      },
    );
  }
}
