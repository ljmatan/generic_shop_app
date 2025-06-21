part of '../../route_onboarding.dart';

class _WidgetInputHeight extends StatefulWidget {
  const _WidgetInputHeight(
    this.trainee, {
    required this.onHeightSpecified,
  });

  final GftModelTrainee trainee;

  final Function() onHeightSpecified;

  @override
  State<_WidgetInputHeight> createState() => _WidgetInputHeightState();
}

class _WidgetInputHeightState extends State<_WidgetInputHeight> {
  final _pickerController = FixedExtentScrollController(
    initialItem: 50,
  );

  @override
  Widget build(BuildContext context) {
    if (widget.trainee.heightCentimeters == null) {
      throw Exception(
        'Height value not provided.',
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const GsaWidgetAppBar(
          label: 'Adjust workout scaling based on your structure',
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            children: [
              Text(
                'Your height is a key factor in understanding your body composition. '
                'It\'s used to calculate your BMI (Body Mass Index), calorie needs, and '
                'tailor recommendations that better fit your physical profile.',
              ),
              const SizedBox(height: 16),
              Text(
                'Specify your height using the menu below.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Card(
                child: SizedBox(
                  height: 260,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${widget.trainee.heightLabelMetric}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              '${widget.trainee.heightLabelImperial}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 240,
                        width: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(26, (i) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: i % 5 == 0 ? 20 : 10,
                                height: 1,
                                color: Colors.black,
                              ),
                            );
                          }),
                        ),
                      ),
                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: 48,
                          diameterRatio: 10,
                          scrollController: _pickerController,
                          onSelectedItemChanged: (value) {
                            widget.trainee.heightCentimeters = value + 120;
                            widget.onHeightSpecified();
                          },
                          selectionOverlay: const SizedBox(),
                          children: [
                            for (final height in <int>{
                              for (int i = 120; i < 221; i++) i,
                            })
                              Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Text(
                                    '${height}cm',
                                    style: TextStyle(
                                      color: widget.trainee.heightCentimeters == height ? Theme.of(context).primaryColor : null,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              for (final infoPoint in <({String title, String description})>{
                (
                  title: 'Height Supports Key Health Calculations',
                  description: 'We use your height to assess your body metrics accurately, like BMI '
                      'and ideal weight range. This helps us make your plan more '
                      'personalized and safe.',
                ),
                (
                  title: 'Helps Align with Your Physical Goals',
                  description: 'By understanding your height, we can estimate ideal weight ranges '
                      'and better personalize your fitness or nutrition plan.',
                ),
                (
                  title: 'For a Plan That Fits You',
                  description: 'Your height helps us understand your body structure and tailor daily '
                      'calorie goals, workout intensity, and long-term progress benchmarks.',
                ),
                (
                  title: 'Used Only For Personalization',
                  description: 'Your height is stored securely and used strictly to improve your plan. '
                      'We never share your data and you can update it anytime.',
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
