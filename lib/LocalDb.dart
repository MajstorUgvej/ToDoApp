import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class LocalDb { 
  // Singleton pattern all parts of the app can access the same instance
  static final LocalDb _instance = LocalDb._internal();
  factory LocalDb() => _instance;

  LocalDb._internal();

  Database? _database;


  // Getter for the database, called by using LocalDb().database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB();
    return _database!;
  }

  // Initialize the database, prevents data locked issues
  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'local_db.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            isCompleted INTEGER
          )
        ''');
        // Insert initial tasks, when opening the app for the first time
        await db.rawInsert(
          'INSERT INTO tasks (title, isCompleted) VALUES (?, ?), (?, ?), (?, ?)',
          ['Make your bed', 0, 'Learn github', 0, 'Make an app', 0]
        );
      },
    );
  }
  
  // Adding tasks to the database
  Future<void> addTask(String title) async {
    final db = await database;
    await db.rawInsert(
      'INSERT INTO tasks (title, isCompleted) VALUES (?, ?)',
      [title, 0]
    );
  }

  // Fetching all tasks from the database
  Future fetchTasks() async {
    final db = await database;
    final alldata = await db.rawQuery('SELECT * FROM tasks');
    return alldata;
  }

  // Updating a task's completion status
  Future<void> updateTask(int id, bool isCompleted) async {
    final db = await database;
    await db.rawUpdate(
      'UPDATE tasks SET isCompleted = ? WHERE id = ?',
      [isCompleted ? 1 : 0, id]
    );
  }

  // Updating a task's title
  Future<void> updateTaskTitle(int id, String title) async {
    final db = await database;
    await db.rawUpdate(
      'UPDATE tasks SET title = ? WHERE id = ?',
      [title, id]
    );
  }

  // Delete task by id
  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.rawDelete('DELETE FROM tasks WHERE id = ?', [id]);
  }
  
}