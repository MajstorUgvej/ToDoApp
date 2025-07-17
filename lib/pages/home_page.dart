import 'package:flutter/material.dart';
import 'package:masterclass_2/LocalDb.dart';
import 'package:masterclass_2/utilities/add_window.dart';
import 'package:masterclass_2/utilities/task_block.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Edit tasks initial values
  bool isEditing = false;
  late FocusNode focusNode;
  late TextEditingController myEditController;
  int? position;

  // Instance of LocalDb to access the database
  final LocalDb db = LocalDb();
  get database async => await db.database;

  // List to hold tasks fetched from the database
  List<Map<String, dynamic>> tasks = [];
  
  @override
  void initState() {
    super.initState();
    // load database
    loadTasks();
    // Initialize the focus node and text controller
    focusNode = FocusNode();
    myEditController = TextEditingController();
  }
  
  @override
  void dispose() {
    // Dispose of the focus node and text controller
    focusNode.dispose();
    myController.dispose();
    super.dispose();
  }

  void startEditing(int index) {

    position = index; // Store the current index for editing
    myEditController.text = tasks[index]['title']; // Set the text for editing

    setState(() {
      isEditing = true;
    });
    
    // delay to ensure the text field is built before requesting focus
    Future.delayed(Duration(milliseconds: 100), () {
      focusNode.requestFocus();
    });
  }

  Future<void> loadTasks() async {
    tasks = await db.fetchTasks();
    setState(() {});
  }

  // Updates the state of the task when it is checked or unchecked
  void changeTaskState(int index) async{
    final task = tasks[index];
    int id = task['id'];
    await db.updateTask(id, task['isCompleted'] == 1 ? false : true);
    await loadTasks(); // Reload tasks from the database
  }

  // delete task
  void deleteTask(int index) async
  {
    int id = tasks[index]['id'];
    await db.deleteTask(id);
    await loadTasks(); // Reload tasks from the database
  }

  // Save task
  void onSaved() async
  {
    await db.addTask(myController.text);
    // Clear the text field after saving
    myController.clear();
    Navigator.of(context).pop();
    // Reload tasks from the database
    await loadTasks(); 
  }

  // Edit task
  void editTask(int index) async{
    await db.updateTaskTitle(tasks[index]['id'], myEditController.text);
    await loadTasks(); // Reload tasks from the database
    setState(() {
      isEditing = false;
    });
  }

  // controller
  TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 57, 62, 70),
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 34, 40, 49),
        title: const Text('TO DO', style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: isEditing?
      Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none
              ),
              fillColor: Color.fromARGB(255, 255, 211, 105),
              filled: true,
            ),
            controller: myEditController,
            focusNode: focusNode,
            autofocus: true,
            onTapOutside: (event) {
                editTask(position!);
            },
          ),
        )
      ) 
      : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskBlock(
            text: task['title'],
            isChecked: task['isCompleted'] == 1,
            onChanged: (val) => changeTaskState(index),
            delete: () => deleteTask(index),
            startEditing:() => startEditing(index),
          );
        },
      ),
      // FAB is disabled when editing
      floatingActionButton: isEditing? null :  FloatingActionButton(onPressed: () {
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