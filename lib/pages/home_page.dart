import 'package:flutter/material.dart';
import 'package:masterclass_2/utilities/add_window.dart';
import 'package:masterclass_2/utilities/task_block.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List of tasks
  final List toDoList= [
    ['Make bed', false],
    ['Study hard', false],
  ];

  // finish task
  void changeTaskState(int index)
  {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  // controller
  TextEditingController myController = TextEditingController();

  // save task
  void onSaved()
  {
    setState(() {
      toDoList.add([myController.text, false]);
      myController.clear();
    });
    Navigator.of(context).pop();
  }

  // delete task
  void deleteTask(int index)
  {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 57, 62, 70),
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 34, 40, 49),
        title: const Text('TO DO', style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return TaskBlock(
            text: toDoList[index][0],
            isChecked: toDoList[index][1],
            onChanged: (val) => changeTaskState(index),
            delete: () => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog(
          context: context, 
          builder:(context) {
            return AddWindow(myController: myController,onSaved: onSaved,);
          }, 
        );
      },
      backgroundColor: Color.fromARGB(255, 238, 238, 238),
      child: Icon(Icons.add),
      ),
    );
  }
}