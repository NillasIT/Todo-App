import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Para serializar e desserializar a lista
import 'package:intl/intl.dart';

class TaskManager with ChangeNotifier {
  DateTime now = DateTime.now();
  List<List<dynamic>> todoList = [];
  List<Map<String, dynamic>> completedTasks = [];
  List<Map<String, dynamic>> uncompletedTasks = [];

  TaskManager() {
    loadTasks();
  }

  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedTasks = json.encode(todoList);
    prefs.setString('todoList', encodedTasks);
  }

  // * Carregar tarefas do Banco de Dados local, SharedPreferences
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
    updateIndexes(); // Atualiza os índices após carregar as tarefas
    notifyListeners();
  }

  void updateIndexes() {
    completedTasks = [];
    uncompletedTasks = [];

    for (int i = 0; i < todoList.length; i++) {
      var task = todoList[i];
      var taskWithIndex = {
        "task": task,
        "index": i
      }; // Inclui o índice original

      if (task[1]) {
        completedTasks.add(taskWithIndex);
      } else {
        uncompletedTasks.add(taskWithIndex);
      }
    }
  }

  void checkBox(int index) {
    todoList[index][1] = !todoList[index][1];
    updateIndexes(); // Atualiza os índices após mudança de status
    saveTasks();
    notifyListeners();
  }

  void addTask(String name, String description) {
    todoList.add([
      name,
      false,
      description,
      DateFormat('dd MMM yyyy, HH:mm').format(DateTime.now()).toString(),
    ]);
    updateIndexes(); // Atualiza os índices após adição de tarefa
    saveTasks();
    notifyListeners();
  }

  void updateTask(int index, String name, String description) {
    todoList[index][0] = name;
    todoList[index][2] = description;
    updateIndexes(); // Atualiza os índices após edição de tarefa
    saveTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    todoList.removeAt(index);
    updateIndexes(); // Atualiza os índices após remoção de tarefa
    saveTasks();
    notifyListeners();
  }
}
