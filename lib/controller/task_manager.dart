import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';  // Para serializar e desserializar a lista
import 'package:intl/intl.dart';

class TaskManager with ChangeNotifier{
  DateTime now = DateTime.now();
  //String formattedDate = DateFormat("EEEE, dd MMM yyyy").format(now);
  List<List<dynamic>> todoList = [];

  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedTasks = json.encode(todoList);
    prefs.setString('todoList', encodedTasks);
  }
  
  // Carregar tarefas do SharedPreferences
  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedTasks = prefs.getString('todoList');

    if (storedTasks != null) {
      List<dynamic> decodedList = json.decode(storedTasks);
      todoList = decodedList.map((task) => List<dynamic>.from(task)).toList();
    } else {
      // Caso não haja nada armazenado, a lista inicial será usada
      todoList = [
        [
          "Tap plus to add new task",
          false,
          "Task description!",
          DateFormat('dd MMM yyyy, HH:mm').format(DateTime.now()).toString(),
        ],
      ];
    }
    notifyListeners();
  }

  void checkBox(int index) {
    todoList[index][1] = !todoList[index][1];
    saveTasks();
    notifyListeners();
  }

  void addTask(String name, String description) {
    todoList.add(
      [
        name,
        false,
        description,
        DateFormat('dd MMM yyyy, HH:mm').format(DateTime.now()).toString(),
      ]
    );
    saveTasks();
    notifyListeners();
  }


  void updateTask(int index, String name, String description) {
    todoList[index][0] = name;
    todoList[index][2] = description;
    saveTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    todoList.removeAt(index);
    saveTasks();
    notifyListeners();
  }
}