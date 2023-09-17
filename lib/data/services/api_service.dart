import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:med_ez/presentation/components/custom_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';

class ApiService {
  final String baseUrl = "https://hope-backend.onrender.com";

  Future<Map<String, dynamic>> fetchPatientData(String patientId) async {
    final url = Uri.parse('$baseUrl/app/ViewPatientData');
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

  Future<Uint8List> getDischargeReport(
      String patientId, String dateOfAssessment) async {
    final url = Uri.parse('$baseUrl/GetDischargeSummary');
    final headers = {"Content-type": "application/json"};
    debugPrint(dateOfAssessment);
    final body = json.encode(
        {"Patient_Id": patientId, "DateOfAssessment": dateOfAssessment});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        return response.bodyBytes; // Return PDF content as bytes
      } else {
        throw Exception(
            'Failed to fetch discharge report ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch discharge report ${e.toString()}');
    }
  }

  Future<void> savePDF(BuildContext context, Uint8List pdfContent) async {
    final pdf = pw.Document();
    // Add content to the PDF (you can customize this part)
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello, PDF!'),
          );
        },
      ),
    );
    // Get the application's documents directory
    final directory = await getApplicationDocumentsDirectory();
    // Define the file path for saving the PDF
    final filePath =
        '/storage/emulated/0/Download//patient_discharge_report.pdf';
    // Create a File instance and write the PDF to it
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    showCustomSnackBar("Report has been downloaded successfuly", context);
  }
}
