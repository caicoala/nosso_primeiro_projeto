import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/difficulty.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;
  int maestria = 0;

  Task(this.nome, this.foto, this.dificuldade, {super.key});

  int nivel = 0;
  int nivelMaximo = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  Color? containerProgressBarColor = Colors.yellow;

  bool assetOrNetwork() {
    return !widget.foto.contains('http');
  }

  @override
  Widget build(BuildContext context) {
    widget.nivelMaximo = widget.dificuldade * 10;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                color: containerProgressBarColor),
          ),
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                    color: Colors.white),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 72,
                      height: 100,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: Colors.black26),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: assetOrNetwork()
                              ? Image.asset(widget.foto, fit: BoxFit.cover)
                              : Image.network(
                                  widget.foto,
                                  fit: BoxFit.cover,
                                )),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(
                              widget.nome,
                              style: const TextStyle(
                                  fontSize: 24,
                                  overflow: TextOverflow.ellipsis),
                            )),
                        Difficulty(difficultyLevel: widget.dificuldade)
                      ],
                    ),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (widget.nivel == widget.nivelMaximo) {
                              widget.nivel = 0;
                              widget.maestria++;
                              containerProgressBarColor =
                                  ColorContainerProgressBar.values
                                          .where((x) => x.code == widget.maestria)
                                          .first
                                          .color ??
                                      Colors.yellow;
                            } else {
                              widget.nivel++;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(47, 128, 237, 1),
                          // Cor de fundo
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.arrow_drop_up,
                                color: Color.fromRGBO(242, 242, 242, 1)),
                            Text('Up', style: TextStyle(fontSize: 12))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                          color: Colors.white,
                          value: widget.nivelMaximo > 0 ? widget.nivel / widget.nivelMaximo : 1,
                          backgroundColor: Colors.white38),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Nivel ${widget.nivel}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

enum ColorContainerProgressBar {
  orange(Colors.orange, 1),
  green(Colors.green, 2),
  blue(Colors.blue, 3),
  purple(Colors.purple, 4),
  brown(Colors.brown, 5),
  black(Colors.black, 6);

  final Color? color;
  final int code;

  const ColorContainerProgressBar(this.color, this.code);
}
