import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/app_colors.dart';


class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.text, this.onPressed});
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 50,
      minWidth: double.infinity,
      elevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: AppColors.primary,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
