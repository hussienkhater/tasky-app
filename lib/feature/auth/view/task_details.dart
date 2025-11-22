import 'package:flutter/material.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // --- Header ---
              Row(
                children: [
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
                ],
              ),

              const SizedBox(height: 24),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: titleController,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // --- Task Settings ---
              Column(
                children: [
                  // Task Time
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.grey),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: pickDate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black,
                        ),
                        child: Text(
                            "Today ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Task Priority
                  Row(
                    children: [
                      const Icon(Icons.flag, color: Colors.grey),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // هنا ممكن تضيف اختيار الأولوية
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black,
                        ),
                        child: Text("Default"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Delete Task
                  GestureDetector(
                    onTap: deleteTask,
                    child: Row(
                      children: const [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          "Delete Task",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // --- Footer Button ---
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
                          borderRadius: BorderRadius.circular(12)),
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
      ),
    );
  }
}
