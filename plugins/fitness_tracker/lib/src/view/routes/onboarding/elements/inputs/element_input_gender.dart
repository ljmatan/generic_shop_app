part of '../../route_onboarding.dart';

class _ElementInputGender extends StatefulWidget {
  const _ElementInputGender(
    this.trainee, {
    required this.onGenderSpecified,
  });

  final GftModelTrainee trainee;

  final Function() onGenderSpecified;

  @override
  State<_ElementInputGender> createState() => __ElementInputGenderState();
}

class __ElementInputGenderState extends State<_ElementInputGender> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ElementHeader(
          'Personalize your journey based on your body type',
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            children: [
              Text(
                'Gender helps us estimate calorie needs, metabolism, and fitness benchmarks more accurately.',
              ),
              const SizedBox(height: 10),
              Text(
                'To make your plan truly yours, we use gender to tailor recommendations that match your physiology.',
              ),
              const SizedBox(height: 16),
              Text(
                'Select one of the below options to proceed.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 6),
              for (final genderOption in GftModelTraineeGender.values) ...[
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                    child: Card(
                      color: genderOption == widget.trainee.gender ? Theme.of(context).colorScheme.primary : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline_rounded,
                              color: genderOption == widget.trainee.gender ? Colors.white : Colors.grey,
                              size: 21,
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                genderOption.label,
                                style: TextStyle(
                                  color: genderOption == widget.trainee.gender ? Colors.white : Theme.of(context).primaryColor,
                                  fontWeight: genderOption == widget.trainee.gender ? FontWeight.w900 : FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      widget.trainee.gender = genderOption;
                      widget.onGenderSpecified();
                    },
                  ),
                ),
              ],
              const SizedBox(height: 20),
              for (final infoPoint in <({String title, String description})>{
                (
                  title: 'Why We Ask For This',
                  description:
                      'Your gender influences your body\'s metabolism, muscle composition, and recommended calorie intake. '
                      'By knowing this, we can provide more precise health and fitness guidance tailored to your physiology.',
                ),
                (
                  title: 'How This Data Helps You',
                  description:
                      'We use gender to improve the accuracy of your health insights, including calorie goals, workout suggestions, and progress tracking. '
                      'The result is a personalized plan that fits your unique needs.',
                ),
                (
                  title: 'Your Data, Your Control',
                  description:
                      'Providing gender helps us fine-tune your plan, but it\'s completely optional. '
                      'You can omit this information or update your choices later in settings. We never share or sell your data.',
                ),
                (
                  title: 'What Happens With This Info',
                  description:
                      'This data is stored securely and used only to personalize your experience. '
                      'It helps us adjust calculations for weight goals, workouts, and nutrition recommendations to better suit your body type.',
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
