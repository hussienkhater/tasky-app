import 'package:flutter/material.dart';

class ElevateButtonScreen extends StatelessWidget {
  final String text;
  final String? routeName;
  final VoidCallback? onpressed;

  const ElevateButtonScreen({
    required this.text,
    this.routeName,
    this.onpressed,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (onpressed != null) {
            onpressed!();
          } else if (routeName != null) {
            Navigator.pushNamed(context, routeName!);
          }
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          backgroundColor: const Color(0xff5F33E1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
  }
}
