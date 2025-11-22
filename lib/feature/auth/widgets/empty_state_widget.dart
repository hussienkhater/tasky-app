import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/app_constant.dart';
import 'package:tasky_app/core/constants/app_fonts.dart';

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
            style: AppFonts.homeTitle,
            textAlign: TextAlign.center,
          ),
          const Text(
            'Tap + to add your tasks',
            style: AppFonts.onBoardingSubtitle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
