part of '../../route_onboarding.dart';

class _ElementInputAge extends StatefulWidget {
  const _ElementInputAge(
    this.trainee, {
    required this.onBirthYearSpecified,
  });

  final GftModelTrainee trainee;

  final Function() onBirthYearSpecified;

  @override
  State<_ElementInputAge> createState() => __ElementInputAgeState();
}

class __ElementInputAgeState extends State<_ElementInputAge> {
  final _pickerController = FixedExtentScrollController(
    initialItem: 60,
  );

  @override
  Widget build(BuildContext context) {
    if (widget.trainee.birthYear == null) {
      throw Exception(
        'Birth year value not provided.',
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ElementHeader(
          'Adjusting for your life stage',
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            children: [
              Text(
                'Your age plays a key role in determining your body\'s needs. '
                'It affects metabolism, recovery rate, and the type of guidance '
                'that works best for your fitness level.',
              ),
              const SizedBox(height: 16),
              Text(
                'Select your birth year from the menu below.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Card(
                child: SizedBox(
                  height: 260,
                  child: CupertinoPicker(
                    itemExtent: 48,
                    useMagnifier: true,
                    magnification: 1.2,
                    scrollController: _pickerController,
                    selectionOverlay: Card(
                      color: Colors.transparent,
                      margin: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                    ),
                    onSelectedItemChanged: (value) {
                      widget.trainee.birthYear = value + 1940;
                      widget.onBirthYearSpecified();
                    },
                    children: [
                      for (final year in <int>{
                        for (int i = 1940; i < 2008; i++) i,
                      })
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$year',
                              style: TextStyle(
                                color: widget.trainee.birthYear == year ? Theme.of(context).primaryColor : null,
                                fontWeight: widget.trainee.birthYear == year ? FontWeight.w700 : null,
                              ),
                            ),
                            if (widget.trainee.birthYear == year) ...[
                              const SizedBox(width: 8),
                              Text(
                                '${widget.trainee.ageYears} years old',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              for (final infoPoint in <({String title, String description})>{
                (
                  title: 'Your Age Affects Your Fitness Profile',
                  description:
                      'Age influences your metabolism, recovery speed, and optimal workout '
                      'intensity. Knowing your age helps us make smarter, safer '
                      'recommendations tailored to you.',
                ),
                (
                  title: 'Tailored For Every Life Stage',
                  description:
                      'Whether you\'re just starting out or maintaining lifelong wellness, '
                      'your age helps guide the type of nutrition, exercise, and recovery '
                      'support you need.',
                ),
                (
                  title: 'We Respect Your Data',
                  description:
                      'Your age helps improve accuracy but is stored securely and used only '
                      'for personalization. You can update it at any time.',
                ),
                (
                  title: 'Better Insights Through Age-Aware Planning',
                  description:
                      'Fitness and health change as you age. We use this information to '
                      'optimize everything from calorie calculations to rest cycles for '
                      'better results.',
                ),
              }.indexed) ...[
                if (infoPoint.$1 != 0) const SizedBox(height: 16),
                Text(
                  infoPoint.$2.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Divider(),
                Text(
                  infoPoint.$2.description,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pickerController.dispose();
    super.dispose();
  }
}
