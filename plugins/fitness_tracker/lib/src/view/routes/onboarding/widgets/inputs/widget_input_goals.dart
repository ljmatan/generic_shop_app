part of '../../route_onboarding.dart';

class _WidgetInputGoals extends StatefulWidget {
  const _WidgetInputGoals(
    this.trainee, {
    required this.onGoalSpecified,
  });

  final GftModelTrainee trainee;

  final Function() onGoalSpecified;

  @override
  State<_WidgetInputGoals> createState() => _WidgetInputGoalsState();
}

class _WidgetInputGoalsState extends State<_WidgetInputGoals> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const GsaWidgetAppBar(
          label: 'Set a primary focus to personalize your fitness plan',
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            children: [
              GsaWidgetText(
                'Everyone\'s goals are different. '
                'Tell us yours so we can tailor workouts, nutrition tips, and progress tracking to fit your journey.',
              ),
              const SizedBox(height: 16),
              GsaWidgetText(
                'Choose your preference below to proceed.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 6),
              for (final goalOption in GftModelTraineeGoal.values) ...[
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                    child: Card(
                      color: widget.trainee.goal == goalOption ? Theme.of(context).colorScheme.primary : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: widget.trainee.goal == goalOption ? Colors.white : Colors.grey,
                                  size: 21,
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: GsaWidgetText(
                                    goalOption.label,
                                    style: TextStyle(
                                      color: widget.trainee.goal == goalOption ? Colors.white : Theme.of(context).primaryColor,
                                      fontWeight: widget.trainee.goal == goalOption ? FontWeight.w900 : FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            GsaWidgetText(
                              goalOption.description,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: widget.trainee.goal == goalOption ? Colors.white : null,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      widget.trainee.goal = goalOption;
                      widget.onGoalSpecified();
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
