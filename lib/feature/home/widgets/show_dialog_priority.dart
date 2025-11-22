import 'package:flutter/material.dart';
import 'package:tasky_app/feature/auth/widgets/elevate_button.dart';
import 'priority_item_widget.dart';

class ShowDialogPriority extends StatefulWidget {
  const ShowDialogPriority({super.key, required this.callback});
  final Function(int) callback;
  @override
  State<ShowDialogPriority> createState() => _ShowDialogPriorityState();
}

class _ShowDialogPriorityState extends State<ShowDialogPriority> {
  List<int> priorityList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int selectedPriority = 1;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
            "Add Priority",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff24252C),
            ),
          ),
          Divider(color: Color(0xff979797)),
        ],
      ),
      content: Wrap(
        spacing: 10,
        children: priorityList
            .map(
              (index) => PriorityItem(
                index: index,
                isSelected: index == selectedPriority ? true : false,
                onTap: () {
                  selectedPriority = index;
                  widget.callback(selectedPriority);
                  setState(() {});
                },
              ),
            )
            .toList(),
      ),
      actions: [
        ElevateButtonScreen(
          text: "Done",
          onpressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
