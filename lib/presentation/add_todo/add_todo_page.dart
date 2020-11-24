import 'package:flutter/material.dart';
import 'package:my_todo_app_firebase4/domain/todo.dart';
import 'package:my_todo_app_firebase4/presentation/add_todo/add_todo_model.dart';
import 'package:provider/provider.dart';

class AddTodoPage extends StatelessWidget {
  AddTodoPage({this.todo});
  final Todo todo;
  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    final bool isUpdate = todo != null;

    if (isUpdate) {
      textEditingController.text = todo.title;
    }

    return ChangeNotifierProvider<AddTodoModel>(
      create: (_) => AddTodoModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? 'Update Todo' : 'Add Todo'),
        ),
        body: Consumer<AddTodoModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: textEditingController,
                    onChanged: (text) {
                      model.todoTitle = text;
                    }
                  ),
                  RaisedButton(
                    child: Text(isUpdate ? 'Update' : 'Todo'),
                    onPressed: () async {
                      if (isUpdate) {
                        await updateTodo(model, context);
                      } else {
                        await addTodo(model, context);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
        
      ),
    );
  }

  Future addTodo(AddTodoModel model, BuildContext context) async {
    try {
      await model.addTodoToFirebase();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('保存しました！'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]
          );
        }
      );
      Navigator.of(context).pop();
    } catch(e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]
          );
        }
      );
    }
  }

  Future updateTodo(AddTodoModel model, BuildContext context) async {
    try {
      await model.updateTodo(todo);
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update！'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]
          );
        }
      );
      Navigator.of(context).pop();
    } catch(e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]
          );
        }
      );
    }
  }
}