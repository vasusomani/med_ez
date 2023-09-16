import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_ez/presentation/screen/video_screen.dart';
import '../../data/models/api_res_model.dart';
import '../../data/models/exercises_model.dart';
import '../../constants/colors.dart';
import 'date_expired_popup.dart';

class ExerciseContainer extends StatelessWidget {
  const ExerciseContainer({
    Key? key,
    required this.apiResponse,
    required this.index,
  }) : super(key: key);

  final ApiResponse apiResponse;
  final int index;

  @override
  Widget build(BuildContext context) {
    List<Exercise> exerciseList = apiResponse.latestAssessment.exercises;
    String expDate = exerciseList[index].nextReview;
    DateTime currDateObj = DateTime.now();
    DateTime expDateObj = DateFormat('yyyy-MM-dd').parse(expDate);
    double sWidth = MediaQuery.of(context).size.width;
    double sHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      width: sWidth,
      // height: sHeight * 0.18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: containerColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Text(
              exerciseList[index].nameOfExercise,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text("Reps: ${exerciseList[index].reps}"),
          Text("Sets: ${exerciseList[index].sets}"),
          Text("No of days: ${exerciseList[index].noOfDays}"),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (currDateObj.isAfter(expDateObj))
                const Text(
                  "Expired",
                  style: TextStyle(
                    color: alertColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (!currDateObj.isAfter(expDateObj))
                Text(
                  "Deadline : ${exerciseList[index].nextReview}",
                  style: const TextStyle(
                    color: buttonBgColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () => !currDateObj.isAfter(expDateObj)
                      ? null
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen(
                                url: exerciseList[index].link,
                                exerciseName:
                                    exerciseList[index].nameOfExercise),
                          )),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: currDateObj.isAfter(expDateObj)
                          ? buttonBgColor.withOpacity(0.5)
                          : buttonBgColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      "Watch Now",
                      style: TextStyle(
                        color: buttonTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
