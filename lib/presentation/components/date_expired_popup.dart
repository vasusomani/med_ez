import 'package:flutter/material.dart';
import '../../constants/colors.dart';

void showDateExpiredPopUp(BuildContext context) {
  showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: bgPrimaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: const Text(
            "Your deadline has been expired",
            style: TextStyle(color: alertColor),
          ),
        );
      });
}
