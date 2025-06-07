part of '../../route_onboarding.dart';

class _ElementInputsConfirmation extends StatefulWidget {
  const _ElementInputsConfirmation(
    this.trainee,
  );

  final GftModelTrainee trainee;

  @override
  State<_ElementInputsConfirmation> createState() => __ElementInputsConfirmationState();
}

class __ElementInputsConfirmationState extends State<_ElementInputsConfirmation> {
  @override
  Widget build(BuildContext context) {
    widget.trainee.ensureDataExists();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ElementHeader(
          'Your Fitness Starting Point',
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            children: [
              Text(
                'Below is the information you\'ve provided during the setup. '
                'We use this to generate your initial plan.',
              ),
              const SizedBox(height: 20),
              for (final input in <({String label, String data, String description})>{
                (
                  label: 'Goal',
                  data: widget.trainee.goal!.label,
                  description:
                      'Your selected fitness focus helps us shape your plan, '
                      'whether it\'s weight loss, muscle gain, or healthy habits.',
                ),
                (
                  label: 'Gender',
                  data: widget.trainee.gender!.label,
                  description:
                      'Used to estimate body composition and tailor exercise '
                      'and nutrition strategies to suit your physiology.',
                ),
                (
                  label: 'Age',
                  data: '${widget.trainee.ageYears} years',
                  description:
                      'Age affects metabolism, recovery, and training needs. '
                      'This helps personalize intensity and nutrition.',
                ),
                (
                  label: 'Height',
                  data: widget.trainee.heightLabelMetric!,
                  description:
                      'Essential for calculating your BMI, ideal weight ranges, '
                      'and customizing your calorie needs.',
                ),
                (
                  label: 'Weight',
                  data: widget.trainee.weightLabelMetric!,
                  description:
                      'Your current weight is used to measure progress, calculate '
                      'goals, and balance your meal and workout plans.',
                ),
              }.indexed) ...[
                if (input.$1 != 0) const SizedBox(height: 16),
                InkWell(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  input.$2.label,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Text(
                                'EDIT',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Divider(height: 0),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
                          child: Text(
                            input.$2.data.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    input.$2.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
              const SizedBox(height: 20),
              GsaWidgetTermsConfirmation(
                value: true,
                onValueChanged: (value) {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
