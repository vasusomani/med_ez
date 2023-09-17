import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final _baseurl = "https://hope-backend.onrender.com/app";

  Future login(String userId, String password) async {
    final url = Uri.parse('$_baseurl/login');
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      if (kDebugMode) {
        print("$userId $password");
      }

      final response = await http
          .post(url,
              headers: headers,
              body: json.encode({
                'userId': userId,
                'password': password,
              }))
          .then((response) {
        return response;
      });

      return response;
    } catch (e) {
      return e;
    }
  }
}
