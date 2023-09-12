import 'user_model.dart';
import 'latest_asses_model.dart';

class ApiResponse {
  final PatientDetails patientDetails;
  final LatestAssessment latestAssessment;

  ApiResponse({
    required this.patientDetails,
    required this.latestAssessment,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      patientDetails: PatientDetails.fromJson(json['patient_details']),
      latestAssessment: LatestAssessment.fromJson(json['latest_assessment']),
    );
  }
}
