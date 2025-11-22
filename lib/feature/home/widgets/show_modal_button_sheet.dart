import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/app_constant.dart';
import 'package:tasky_app/feature/auth/widgets/text_form_field_widget.dart';

class ShowModalButton extends StatelessWidget {
  const ShowModalButton({
    super.key,
    required this.taskTitle,
    required this.taskDescription,
    this.onTapDate,
    this.onTapFlag,
    this.onTapSend,
  });
  final void Function()? onTapDate;
  final void Function()? onTapFlag;
  final void Function()? onTapSend;
  final TextEditingController taskTitle;
  final TextEditingController taskDescription;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          // bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Task",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            TextFormFieldWidget(
              hint: 'Do math homework',
              borderRadius: BorderRadius.circular(4),
              controller: taskTitle,
            ),
            SizedBox(height: 14),
            TextFormFieldWidget(
              hint: 'Description',
              borderRadius: BorderRadius.circular(4),
              controller: taskDescription,
            ),
            SizedBox(height: 35),
            Row(
              children: [
                GestureDetector(
                  onTap: onTapDate,
                  child: Image.asset(AppConstants.timerIcon),
                ),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: onTapFlag,
                  child: Image.asset(AppConstants.flagIcon),
                ),
                Spacer(),
                GestureDetector(
                  onTap: onTapSend,
                  child: Image.asset(AppConstants.sendIcon),
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
