import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_app_firebase4/domain/todo.dart';


class AddTodoModel extends ChangeNotifier {
  String todoTitle = '';

  Future addTodoToFirebase() async {
    if (todoTitle.isEmpty) {
      throw ('タイトルを入力してください');
    }
    Firestore.instance.collection('todo').add(
      {
        'title' : todoTitle,
      },
    );
  }

  Future updateTodo(Todo todo) async {
    final document = Firestore.instance.collection('todo').document(todo.documentID);
    await document.updateData({
      'title' : todoTitle,
      'updateAt' : Timestamp.now(),
    });
  }
}