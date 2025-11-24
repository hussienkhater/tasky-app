import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/app_colors.dart';
import 'package:tasky_app/core/constants/app_constant.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 14,
        children: [
          const SizedBox(height: 30),
          Image.asset(
            AppConstants.emptyStateImage,
          ),
          const Text(
            'What do you want to do today?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.titleText,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            'Tap + to add your tasks',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.titleText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
