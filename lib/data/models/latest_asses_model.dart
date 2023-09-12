import 'exercises_model.dart';

class LatestAssessment {
  final String diagnosis;
  final String dateOfAssessment;
  final List<Exercise> exercises;

  LatestAssessment({
    required this.diagnosis,
    required this.dateOfAssessment,
    required this.exercises,
  });

  factory LatestAssessment.fromJson(Map<String, dynamic> json) {
    var exerciseList = json['Exercise'] as List;
    List<Exercise> exercises = exerciseList
        .map((exerciseJson) => Exercise.fromJson(exerciseJson))
        .toList();

    return LatestAssessment(
      diagnosis: json['Diagnosis'],
      dateOfAssessment: json['DateOfAssessment'],
      exercises: exercises,
    );
  }
}
