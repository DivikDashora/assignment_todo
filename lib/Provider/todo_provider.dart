import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:todo_assignment/Database/todo_db.dart';
import 'package:todo_assignment/Models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  TextEditingController controller = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  List<TodoModel> todoList = [];

  Future<void> addTask(BuildContext context) async {
    // await _dbHelper.close();
    if (key.currentState!.validate()) {
      await _dbHelper.addTask(controller.text);

      await getTasks();
      controller.clear();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Task Added Successfully! Tap to edit.')));
    }
  }

  Future<void> editTask(BuildContext context, int id) async {
    // await _dbHelper.close();
    notifyListeners();
    if (key.currentState!.validate()) {
      log(controller.text);
      await _dbHelper.editTask(id, controller.text).then((val) {
        log(val.toString());
      });

      await getTasks();
      controller.clear();
      Navigator.pop(context);
    }
  }

  Future<void> markAsDone(int id) async {
    await _dbHelper.markTaskDone(id);

    getTasks();
  }

  Future<void> getTasks() async {
    List<Map<String, dynamic>> tuples = await _dbHelper.getTasks();
    todoList = [];
    log(tuples.toString());
    todoList = tuples
        .map((i) => TodoModel(
            id: i["id"],
            date: i["date"],
            isComplete: i['isComplete'],
            title: i['title']))
        .toList();
    notifyListeners();
  }

  List<TodoModel> get getTodoList => todoList;
}
