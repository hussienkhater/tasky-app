import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/app_colors.dart';
import 'package:tasky_app/feature/auth/view/task_details.dart';
import 'package:tasky_app/feature/auth/widgets/empty_state_widget.dart';
import 'package:tasky_app/feature/home/data/model/task_item_model.dart';
import 'package:tasky_app/feature/home/data/model/task_model.dart';
import 'package:tasky_app/feature/home/widgets/show_dialog_priority.dart';
import 'package:tasky_app/feature/home/widgets/show_modal_button_sheet.dart';
import 'package:tasky_app/feature/home/data/firebase/firebase_function.dart';
import 'package:tasky_app/feature/home/widgets/task_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController taskTitle = TextEditingController();
  final TextEditingController taskDescription = TextEditingController();
  DateTime selectedDate = DateTime.now();
  int selectedPriority = 1;
  TaskItemModel? taskItemModel;

  void initState() {
    super.initState();
    getAllTasks();
  }

  void getAllTasks() {
    FireBaseFunction.getTasks(selectedDate).listen((event) {
      List<TaskModel> tasks = event.docs.map((e) => e.data()).toList();
      // Do something with the tasks, e.g., update the UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                Image.asset("assets/icons/logo.png"),
                const Spacer(),
                Image.asset("assets/icons/logout.png"),
                SizedBox(width: 10),
                Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffFF4949),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            DatePicker(
              DateTime.now(),
              height: 100,
              initialSelectedDate: selectedDate,
              daysCount:
                  // Calculate remaining days in the month
                  DateTime(
                        DateTime.now().year,
                        DateTime.now().month + 1,
                        0,
                      ).day -
                      DateTime.now().day +
                      1,
              selectionColor: AppColors.primary,
              selectedTextColor: AppColors.white,
              onDateChange: (date) {
                selectedDate = date;
                getAllTasks();
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 12,
            ),
            StreamBuilder(
              stream: FireBaseFunction.getTasks(selectedDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: [
                        Text("Some Thing Error"),
                        ElevatedButton(
                            onPressed: () {}, child: Text("Try Again"))
                      ],
                    ),
                  );
                }
                var tasks =
                    snapshot.data?.docs.map((doc) => doc.data()).toList();
                if (tasks!.isEmpty) {
                  return EmptyStateWidget();
                }
                return Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return TaskItemWidget(
                          taskModel: taskModelToTaskItem(tasks[index], () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return TaskDetailsScreen(task: tasks[index]);
                              },
                            );
                          }),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 12,
                          ),
                      itemCount: tasks.length),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => ShowModalButton(
              taskTitle: taskTitle,
              taskDescription: taskDescription,
              onTapDate: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (newDate != null) {
                  selectedDate = newDate;
                }
              },
              onTapFlag: () {
                showDialog(
                  context: context,
                  builder: (context) => ShowDialogPriority(
                    callback: (index) {
                      selectedPriority = index;
                    },
                  ),
                );
              },
              onTapSend: () async {
                await FireBaseFunction.addTask(
                  TaskModel(
                    title: taskTitle.text,
                    description: taskDescription.text,
                    date: selectedDate,
                    priority: selectedPriority,
                  ),
                );
                setState(() {
                  Navigator.pop(context);
                }); // refresh after adding
              },
            ),
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, size: 40, color: Colors.deepPurpleAccent),
      ),
    );
  }

  TaskItemModel taskModelToTaskItem(TaskModel task, VoidCallback onTap) {
    return TaskItemModel(
      id: task.id ?? "",
      title: task.title,
      date: task.date ?? DateTime.now(),
      priority: task.priority ?? 1,
      isCompleted: task.isDone ?? false,
      onChanged: (value) {
        if (task.id != null) {
          FireBaseFunction.updateTaskDoneStatus(task.id!, value ?? false);
        }
      },
      onTap: onTap,
      onDelete: (ctx) {
        if (task.id != null) {
          FireBaseFunction.deleteTask(task.id!);
        }
      },
    );
  }
}
