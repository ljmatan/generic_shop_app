enum GftModelTraineeGoal {
  loseWeight,
  gainWeight,
  improveFitness,
  eatHealthier,
  buildMuscle;

  String get label {
    switch (this) {
      case GftModelTraineeGoal.loseWeight:
        return 'Lose Weight';
      case GftModelTraineeGoal.gainWeight:
        return 'Gain Weight';
      case GftModelTraineeGoal.improveFitness:
        return 'Get Fit / Improve Fitness';
      case GftModelTraineeGoal.eatHealthier:
        return 'Eat Healthier';
      case GftModelTraineeGoal.buildMuscle:
        return 'Build Muscle';
    }
  }

  String get description {
    switch (this) {
      case GftModelTraineeGoal.loseWeight:
        return 'We calculate a calorie deficit and recommend workouts '
            'optimized for fat burning.';
      case GftModelTraineeGoal.gainWeight:
        return 'We increase your daily calorie goals and suggest routines '
            'that promote healthy weight and muscle mass gain.';
      case GftModelTraineeGoal.improveFitness:
        return 'We guide you through a balanced routine of cardio, '
            'strength, and flexibility training, helping you improve '
            'endurance and stamina at your pace.';
      case GftModelTraineeGoal.eatHealthier:
        return 'We help you track meals, learn about balanced '
            'nutrition, and build sustainable eating habits.';
      case GftModelTraineeGoal.buildMuscle:
        return 'We create plans that focus on progressive '
            'resistance training, protein intake, and recovery.';
    }
  }
}

enum GftModelTraineeGender {
  male,
  female,
  unknown;

  String get label {
    switch (this) {
      case GftModelTraineeGender.male:
        return 'Male';
      case GftModelTraineeGender.female:
        return 'Female';
      case GftModelTraineeGender.unknown:
        return 'Prefer not to say';
    }
  }
}

class GftModelTrainee {
  GftModelTrainee({
    required this.goal,
    required this.gender,
    required this.birthYear,
    required this.heightCentimeters,
    required this.weightKilograms,
  });

  GftModelTraineeGoal? goal;

  GftModelTraineeGender? gender;

  int? birthYear;

  int? get ageYears {
    if (birthYear == null) return null;
    return DateTime.now().year - birthYear!;
  }

  int? heightCentimeters;

  String? get heightLabelMetric {
    if (heightCentimeters == null) return null;
    return '${heightCentimeters}cm';
  }

  int? get heightFeet {
    if (heightCentimeters == null) return null;
    double totalInches = heightCentimeters! / 2.54;
    return totalInches ~/ 12;
  }

  int? get heightInchesRemainder {
    if (heightCentimeters == null) return null;
    double totalInches = heightCentimeters! / 2.54;
    return (totalInches % 12).round();
  }

  String? get heightLabelImperial {
    if (heightFeet == null || heightInchesRemainder == null) return null;
    return '${heightFeet}ft ${heightInchesRemainder}in';
  }

  int? weightKilograms;

  String? get weightLabelMetric {
    if (weightKilograms == null) return null;
    return '${weightKilograms}kg';
  }

  double? get weightPounds {
    if (weightKilograms == null) return null;
    return double.parse((weightKilograms! * 2.20462).toStringAsFixed(1));
  }

  String? get weightLabelImperial {
    if (weightPounds == null) return null;
    return '${weightPounds}lbs';
  }

  void ensureDataExists() {
    if (goal == null) {
      throw Exception(
        'No goal information provided.',
      );
    }
    if (gender == null) {
      throw Exception(
        'No gender information provided.',
      );
    }
    if (birthYear == null) {
      throw Exception(
        'No age information provided.',
      );
    }
    if (heightCentimeters == null) {
      throw Exception(
        'No height information provided.',
      );
    }
    if (weightKilograms == null) {
      throw Exception(
        'No weight information provided.',
      );
    }
  }
}
