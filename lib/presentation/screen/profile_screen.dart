import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/progress_graph.dart';
import '../../data/services/state_management.dart';
import '../../constants/colors.dart';
import '../../logic/utils/shared_preferences.dart';
import '../components/info_container.dart';

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  Map<String, dynamic>? userData;
  late String id;

  @override
  void initState() {
    super.initState();
    loadCachedPatientDetails();
  }

  Future<void> loadCachedPatientDetails() async {
    Map<String, dynamic>? cachedPatientDetails =
        await HelperFunctions.getPatientDetails();
    setState(() {
      userData = cachedPatientDetails;
    });
  }

  bool isPatientTileExpanded = true;
  bool isAssessmentTileExpanded = false;
  bool isProgressTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    id = ref.read(idProvider);
    return Scaffold(
        body: userData != null
            ? SingleChildScrollView(
                child: Column(children: [
                  SingleChildScrollView(
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.symmetric(horizontal: 20),
                      childrenPadding: EdgeInsets.only(top: 3),
                      key: UniqueKey(),
                      initiallyExpanded: isPatientTileExpanded,
                      title: const Text(
                        "Patient Details",
                        style: TextStyle(
                          fontSize: 16,
                          color: appBarColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      iconColor: appBarColor,
                      collapsedIconColor: appBarColor,
                      onExpansionChanged: (value) {
                        setState(() {
                          isPatientTileExpanded = value;
                          if ((isAssessmentTileExpanded ||
                                  isProgressTileExpanded) &&
                              isPatientTileExpanded) {
                            isAssessmentTileExpanded = false;
                            isProgressTileExpanded = false;
                          }
                        });
                      },
                      trailing: Icon(
                          (isPatientTileExpanded) ? Icons.remove : Icons.add),
                      children: [
                        InfoContainer(
                            "ID", userData?["patient_details"]["Patient_Id"]),
                        InfoContainer(
                          "Name",
                          userData!["patient_details"]["Patient_Name"]
                              .toString()
                              .toUpperCase(),
                        ),
                        InfoContainer(
                          "Phone Number",
                          userData?["patient_details"]["Patient_Contact_No"],
                        ),
                        InfoContainer(
                          "Age",
                          userData?["patient_details"]["Patient_Age"],
                        ),
                        InfoContainer(
                          "Gender",
                          userData?["patient_details"]["Patient_Gender"],
                        ),
                        InfoContainer(
                          "Height",
                          userData!["patient_details"]["Patient_Height"]
                              .toString(),
                        ),
                        InfoContainer(
                          "Weight",
                          userData!["patient_details"]["Patient_Weight"]
                              .toString(),
                        ),
                        InfoContainer(
                          "Occupation",
                          userData?["patient_details"]["Occupation"],
                        ),
                        InfoContainer(
                          "Address",
                          userData?["patient_details"]["Address"],
                        ),
                        InfoContainer(
                          "Discharge Sheet",
                          "Download discharge sheet",
                          id: userData?["patient_details"]["Patient_Id"],
                          lastAssessmentDate: userData!["latest_assessment"]
                              ["DateOfAssessment"],
                          isPdf: true,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                      color: appBarColor,
                      thickness: 0.5,
                      indent: 10,
                      endIndent: 10),
                  SingleChildScrollView(
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.symmetric(horizontal: 20),
                      childrenPadding: EdgeInsets.only(top: 3),
                      key: UniqueKey(),
                      title: const Text(
                        "Assessment Details",
                        style: TextStyle(
                          fontSize: 16,
                          color: appBarColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      initiallyExpanded: isAssessmentTileExpanded,
                      trailing: Icon((isAssessmentTileExpanded)
                          ? Icons.remove
                          : Icons.add),
                      collapsedIconColor: appBarColor,
                      iconColor: appBarColor,
                      onExpansionChanged: (value) {
                        setState(() {
                          isAssessmentTileExpanded = value;
                          if ((isPatientTileExpanded ||
                                  isProgressTileExpanded) &&
                              isAssessmentTileExpanded) {
                            isPatientTileExpanded = false;
                            isProgressTileExpanded = false;
                          }
                        });
                      },
                      children: [
                        InfoContainer(
                            "Last Assessment",
                            userData!["latest_assessment"]["Diagnosis"]
                                .toString()
                                .toUpperCase(),
                            date: userData!["latest_assessment"]
                                ["DateOfAssessment"]),
                        InfoContainer("Treatment Plan",
                            userData!["latest_assessment"]["TreatmentPlan"]),
                        InfoContainer(
                            "No of days",
                            userData!["latest_assessment"]["NumberOfDays"]
                                .toString()),
                        InfoContainer(
                          "Home Advice",
                          userData!["latest_assessment"]["HomeAdvice"],
                        ),
                        InfoContainer(
                          "Next Review",
                          userData!["latest_assessment"]["ReviewNext"]
                              .toString(),
                        ),
                        InfoContainer(
                          "Follow up",
                          userData!["latest_assessment"]["FollowUp"],
                        ),
                        InfoContainer(
                          "Contraindication",
                          userData!["latest_assessment"]["Contraindication"]
                              .toString(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                      color: appBarColor,
                      thickness: 0.5,
                      indent: 10,
                      endIndent: 10),
                  SingleChildScrollView(
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 20),
                      childrenPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                      key: UniqueKey(),
                      title: const Text(
                        "Progress Graph",
                        style: TextStyle(
                          fontSize: 16,
                          color: appBarColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      initiallyExpanded: isProgressTileExpanded,
                      trailing: Icon(
                          (isProgressTileExpanded) ? Icons.remove : Icons.add),
                      collapsedIconColor: appBarColor,
                      iconColor: appBarColor,
                      onExpansionChanged: (value) {
                        setState(() {
                          isProgressTileExpanded = value;
                          if ((isAssessmentTileExpanded ||
                                  isPatientTileExpanded) &&
                              isProgressTileExpanded) {
                            isAssessmentTileExpanded = false;
                            isPatientTileExpanded = false;
                          }
                        });
                      },
                      children: [ProgressGraph(userData: userData)],
                    ),
                  ),
                ]),
              )
            : const Center(
                child: CircularProgressIndicator.adaptive(
                backgroundColor: primaryColor,
              )));
  }
}

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}
