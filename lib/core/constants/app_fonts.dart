import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/app_colors.dart';

abstract class AppFonts {
  static const TextStyle title = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.titleText,
  );
  static const TextStyle homeTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: AppColors.titleText,
  );

  static const TextStyle onBoardingSubtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.subtitleText,
  );
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const TextStyle labelText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.titleText,
  );

  static const TextStyle hintText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
    overflow: TextOverflow.ellipsis,
  );
  static const TextStyle signNav = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.titleText,
  );
  static const TextStyle cardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: -0.32,
  );
  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Color(0xff6E6A7C),
    letterSpacing: -0.32,
  );
}