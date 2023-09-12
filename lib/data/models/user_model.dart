class PatientDetails {
  final String patientId;
  final String patientName;
  final String patientAge;
  final String patientGender;
  final int patientHeight;
  final int patientWeight;
  final String patientContactNo;
  final String occupation;
  final String address;

  PatientDetails({
    required this.patientId,
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
    required this.patientHeight,
    required this.patientWeight,
    required this.patientContactNo,
    required this.occupation,
    required this.address,
  });

  factory PatientDetails.fromJson(Map<String, dynamic> json) {
    return PatientDetails(
      patientId: json['Patient_Id'],
      patientName: json['Patient_Name'],
      patientAge: json['Patient_Age'],
      patientGender: json['Patient_Gender'],
      patientHeight: int.parse(json['Patient_Height'].toString()),
      patientWeight: int.parse(json['Patient_Weight'].toString()),
      patientContactNo: json['Patient_Contact_No'],
      occupation: json['Occupation'],
      address: json['Address'],
    );
  }
}
