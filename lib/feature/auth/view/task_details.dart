import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/app_constant.dart';
import 'package:tasky_app/feature/home/data/model/task_model.dart';
import 'package:tasky_app/feature/home/data/firebase/firebase_function.dart';
import 'package:tasky_app/core/constants/app_colors.dart';

class TaskDetailsScreen extends StatefulWidget {
  final TaskModel task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late DateTime selectedDate;
  late int priority;
  late bool isDone;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController =
        TextEditingController(text: widget.task.description ?? "");
    selectedDate = widget.task.date ?? DateTime.now();
    priority = widget.task.priority ?? 1;
    isDone = widget.task.isDone ?? false;
  }

  void pickDate() async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (newDate != null) {
      setState(() {
        selectedDate = newDate;
      });
    }
  }

  void pickPriority() async {
    // 10 priority options
    List<String> priorities = [
      "Priority 1",
      "Priority 2",
      "Priority 3",
      "Priority 4",
      "Priority 5",
      "Priority 6",
      "Priority 7",
      "Priority 8",
      "Priority 9",
      "Priority 10",
    ];

    String? selected = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: priorities.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(priorities[index]),
              onTap: () {
                Navigator.pop(context, priorities[index]);
              },
            );
          },
        );
      },
    );

    if (selected != null) {
      setState(() {
        priority = priorities.indexOf(selected) + 1;
      });
    }
  }

  void saveTask() async {
    TaskModel updatedTask = TaskModel(
      id: widget.task.id,
      title: titleController.text,
      description: descriptionController.text,
      date: selectedDate,
      priority: priority,
      isDone: isDone,
    );

    await FireBaseFunction.updateTask(updatedTask);

    Navigator.pop(context);
  }

  void deleteTask() async {
    if (widget.task.id != null) {
      await FireBaseFunction.deleteTask(widget.task.id!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.grey,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.close, color: AppColors.red),
                      ),
                    ),
                    const SizedBox(height: 45),
                    // Task title & description with isDone toggle
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isDone = !isDone;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:
                                    isDone ? Colors.green : AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                            width: 24,
                            height: 24,
                            child: isDone
                                ? const Icon(Icons.check,
                                    size: 18, color: Colors.green)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: titleController,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.titleText),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                              TextField(
                                controller: descriptionController,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: AppColors.subtitleText),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Image.asset(AppConstants.timerIcon),
                        const SizedBox(width: 8),
                        Text('Task Time :',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.titleText)),
                        Spacer(),
                        ElevatedButton(
                          onPressed: pickDate,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            backgroundColor: AppColors.grey,
                            foregroundColor: AppColors.titleText,
                          ),
                          child: Text(
                            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Task Priority
                    Row(
                      children: [
                        Image.asset(AppConstants.flagIcon),
                        const SizedBox(width: 8),
                        Text('Task Priority :',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.titleText)),
                        Spacer(),
                        ElevatedButton(
                          onPressed: pickPriority,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            backgroundColor: AppColors.grey,
                            foregroundColor: AppColors.titleText,
                          ),
                          child: Text("Priority $priority"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Delete Task
                    GestureDetector(
                      onTap: deleteTask,
                      child: Row(
                        children: [
                          Image.asset(AppConstants.trashIcon),
                          SizedBox(width: 8),
                          Text(
                            "Delete Task",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.red,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Footer Button ثابت
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: saveTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Edit Task",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
