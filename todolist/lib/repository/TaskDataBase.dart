import 'package:todolist/Task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TaskDataBase {
  static final TaskDataBase _singleton = new TaskDataBase();

  factory TaskDataBase() {
    return _singleton;
  }

  static _dataBaseManager() async {
    final int versiondb = 1;
    final pathDatabase = await getDatabasesPath();
    final localDatabase = join(pathDatabase, "todo.db");

    var bd = await openDatabase(localDatabase, version: versiondb,
        onCreate: (db, versiondb) {
          String sql = "create table task(id integer primary key, title varchar, checked integer)";
          db.execute(sql);
    });
    return bd;
  }

  static salvar(Task task) async {
    Database bd = await _dataBaseManager();
    Map<String, dynamic> taskData = {"title": task.title, "checked": task.checked};
    int id = await bd.insert("task", taskData);
  }

  static remover(Task task) async {
    Database bd = await _dataBaseManager();
    bd.delete("task", where: "id = ?", whereArgs: [task.id]);
  }

  static marcar(Task task) async {
    Database bd = await _dataBaseManager();
    Map<String, dynamic> dadosTask = {
      "title": task.title,
      "checked": task.checked,
    };
    bd.update("task", dadosTask, where: "id = ?", whereArgs: [task.id]);
  }

  static Future listTask() async {
    Database bd = await _dataBaseManager();
    List listaTasks = await bd.rawQuery("select * from task");
    var _tasks = new List();

    for (var item in listaTasks) {
      var task = new Task(item['title'], item['checked'] == 1 ? true : false);
      task.id = item['id'];
      _tasks.add(task);
    }

    return _tasks;
  }
  
}