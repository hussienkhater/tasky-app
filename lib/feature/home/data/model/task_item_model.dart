import 'package:flutter/widgets.dart';

class TaskItemModel {
  TaskItemModel({
    required this.id,
    required this.title,
    required this.date,
    required this.priority,
    required this.isCompleted,
    required this.onChanged,
    required this.onTap,
    required this.onDelete,
  });
  final String id;
  final String title;
  final DateTime date;
  final int priority;
  final bool isCompleted;
  final void Function(bool?) onChanged;
  final VoidCallback onTap;
  final void Function(BuildContext) onDelete;
}
