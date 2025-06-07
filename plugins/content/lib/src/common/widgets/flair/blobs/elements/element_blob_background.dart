part of '../widget_blobs.dart';

class _ElementBlobBackground extends StatelessWidget {
  const _ElementBlobBackground({
    required this.color,
    required this.count,
    required this.centerOverlay,
  });

  final Color? color;

  final int count;

  final bool centerOverlay;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        count,
        (i) {
          final blobSize = MediaQuery.of(context).size.width < MediaQuery.of(context).size.height
              ? MediaQuery.of(context).size.height
              : MediaQuery.of(context).size.width;

          final rand = dart_math.Random(i);

          final hueVariation = 5;
          final minLightness = 0.3;
          final maxLightness = 0.8;

          final blobColors = List.generate(count, (i) {
            final hueOffset = rand.nextDouble() * hueVariation * (rand.nextBool() ? 1 : -1);
            final newHue = (HSLColor.fromColor(
                      color ?? Theme.of(context).primaryColor,
                    ).hue +
                    hueOffset) %
                360;

            final lightness = minLightness + rand.nextDouble() * (maxLightness - minLightness);
            final saturation = 0.3 + rand.nextDouble() * 0.7;
            return HSLColor.fromAHSL(1.0, newHue, saturation, lightness).toColor();
          })
            ..shuffle();

          if (centerOverlay) {
            double top, left;
            switch (i % 8) {
              case 0: // top-left corner
                top = -blobSize / 2;
                left = -blobSize / 2;
                break;
              case 1: // top edge (random left)
                top = -blobSize / 2;
                left = rand.nextDouble() * (MediaQuery.of(context).size.width - blobSize);
                break;
              case 2: // top-right corner
                top = -blobSize / 2;
                left = MediaQuery.of(context).size.width - blobSize / 2;
                break;
              case 3: // right edge (random top)
                top = rand.nextDouble() * (MediaQuery.of(context).size.height - blobSize);
                left = MediaQuery.of(context).size.width - blobSize / 2;
                break;
              case 4: // bottom-right corner
                top = MediaQuery.of(context).size.height - blobSize / 2;
                left = MediaQuery.of(context).size.width - blobSize / 2;
                break;
              case 5: // bottom edge (random left)
                top = MediaQuery.of(context).size.height - blobSize / 2;
                left = rand.nextDouble() * (MediaQuery.of(context).size.width - blobSize);
                break;
              case 6: // bottom-left corner
                top = MediaQuery.of(context).size.height - blobSize / 2;
                left = -blobSize / 2;
                break;
              case 7: // left edge (random top)
                top = rand.nextDouble() * (MediaQuery.of(context).size.height - blobSize);
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
                child: _ElementAnimatedBlob(
                  color: blobColors[i % blobColors.length].withOpacity(
                    0.25 + rand.nextDouble() * 0.3,
                  ),
                  pointCount: 16 + rand.nextInt(8),
                  baseRadius: blobSize / 2.4,
                  duration: Duration(
                    seconds: 6 + rand.nextInt(10),
                  ),
                ),
              ),
            );
          } else {
            final blobSize = (MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
                    ? MediaQuery.of(context).size.height
                    : MediaQuery.of(context).size.width) +
                rand.nextDouble() * 200;

            final top = rand.nextDouble() * MediaQuery.of(context).size.height - blobSize / 2;
            final left = rand.nextDouble() * MediaQuery.of(context).size.width - blobSize / 2;

            final color = blobColors[i % blobColors.length].withOpacity(
              0.15 + rand.nextDouble() * 0.3,
            );

            return Positioned(
              top: top,
              left: left,
              child: SizedBox(
                width: blobSize,
                height: blobSize,
                child: _ElementAnimatedBlob(
                  color: color,
                  pointCount: 16 + rand.nextInt(6),
                  baseRadius: blobSize / 2.1,
                  duration: Duration(
                    seconds: 6 + rand.nextInt(10),
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
