import 'package:generic_shop_app_fitness_tracker/src/data/src/data_trainee.dart';
import 'package:generic_shop_app_fitness_tracker/src/view/routes/_routes.dart';
import 'package:generic_shop_app_content/gsac.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'widgets/inputs/widget_input_age.dart';
part 'widgets/inputs/widget_input_gender.dart';
part 'widgets/inputs/widget_input_goals.dart';
part 'widgets/inputs/widget_input_height.dart';
part 'widgets/inputs/widget_input_weight.dart';
part 'widgets/inputs/widget_inputs_confirmation.dart';

/// Collection of screen pages on which the users are presented with several data inputs
/// relating to their health and physique.
///
class GftRouteOnboarding extends GftRoute {
  /// Default, unnamed widget constructor.
  ///
  const GftRouteOnboarding({super.key});

  @override
  State<GftRouteOnboarding> createState() => _GftRouteOnboardingState();
}

class _GftRouteOnboardingState extends GsaRouteState<GftRouteOnboarding> {
  final _pageController = PageController();

  final _pageNotifier = ValueNotifier<int>(0);

  void _onPageUpdated() {
    final currentPage = _pageController.page?.round();
    if (currentPage != null && _pageNotifier.value != currentPage) {
      _pageNotifier.value = _pageController.page!.round();
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageUpdated);
  }

  /// Trainee information specified by user input.
  ///
  final _trainee = GftModelTrainee(
    goal: null,
    gender: null,
    birthYear: 2000,
    heightCentimeters: 170,
    weightKilograms: 70,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _WidgetInputGoals(
                  _trainee,
                  onGoalSpecified: () => setState(() {}),
                ),
                _WidgetInputGender(
                  _trainee,
                  onGenderSpecified: () => setState(() {}),
                ),
                _WidgetInputAge(
                  _trainee,
                  onBirthYearSpecified: () => setState(() {}),
                ),
                _WidgetInputHeight(
                  _trainee,
                  onHeightSpecified: () => setState(() {}),
                ),
                _WidgetInputWeight(
                  _trainee,
                  onWeightSpecified: () => setState(() {}),
                ),
                _WidgetInputsConfirmation(
                  _trainee,
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _pageNotifier,
            builder: (context, value, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(height: 0),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      10,
                      16,
                      16 + MediaQuery.of(context).padding.bottom,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FilledButton(
                        child: Text(
                          switch (value) {
                            0 || 1 || 2 || 3 || 4 => 'Next Step',
                            5 => 'Finish',
                            int() => throw UnimplementedError(
                                'Onboarding screen index $value not implemented.',
                              ),
                          },
                        ),
                        onPressed: switch (value) {
                          0 => _trainee.goal == null
                              ? null
                              : () {
                                  _pageController.animateToPage(
                                    1,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.ease,
                                  );
                                },
                          1 => _trainee.gender == null
                              ? null
                              : () {
                                  _pageController.animateToPage(
                                    2,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.ease,
                                  );
                                },
                          2 || 3 || 4 => () {
                              _pageController.animateToPage(
                                value + 1,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.ease,
                              );
                            },
                          5 => () {},
                          int() => throw UnimplementedError(
                              'Onboarding screen data handler index $value not implemented.',
                            ),
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageUpdated);
    _pageController.dispose();
    super.dispose();
  }
}
