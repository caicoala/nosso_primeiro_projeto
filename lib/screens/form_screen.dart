import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/data/task_inherited.dart';

class FormScreeen extends StatefulWidget {
  const FormScreeen({required this.taskContext, super.key});
  final BuildContext taskContext;
  @override
  State<FormScreeen> createState() => _FormScreeenState();
}

class _FormScreeenState extends State<FormScreeen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dificultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool valueStringValidator(String? value){
    return value != null && value.isEmpty;
  }

  bool valueIntValidator(String? value){
      return valueStringValidator(value) || int.parse(value ?? '0') > 5 || int.parse(value ?? '0') < 1;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nova Tarefa'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 650,
              width: 375,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 3)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (valueStringValidator(value)) {
                          return 'Insira o nome da tarefa';
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nome',
                          fillColor: Colors.white70,
                          filled: true),
                      textAlign: TextAlign.center,
                      controller: nameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (valueIntValidator(value)) {
                          return 'Insira uma dificuldade entre 1 e 5';
                        }

                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Dificuldade',
                          fillColor: Colors.white70,
                          filled: true),
                      textAlign: TextAlign.center,
                      controller: dificultyController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (valueStringValidator(value)) {
                          return 'Insira a url de imagem';
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Imagem',
                          fillColor: Colors.white70,
                          filled: true),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.url,
                      controller: imageController,
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 72,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Colors.blue),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(imageController.text, errorBuilder:
                          (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                        return Image.asset('assets/images/nophoto.png');
                      }, fit: BoxFit.cover),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          TaskInherited.of(widget.taskContext).newTask(nameController.text, imageController.text, int.parse(dificultyController.text));
                          ScaffoldMessenger.of(widget.taskContext).showSnackBar(
                            const SnackBar(
                              content: Text('Tarefa criada com sucesso'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Adicionar!'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
