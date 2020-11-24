import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_app_firebase4/domain/todo.dart';

class TodoListModel extends ChangeNotifier {
  List<Todo> todos = [];

  Future fetchTodos() async {
    final docs = await Firestore.instance.collection('todo').getDocuments();
    final todos = docs.documents.map((doc) => Todo(doc)).toList();
    this.todos = todos;
    notifyListeners();
  }

  Future deleteTodo(Todo todo) async {
    await Firestore.instance
        .collection('todo')
        .document(todo.documentID)
        .delete();
  }
}