class BmrCalculator {
  static double calculateBmr({
    required double age,
    required double height,
    required double weight,
    required bool isMale,
  }) {
    if (isMale) {
      return 88.36 + (13.4 * weight) + (4.8 * height) - (5.7 * age);
    } else {
      return 447.6 + (9.2 * weight) + (3.1 * height) - (4.3 * age);
    }
  }

  static Map<String, double> calculateCalories(double bmr) {
    return {
      'Sedentary: little or no exercise': bmr * 1.2,
      'Exercise 1–3 times/week': bmr * 1.375,
      'Exercise 4–5 times/week': bmr * 1.465,
      'Daily or intense 3–4 times/week': bmr * 1.55,
      'Intense 6–7 times/week': bmr * 1.725,
      'Very intense or physical job': bmr * 1.9,
    };
  }
}
