import 'package:nosso_primeiro_projeto/data/database.dart';
import 'package:sqflite/sqflite.dart';

import '../components/task.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER,'
      '$_image TXT)';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task tarefa) async {
    print('Iniciando o save');
    final Database database = await getDatabase();
    var itemExists = await getByName(tarefa.nome);
    if (itemExists.isEmpty) {
      print('Item novo');
      return await database.insert(TaskDao._tablename, taskToMap(tarefa));
    } else {
      print('Tarefa já existe');
      return await database.update(TaskDao._tablename, taskToMap(tarefa),
          where: '$_name = ?', whereArgs: [tarefa.nome]);
    }
  }

  Future<List<Task>> getAll() async {
    print('Acessando o getall');

    final Database database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(_tablename);
    print('dados encontrados: $result');

    return mapToTasks(result);
  }

  List<Task> mapToTasks(List<Map<String, dynamic>> listaDeTarefas) {
    print('Convertendo to list');
    final List<Task> tasks = [];

    for (var task in listaDeTarefas) {
      tasks.add(Task(task[_name], task[_image], task[_difficulty]));
    }

    return tasks;
  }

  Future<List<Task>> getByName(String taskName) async {
    final Database database = await getDatabase();

    var result = await database
        .query(_tablename, where: '$_name = ?', whereArgs: [taskName]);
    return mapToTasks(result);
  }

  delete(String taskName) async {
    final Database database = await getDatabase();

    return await database
        .delete(_tablename, where: '$_name = ?', whereArgs: [taskName]);
  }

  Map<String, dynamic> taskToMap(Task tarefa) {
    final Map<String, dynamic> mapaTarefa = {};
    mapaTarefa[_name] = tarefa.nome;
    mapaTarefa[_difficulty] = tarefa.dificuldade;
    mapaTarefa[_image] = tarefa.foto;

    return mapaTarefa;
  }
}
