import 'package:flutter/material.dart';
import '../../Constants/colors.dart';

void showCustomSnackBar(String content, BuildContext context,
    {bool isAlert = false}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: 1500),
      elevation: 6,
      content: Text(
        content,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: (isAlert) ? (alertColor) : (appBarColor),
      closeIconColor: Colors.white,
      showCloseIcon: true,
      dismissDirection: DismissDirection.down,
    ),
  );
}
