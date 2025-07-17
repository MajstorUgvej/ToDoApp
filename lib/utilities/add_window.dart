import 'package:flutter/material.dart';
import 'package:masterclass_2/utilities/filled_button_style.dart';

class AddWindow extends StatelessWidget {
  final TextEditingController myController;
  final VoidCallback onSaved;
  
  const AddWindow({super.key, required this.myController, required this.onSaved });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
                  TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    hintText: 'Enter your task',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButtonStyle(onPressed: () {
                    Navigator.of(context).pop();     
                    myController.clear();     
                  }, text: 'Cancel'),
                  FilledButtonStyle(onPressed: onSaved, text: 'Save'),
                ],
              )
            ],
          ),
      backgroundColor: Color.fromARGB(255, 255, 211, 105),
      
    );
  }
}