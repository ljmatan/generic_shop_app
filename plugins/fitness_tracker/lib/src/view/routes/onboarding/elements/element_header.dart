part of '../route_onboarding.dart';

class _ElementHeader extends StatelessWidget {
  const _ElementHeader(
    this.label,
  );

  final String label;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Stack(
          children: [
            const GsaWidgetFlairBlobBackground(count: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).padding.top + 14,
                    ),
                    Text(
                      label,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        shadows: [
                          for (final offset in <Offset>{
                            Offset(-.1, -.1),
                            Offset(.1, -.1),
                            Offset(.1, .1),
                            Offset(-.1, .1),
                          })
                            Shadow(
                              offset: offset,
                              color: Colors.black,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
