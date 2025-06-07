part of '../../route_onboarding.dart';

class _ElementInputGoals extends StatefulWidget {
  const _ElementInputGoals(
    this.trainee, {
    required this.onGoalSpecified,
  });

  final GftModelTrainee trainee;

  final Function() onGoalSpecified;

  @override
  State<_ElementInputGoals> createState() => __ElementInputGoalsState();
}

class __ElementInputGoalsState extends State<_ElementInputGoals> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ElementHeader(
          'Set a primary focus to personalize your fitness plan',
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            children: [
              Text(
                'Everyone\'s goals are different. '
                'Tell us yours so we can tailor workouts, nutrition tips, and progress tracking to fit your journey.',
              ),
              const SizedBox(height: 16),
              Text(
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
                                  child: Text(
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
                            Text(
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
