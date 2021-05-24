import 'package:flutter/material.dart';

import 'package:todolist/Task.dart';
import 'package:todolist/repository/TaskDataBase.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de tarefas',
      home: TodoList(),
    );
  }
}

// classe de widget
class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

// classe de estados
class _TodoListState extends State<TodoList> {
  // final List<Task> _todoList = <Task>[];
  final TextEditingController _textTitleController = TextEditingController();

  void _addTodoItem(String title) {
    setState(() {
      TaskDataBase.salvar(Task(title, false));
    });
    _textTitleController.clear();
  }

  void _removeItem(Task task) {
    setState(() {
      TaskDataBase.remover(task);
    });
  }

  void _checkItem(Task task) {
    setState(() {
      task.checked = !task.checked;
      TaskDataBase.marcar(task);
    });
  }

  Future<AlertDialog> _displayDialog(BuildContext context) async {
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Adicionar nova tarefa"),
          content: Container(
            height: 50,
            child: Column(
              children: [
                TextField(
                  controller: _textTitleController,
                  decoration: InputDecoration(hintText: "Título..."),
                )
              ]
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              }
            ),
            FlatButton(
              child: Text("Adicionar", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textTitleController.text);
              }
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Lista de tarefas")),
        body: FutureBuilder(
          future: TaskDataBase.listTask(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                var textStyle;
                if(snapshot.data[index].checked) {
                  textStyle = TextStyle(decoration: TextDecoration.lineThrough);
                } else {
                  textStyle = TextStyle(decoration: TextDecoration.none);
                }


                return ListTile(
                  title: GestureDetector(
                    onTap: () => _checkItem(snapshot.data[index]),
                    onLongPress: () => _removeItem(snapshot.data[index]),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(snapshot.data[index].title, style: textStyle)
                          ]
                        ),
                      ),
                    )
                  )
                );
              }
            );
          }
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: "Adicionar tarefa",
          child: Icon(Icons.add)
        ),
    );
  }
}