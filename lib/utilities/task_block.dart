import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:masterclass_2/LocalDb.dart';

class TaskBlock extends StatelessWidget {
  
  final String text;
  final bool isChecked;
  final Function(bool?)? onChanged;
  final VoidCallback delete;
  
  TaskBlock({super.key, 
    required this.text, 
    required this.isChecked, 
    required this.onChanged,
    required this.delete
  });

  final LocalDb db = LocalDb();

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
          child: Slidable(
            endActionPane: ActionPane(motion: DrawerMotion(),
             children: [
              SlidableAction(
                onPressed: (context) => delete(),
                icon: Icons.delete,
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)
                ),
              ),
              SlidableAction(
                flex: 2,
                onPressed: (context) {
                  // TODO: Implement edit functionality
                },
                icon: Icons.edit,
                backgroundColor: Colors.blue,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)
                ),
              ),
            ],),
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 211, 105),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                children: [
                  Checkbox(value: isChecked, onChanged: onChanged, activeColor: Color.fromARGB(255, 34, 40, 49),),
                  Text(text, style: TextStyle(
                    decoration: isChecked? TextDecoration.lineThrough : TextDecoration.none,
                    color: Color.fromARGB(255, 34, 40, 49),
                    fontSize: 15
                  ),),
                ],
              ),
            ),
          ),
    );
  }
}