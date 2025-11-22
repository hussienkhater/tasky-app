import 'package:flutter/material.dart';
import 'package:tasky_app/feature/home/data/model/task_model.dart';
import 'package:tasky_app/feature/home/widgets/show_dialog_priority.dart';
import 'package:tasky_app/feature/home/widgets/show_modal_button_sheet.dart';
import 'package:tasky_app/feature/home/data/firebase/firebase_function.dart';

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
}
