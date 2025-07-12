import 'package:flutter/material.dart';
import 'package:masterclass_2/utilities/filled_button_style.dart';

class AddWindow extends StatelessWidget {
  final TextEditingController myController;
  final VoidCallback onSaved;
  
  const AddWindow({super.key, required this.myController, required this.onSaved });



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: myController,
              decoration: InputDecoration(
                hintText: 'Enter your task',
                border: OutlineInputBorder(),
              ),
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
      ),
      backgroundColor: Color.fromARGB(255, 255, 211, 105),
      
    );
  }
}