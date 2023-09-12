import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_snackbar.dart';
import '../../logic/utils/shared_preferences.dart';
import '../../Constants/colors.dart';

void showLogoutDialog(BuildContext context) {
  {
    showCupertinoDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: const Text('Confirm Logout'),
              titleTextStyle: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: headingColor, fontWeight: FontWeight.bold),
              content: const Text(
                  'Are you sure you want to logout from your current account?'),
              contentTextStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/login'));
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
                    await HelperFunctions.clearSharedPreferences();
                    if (context.mounted) {
                      showCustomSnackBar("Logged Out Succesfully!", context);
                      Navigator.pushReplacementNamed(context, '/login');
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
