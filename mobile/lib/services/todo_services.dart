import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/models/todo_model.dart';
import 'package:http/http.dart' as http;

class TodoProvider with ChangeNotifier {
  TodoProvider() {
    this.fetchTask();
  }

  List<TodoModel> _todos = [];

  List<TodoModel> get todos {
    return [..._todos];
  }

  void addTodo(TodoModel todo) async {
    final response = await http.post('http://192.168.43.203:8000/apis/v1/',
        headers: {"Content-Type": "application/json"}, body: json.encode(todo));
    if (response.statusCode == 201) {
      todo.id = json.decode(response.body)['id'];
      _todos.add(todo);
      notifyListeners();
    }
  }

  void deleteTodo(TodoModel todo) async {
    final response =
        await http.delete('http://192.168.43.203:8000/apis/v1/${todo.id}/');
    if (response.statusCode == 204) {
      _todos.remove(todo);
      notifyListeners();
    }
  }

  fetchTask() async {
    final url = 'http://192.168.43.203:8000/apis/v1/';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _todos = data.map<TodoModel>((json) => TodoModel.fromJson(json)).toList();
      notifyListeners();
    }
  }
}
