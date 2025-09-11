part of '../widget_blobs.dart';

class _WidgetBlobBackground extends StatefulWidget {
  const _WidgetBlobBackground({
    required this.color,
    required this.count,
    required this.centerOverlay,
  });

  final Color? color;

  final int count;

  final bool centerOverlay;

  @override
  State<_WidgetBlobBackground> createState() => _WidgetBlobBackgroundState();
}

class _WidgetBlobBackgroundState extends State<_WidgetBlobBackground> {
  Color? _specifiedColor;

  List<Color>? _blobColors;

  int? _pointCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        widget.count,
        (i) {
          final random = dart_math.Random(i);

          final blobSize = MediaQuery.of(context).size.width < MediaQuery.of(context).size.height
              ? MediaQuery.of(context).size.height
              : MediaQuery.of(context).size.width;

          final specifiedColor = widget.color ?? Theme.of(context).primaryColor;

          if (_specifiedColor == null || _specifiedColor!.toARGB32() != specifiedColor.toARGB32()) {
            _specifiedColor = specifiedColor;
            _blobColors = List.generate(
              widget.count,
              (_) {
                final hueVariation = 5;
                final minLightness = .3;
                final maxLightness = .8;
                final hueOffset = random.nextDouble() * hueVariation * (random.nextBool() ? 1 : -1);
                final newHue = (HSLColor.fromColor(
                          _specifiedColor!,
                        ).hue +
                        hueOffset) %
                    360;
                final lightness = minLightness + random.nextDouble() * (maxLightness - minLightness);
                final saturation = .3 + random.nextDouble() * .7;
                return HSLColor.fromAHSL(1, newHue, saturation, lightness).toColor().withValues(
                      alpha: .2 + random.nextDouble() * 0.3,
                    );
              },
            );
          }

          _pointCount ??= widget.count + random.nextInt(8);

          if (widget.centerOverlay) {
            double top, left;
            switch (i % 8) {
              case 0: // top-left corner
                top = -blobSize / 2;
                left = -blobSize / 2;
                break;
              case 1: // top edge (random left)
                top = -blobSize / 2;
                left = random.nextDouble() * (MediaQuery.of(context).size.width - blobSize);
                break;
              case 2: // top-right corner
                top = -blobSize / 2;
                left = MediaQuery.of(context).size.width - blobSize / 2;
                break;
              case 3: // right edge (random top)
                top = random.nextDouble() * (MediaQuery.of(context).size.height - blobSize);
                left = MediaQuery.of(context).size.width - blobSize / 2;
                break;
              case 4: // bottom-right corner
                top = MediaQuery.of(context).size.height - blobSize / 2;
                left = MediaQuery.of(context).size.width - blobSize / 2;
                break;
              case 5: // bottom edge (random left)
                top = MediaQuery.of(context).size.height - blobSize / 2;
                left = random.nextDouble() * (MediaQuery.of(context).size.width - blobSize);
                break;
              case 6: // bottom-left corner
                top = MediaQuery.of(context).size.height - blobSize / 2;
                left = -blobSize / 2;
                break;
              case 7: // left edge (random top)
                top = random.nextDouble() * (MediaQuery.of(context).size.height - blobSize);
                left = -blobSize / 2;
                break;
              default:
                top = 0;
                left = 0;
            }

            return Positioned(
              top: top,
              left: left,
              child: SizedBox(
                width: blobSize,
                height: blobSize,
                child: _WidgetAnimatedBlob(
                  color: _blobColors![i % _blobColors!.length],
                  pointCount: _pointCount!,
                  baseRadius: blobSize / 2.4,
                  duration: Duration(
                    seconds: 6 + random.nextInt(10),
                  ),
                ),
              ),
            );
          } else {
            final blobSize = (MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
                    ? MediaQuery.of(context).size.height
                    : MediaQuery.of(context).size.width) +
                random.nextDouble() * 200;

            final top = random.nextDouble() * MediaQuery.of(context).size.height - blobSize / 2;
            final left = random.nextDouble() * MediaQuery.of(context).size.width - blobSize / 2;

            return Positioned(
              top: top,
              left: left,
              child: SizedBox(
                width: blobSize,
                height: blobSize,
                child: _WidgetAnimatedBlob(
                  color: _blobColors![i % _blobColors!.length],
                  pointCount: _pointCount!,
                  baseRadius: blobSize / 2.1,
                  duration: Duration(
                    seconds: 6 + random.nextInt(10),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
