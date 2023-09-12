import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_ez/constants/colors.dart';
import '../../data/services/state_management.dart';
import '../../data/models/api_res_model.dart';
import '../../data/services/api_service.dart';
import '../../logic/utils/shared_preferences.dart';
import '../components/exercise_container.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  ApiResponse? apiResponse;
  bool isLoading = false;
  late DateTime lastUpdatedDate;
  late String userID;
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userID = ref.watch(idProvider);
    return Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(
                    backgroundColor: bgSecondaryColor),
              )
            : ListView.builder(
                itemBuilder: (context, index) =>
                    ExerciseContainer(apiResponse: apiResponse!, index: index),
                itemCount: apiResponse?.latestAssessment.exercises.length,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
              ),
        floatingActionButton: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(appBarColor.withOpacity(0.8)),
              shape: MaterialStatePropertyAll(CircleBorder()),
              padding: MaterialStatePropertyAll(EdgeInsets.all(15))),
          onPressed: () => _loadData(isServerData: true),
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(isLoading ? 1 : 0),
            child: Icon(
              (Platform.isIOS ? CupertinoIcons.refresh_bold : Icons.refresh),
              size: 30,
            ),
          ),
        ));
  }

  Future _loadData({bool isServerData = false}) async {
    setState(() {
      isLoading = true; //Data is loading
    });
    if (isServerData) {
      await _loadServerPatientDetails().then((value) {
        setState(() {
          isLoading = false;
        });
      });
    } else {
      await loadCachedPatientDetails().then((value) {
        setState(() {
          isLoading = false; // Data is loaded
        });
      });
    }
  }

  Future _loadServerPatientDetails() async {
    Map<String, dynamic>? updatedPatientDetails =
        await ApiService().fetchPatientData(userID);
    apiResponse = ApiResponse.fromJson(updatedPatientDetails);
    log("Patient Data fetched from Server");
    await HelperFunctions.savePatientDetails(updatedPatientDetails);
    // String? response = await HelperFunctions.getLastUpdatedDate();
    // lastUpdatedDate = DateTime.tryParse(response!)!;
    setState(() {});
    log(updatedPatientDetails.toString());
  }

  Future loadCachedPatientDetails() async {
    Map<String, dynamic>? cachedPatientDetails =
        await HelperFunctions.getPatientDetails();
    apiResponse = ApiResponse.fromJson(cachedPatientDetails!);
    log(cachedPatientDetails.toString());
  }
}
