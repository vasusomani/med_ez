import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://physioplusbackend.onrender.com/app";

  Future<Map<String, dynamic>> fetchPatientData(String patientId) async {
    final url = Uri.parse('$baseUrl/ViewPatientData');
    final headers = {"Content-type": "application/json"};

    final body = json.encode({
      "Patient_Id": patientId,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch patient data ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch patient data');
    }
  }
}
