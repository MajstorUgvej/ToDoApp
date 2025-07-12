import 'package:flutter/material.dart';

class FilledButtonStyle extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  
  const FilledButtonStyle({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 34, 40, 49),
        foregroundColor: Color.fromARGB(255, 238, 238, 238),
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(5))
      ),
      child: Text(text)
    );
  }
}