import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../components/custom_buttons.dart';
import '../components/custom_snackbar.dart';
import '../../data/services/state_management.dart';
import '../components/page_navigator.dart';
import '../../constants/colors.dart';
import '../../data/services/api_service.dart';
import '../../data/services/auth_service.dart';
import '../../logic/utils/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _authService = AuthService();

  bool isLoading = false;
  late String _userId;
  late String _password;

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _userId = '';
    _password = '';
  }

  Future _saveData() async {
    await HelperFunctions.saveUserLoggedInStatus(true);
    Map<String, dynamic>? patientDetails =
        await ApiService().fetchPatientData(_userId);
    await HelperFunctions.savePatientDetails(patientDetails);
    debugPrint("Patient Data fetched from Server");
    debugPrint(patientDetails.toString());
  }

  void _handleEmailNumberChanged(String value) {
    setState(() {
      _userId = value;
    });
  }

  void _handlePasswordChanged(String value) {
    setState(() {
      _password = value;
    });
  }

  void _handleLoginPressed() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      setState(() {
        isLoading = true;
      });

      final response = await _authService.login(_userId, _password);
      if (kDebugMode) {
        print(response.body);
      }

      if (response is http.Response) {
        if (response.statusCode == 200) {
          if (kDebugMode) {
            print(response.body);
          }
          bool loginSuccessful = response.body.toLowerCase() == 'true';

          if (loginSuccessful) {
            // Successful login
            await _saveData();
            ref.watch(idProvider.notifier).changeId(_userId);
            setState(() {
              isLoading = false;
            });
            showCustomSnackBar("Loggedin Succesfully", context);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PagesNavigator()));
          } else {
            setState(() {
              isLoading = false;
            });
            showCustomSnackBar("Invalid username or password", context,
                isAlert: true);
          }
        } else {
          setState(() {
            isLoading = false;
          });
          showCustomSnackBar(
              "Something went wrong! Please try again later", context,
              isAlert: true);
          // Show an error message or handle as needed
        }
      } else {
        setState(() {
          isLoading = false;
        });
        showCustomSnackBar(
            "Something went wrong! Please try again later", context,
            isAlert: true);
        // Show an error message or handle as needed
      }
    } else {
      setState(() {
        isLoading = false;
      });
      showCustomSnackBar("No internet connection found!", context,
          isAlert: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.isFirst);
        return true;
      },
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          height: double.infinity,
          decoration: const BoxDecoration(gradient: bgGradient),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          'assets/images/medic3.png',
                          scale: 2,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 170),
                          child: Column(
                            children: [
                              // const Text(
                              //   "Patient Login",
                              //   style: TextStyle(
                              //     fontSize: 30,
                              //     fontWeight: FontWeight.w700,
                              //     color: bgPrimaryColor,
                              //   ),
                              // ),
                              // const SizedBox(height: 20),
                              TextField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 15.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  hintText: 'User ID',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                onChanged: _handleEmailNumberChanged,
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: const TextStyle(
                                    color: bgPrimaryColor,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: bgPrimaryColor,
                                    ),
                                  ),
                                ),
                                obscureText: _obscureText,
                                onChanged: _handlePasswordChanged,
                              ),
                              const SizedBox(height: 35),
                              PrimaryButton(
                                onPressed: _handleLoginPressed,
                                data: "Login",
                                vertical: 10,
                                isLoading: isLoading,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
