import 'package:flutter/material.dart';
import 'package:tasky_app/core/constants/app_constant.dart';

class PriorityItem extends StatelessWidget {
  const PriorityItem({
    required this.index,
    required this.isSelected,
    this.onTap,
    super.key,
  });
  final int index;
  final isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: isSelected ? null : Border.all(color: Color(0xff24252C)),
          borderRadius: BorderRadius.circular(4),
          color: isSelected ? Color(0xff5F33E1) : Colors.transparent,
        ),
        child: Column(
          children: [
            Image.asset(
              AppConstants.flagIcon,
              color: isSelected ? Colors.white : null,
            ),
            Text(
              index.toString(),
              style: TextStyle(
                color: isSelected ? Colors.white : Color(0xff404147),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
