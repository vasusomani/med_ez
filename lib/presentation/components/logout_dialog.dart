import 'dart:io';
import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_snackbar.dart';
import '../../logic/utils/shared_preferences.dart';
import '../../Constants/colors.dart';

void showLogoutDialog(BuildContext context) {
  Text title = const Text("Confirm Logout");
  Text content =
      const Text('Are you sure you want to logout from your current account?');
  {
    showDialog(
        context: context,
        builder: (context) => (Platform.isIOS)
            ? CupertinoAlertDialog(
                title: title,
                content: content,
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () async {
                      AlanVoice.deactivate();
                      AlanVoice.hideButton();
                      if (context.mounted) {
                        await HelperFunctions.clearSharedPreferences();
                        showCustomSnackBar("Logged Out Successfully!", context);
                        Navigator.popUntil(
                            context, ModalRoute.withName('/login'));
                        Navigator.pushNamed(context, '/');
                        Navigator.pushNamed(context, '/login');
                      } // Close the dialog
                    },
                    child: const Text("Log Out"),
                  )
                ],
              )
            : AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                title: title,
                titleTextStyle: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                        color: headingColor, fontWeight: FontWeight.bold),
                content: content,
                contentTextStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: buttonBgColor)),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(buttonBgColor),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)))),
                    onPressed: () async {
                      AlanVoice.deactivate();
                      AlanVoice.hideButton();
                      if (context.mounted) {
                        await HelperFunctions.clearSharedPreferences();
                        showCustomSnackBar("Logged Out Successfully!", context);
                        Navigator.popUntil(
                            context, ModalRoute.withName('/login'));
                        Navigator.pushNamed(context, '/');
                        Navigator.pushNamed(context, '/login');
                      } // Close the dialog
                    },
                    child: Text('Log Out',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ));
  }
}
