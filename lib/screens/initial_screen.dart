import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/data/task_inherited.dart';
import 'package:nosso_primeiro_projeto/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  double nivelGlobal = 0.0;
  double nivelGlobalMaximo = 0.0;

  double getGlobalLevel(){
    nivelGlobal = 0.0;
    TaskInherited.of(context).taskList.forEach((task){
      nivelGlobal = nivelGlobal + (task.dificuldade * ((task.nivel + (task.maestria * task.nivelMaximo))) / 10);
      nivelGlobalMaximo += task.dificuldade * 10;
    });
    return nivelGlobal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(208, 221, 237, 1),
      appBar: AppBar(
        title: Row(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Row(
                children: [
                  Text('Tarefas',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.start),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                        color: Colors.white,
                        value: nivelGlobalMaximo > 0 ? nivelGlobal / nivelGlobalMaximo : 1,
                        backgroundColor: Colors.white38),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Level ${nivelGlobal.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ),
                ],
              ),
            ]),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      nivelGlobal = getGlobalLevel();
                    });
                  },
                  icon: const Icon(Icons.autorenew_outlined),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(47, 128, 237, 1),
                    // Cor de fundo
                  ),
                )
              ],
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(47, 128, 237, 1),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        children: TaskInherited.of(context).taskList,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contextNew) => FormScreeen(
                        taskContext: context,
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
