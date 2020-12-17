// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_app_firebase4/domain/todo.dart';
import 'package:my_todo_app_firebase4/presentation/add_todo/add_todo_page.dart';
// import 'package:my_todo_app_firebase4/presentation/login/login_page.dart';
import 'package:my_todo_app_firebase4/presentation/settings/settings_page.dart';
import 'package:my_todo_app_firebase4/presentation/todo_list/todo_list_model.dart';
import 'package:my_todo_app_firebase4/presentation/settings/settings_page.dart';
import 'package:provider/provider.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoListModel>(
      create: (_) => TodoListModel()..fetchTodos(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Todo'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              // onPressed: () async {
              //   await FirebaseAuth.instance.signOut();
              //   await Navigator.of(context).pushReplacement(
              //     MaterialPageRoute(builder: (context) {
              //       return LoginPage();
              //     }),
              //   );
              // },
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              }
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              // image: _image,
              image: AssetImage('images/hyde.jpeg'),
            ),
          ),
          child: Consumer<TodoListModel>(
            builder: (context, model, child) {
              final todos = model.todos;
              final listTiles = todos
                  .map(
                    (todo) => Dismissible(
                      background: Container(color: Colors.red[200]),
                      key: Key(todo.documentID),
                      onDismissed: (direction) async {
                        await deleteTodo(context, model, todo);
                      },
                      child: Card(
                        color: Colors.transparent,
                        child: ListTile(
                          tileColor: Colors.white38,
                          title: Text(todo.title),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddTodoPage(
                                  todo: todo,
                                ),
                                fullscreenDialog: true,
                              ),
                            );
                            model.fetchTodos();
                          },
                        ),
                      ),
                    ),
                  )
                  .toList();
              return ListView(
                children: listTiles,
              );
            },
          ),
        ),
        floatingActionButton:
            Consumer<TodoListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTodoPage(),
                  fullscreenDialog: true,
                ),
              );
              model.fetchTodos();
            },
          );
        }),
      ),
    );
  }

  Future deleteTodo(
    BuildContext context,
    TodoListModel model,
    Todo todo,
  ) async {
    try {
      await model.deleteTodo(todo);
      await model.fetchTodos();
    } catch (e) {
      await _showDialog(context, e.toString());
      print(e.toString());
    }
  }

  Future _showDialog(
    BuildContext context,
    String title,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
