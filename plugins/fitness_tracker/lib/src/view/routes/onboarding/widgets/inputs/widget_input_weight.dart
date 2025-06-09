part of '../../route_onboarding.dart';

class _WidgetInputWeight extends StatefulWidget {
  const _WidgetInputWeight(
    this.trainee, {
    required this.onWeightSpecified,
  });

  final GftModelTrainee trainee;

  final Function() onWeightSpecified;

  @override
  State<_WidgetInputWeight> createState() => __WidgetInputWeightState();
}

class __WidgetInputWeightState extends State<_WidgetInputWeight> {
  @override
  Widget build(BuildContext context) {
    if (widget.trainee.weightKilograms == null) {
      throw Exception(
        'Weight value not provided.',
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const GsaWidgetAppBar(
          label: 'Record starting weight for progress tracking',
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            children: [
              Text(
                'Knowing your starting weight lets us measure your progress over '
                'time and calculate targets that match your goal - whether it\'s to '
                'lose, gain, or maintain weight.',
              ),
              const SizedBox(height: 16),
              Text(
                'Input your current weight data below.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton.filled(
                            icon: Icon(Icons.remove),
                            onPressed: widget.trainee.weightKilograms == 40
                                ? null
                                : () {
                                    final currentWeight = widget.trainee.weightKilograms!;
                                    final decrement = (currentWeight - 10 < 40) ? 1 : 10;
                                    widget.trainee.weightKilograms = currentWeight - decrement;
                                    widget.onWeightSpecified();
                                  },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                Text(
                                  '${widget.trainee.weightLabelMetric}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${widget.trainee.weightLabelImperial}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          IconButton.filled(
                            icon: Icon(Icons.add),
                            onPressed: widget.trainee.weightKilograms == 160
                                ? null
                                : () {
                                    final currentWeight = widget.trainee.weightKilograms!;
                                    final increment = (currentWeight + 10 > 160) ? 1 : 10;
                                    widget.trainee.weightKilograms = currentWeight + increment;
                                    widget.onWeightSpecified();
                                  },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Slider(
                        value: widget.trainee.weightKilograms!.toDouble(),
                        min: 40,
                        max: 160,
                        onChanged: (value) {
                          widget.trainee.weightKilograms = value.round();
                          widget.onWeightSpecified();
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              for (final infoPoint in <({String title, String description})>{
                (
                  title: 'A Smarter Health Plan',
                  description: 'Your weight affects calorie needs, metabolic rate, and '
                      'workout intensity. We use this info to tailor your fitness '
                      'and nutrition recommendations safely and effectively.',
                ),
                (
                  title: 'Private And Secure',
                  description: 'We use your weight only to personalize your experience. '
                      'It\'s stored securely, visible only to you, and can be '
                      'updated anytime.',
                ),
                (
                  title: 'How This Ties To Your Goal',
                  description: 'Your weight helps define the path toward your selected goal. '
                      'For example, a weight loss target will guide meal plans and '
                      'exercise routines optimized for fat burning.',
                ),
                (
                  title: 'Set A Target, Or Skip For Now',
                  description: 'Entering a target weight helps us shape your long-term plan. '
                      'Not ready? No problem—you can set or change your goal at any '
                      'time in settings.',
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
}
