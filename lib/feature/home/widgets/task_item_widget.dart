import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tasky_app/core/constants/app_colors.dart';
import 'package:tasky_app/core/constants/app_constant.dart';
import 'package:tasky_app/core/constants/app_fonts.dart';
import 'package:tasky_app/feature/home/data/firebase/firebase_function.dart';
import 'package:tasky_app/feature/home/data/model/task_item_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({super.key, required this.taskModel});
  final TaskItemModel taskModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: taskModel.onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.5,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  FireBaseFunction.deleteTask(taskModel.id);
                },
                label: "Delete",
                icon: Icons.delete,
                backgroundColor: Colors.red,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 16, top: 16, bottom: 16),
            child: Row(
              children: [
                Radio(
                  value: taskModel.isCompleted,
                  groupValue: true,
                  onChanged: (value) {
                    taskModel.onChanged(value);
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    spacing: 6,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(taskModel.title, style: AppFonts.cardTitle),
                      Text(
                        taskModel.date.toString().substring(0, 10),
                        style: AppFonts.cardSubtitle,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(AppConstants.flagIcon, scale: 2),
                      Text(' ${taskModel.priority} '),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
