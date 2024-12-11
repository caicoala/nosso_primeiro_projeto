import 'package:flutter/material.dart';
import '../components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required super.child,
  });

  final List<Task> taskList = [
    Task(
        'Aprender Flutter',
        'assets/images/estudar.png',
        3),
    Task(
        'Pegar radiante',
        'assets/images/estudar.png',
        4),
    Task(
        'Fechar o passe',
        'assets/images/estudar.png',
        2),
    Task(
        'Aprender Flutter',
        'assets/images/estudar.png',
        5),
    Task(
        'Pegar radiante',
        'assets/images/estudar.png',
        4),
    Task(
        'Fechar o passe',
        'assets/images/estudar.png',
        1),
  ];

  void newTask(String name, String photo, int difficulty){
    taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result = context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}