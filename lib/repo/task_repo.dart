import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/service/db_connect.dart';
import 'package:todo_app/theme/theme.dart';

class TaskRepo {
  late DBConnection dbConnection;

  TaskRepo() {
    dbConnection = DBConnection();
  }

  static Database? _datebase;
  Future<Database> get database async {
    // -------------Run onlyone-------------------------------------------
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentsDirectory.path, "db_pos");
    // await deleteDatabase(path);
    // print('Database created new...!');
    // ---------------------------------------------------------------------
    if (_datebase != null) return _datebase!;
    _datebase = await dbConnection.setDatabase();
    return _datebase!;
  }

  insertTask(TaskModel taskModel) async {
    Database con = await database;
    return await con.insert("tbTask", taskModel.toMap());
  }

  selectTask() async {
    Database con = await database;
    return con.query('tbTask');
  }

  deleteTask(String taskId) async {
    Database con = await database;
    return con.delete("tbTask", where: "ID = ?", whereArgs: [taskId]);
  }

  updateTask(String id) async {
    Database con = await database;
    return con.rawUpdate('''
      UPDATE tbTask 
      SET isComplate = ?
      WHERE ID = ?
     ''', [1, id]);
  }
}
