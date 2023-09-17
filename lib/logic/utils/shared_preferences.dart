import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String userLoggedInKey = "LOGGEDINKEY";
  static String patientDetailsKey = "PATIENTDETAILSKEY";
  static String lastUpdatedKey = "LASTUPDATEDKEY";

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<bool> savePatientDetails(
      Map<String, dynamic> patientDetails) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    // await saveLastUpdatedDate();
    return await sf.setString(patientDetailsKey, json.encode(patientDetails));
  }

  static Future<Map<String, dynamic>?> getPatientDetails() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    final patientDetailsString = sf.getString(patientDetailsKey);
    if (patientDetailsString != null) {
      final data = json.decode(patientDetailsString);
      debugPrint(data.toString());
      return data;
    }
    return null;
  }

  // static Future<bool> saveLastUpdatedDate() async {
  //   SharedPreferences sf = await SharedPreferences.getInstance();
  //   return await sf.setString(
  //       lastUpdatedKey,
  //       json.encode(
  //         {"last_data_updated": DateTime.now().toString()},
  //       ));
  // }
  //
  // static Future<String?> getLastUpdatedDate() async {
  //   SharedPreferences sf = await SharedPreferences.getInstance();
  //   return sf.getString(lastUpdatedKey);
  // }

  static Future clearSharedPreferences() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    await sf.clear();
  }
}
