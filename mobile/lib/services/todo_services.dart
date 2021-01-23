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

  fetchTask() async {
    final url = 'http://192.168.43.203:8000/apis/v1';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _todos = data.map<TodoModel>((json) => TodoModel.fromJson(json)).toList();
      notifyListeners();
    }
  }
}
