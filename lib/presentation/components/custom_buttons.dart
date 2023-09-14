import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.data,
    this.vertical,
    this.isLoading = false,
  });
  final Function() onPressed;
  final String data;
  final double? vertical;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        padding: EdgeInsets.symmetric(vertical: vertical ?? 20),
        backgroundColor: bgPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: (isLoading)
          ? CircularProgressIndicator.adaptive(
              backgroundColor: bgSecondaryColor)
          : Text(
              data,
              style: const TextStyle(
                  color: appBarColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
    );
  }
}
