import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutterosemeador/telas/telas_jogo_quebra_cabeca/jogo/carregarImagensEFragmentar.dart';
import 'package:flutterosemeador/telas/telas_jogo_quebra_cabeca/sucesso.dart';
import 'dart:math';

class JogoQuebraCabeca extends StatefulWidget {
  final int dificuldade;
  final int imagem;
  final List<String> imagens = [
    'assets/imagens/quebra_cabeca/bolinha.png',
    'assets/imagens/quebra_cabeca/gol quadrado.png',
    'assets/imagens/quebra_cabeca/jogadores.png',
  ];

  JogoQuebraCabeca({required this.dificuldade, required this.imagem});

  @override
  _JogoQuebraCabecaState createState() => _JogoQuebraCabecaState();
}

class _JogoQuebraCabecaState extends State<JogoQuebraCabeca> {
  late int dificuldade;
  late int imagemIndex;

  List<PedacoImagem> imagePieces = [];
  List<int> embaralhado = [];
  List<int> usados = [];
  List<PedacoImagem> imagePiecesColocados = [];
  late double pieceSize;

  @override
  void initState() {
    super.initState();
    dificuldade = widget.dificuldade;
    imagemIndex = widget.imagem;
    carregarImagensEFragmentar(
      imagePieces: imagePieces,
      imagePiecesColocados: imagePiecesColocados,
      dificuldade: dificuldade,
      imagemIndex: imagemIndex,
      imagens: widget.imagens,
      embaralharImagens: _embaralharImagens,
      setState: setState,
    );

    pieceSize = 1 + (((3 - dificuldade) / 10) * 2.5);
  }

  Future<void> _embaralharImagens() async {
    embaralhado = List<int>.generate(imagePieces.length, (index) => index);
    embaralhado.shuffle(Random());
  }

  Future<void> validar() async {
    if (usados.length == dificuldade * dificuldade) {
      bool sucesso = true;
      for (int i = 0; i < imagePieces.length; i++) {
        if (imagePiecesColocados[i].index != imagePieces[i].index) {
          sucesso = false;
          break;
        }
      }
      if (sucesso) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JogoQuebraCabecaSucesso(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogando Quebra Cabeça'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Quebra Cabeça.
            if (imagePieces.isNotEmpty)
              Center(
                child: SizedBox(
                  width: dificuldade * 32.0 * pieceSize * 2,
                  height: dificuldade * 32.0 * pieceSize * 2,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: dificuldade,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: imagePieces.length,
                      itemBuilder: (context, index) {
                        return DragTarget<int>(
                          onAccept: (data) {
                            setState(() {
                              if (!imagePiecesColocados[index].colocado) {
                                PedacoImagem pedacoImagem =
                                    imagePieces[embaralhado[data]];

                                imagePiecesColocados[index].ints =
                                    pedacoImagem.ints;
                                imagePiecesColocados[index].posX =
                                    pedacoImagem.posX;
                                imagePiecesColocados[index].posY =
                                    pedacoImagem.posY;
                                imagePiecesColocados[index].index =
                                    pedacoImagem.index;

                                imagePiecesColocados[index].colocado = true;
                                imagePiecesColocados[index]
                                    .originalEmbaralhado = data;
                                usados.add(data);
                                validar();
                              }
                            });
                          },
                          builder: (context, candidateData, rejectedData) {
                            return GestureDetector(
                              onDoubleTap: () {
                                setState(() {
                                  if (imagePiecesColocados[index].colocado) {
                                    int data = imagePiecesColocados[index]
                                        .originalEmbaralhado;
                                    usados.remove(data);
                                    imagePiecesColocados[index]
                                        .originalEmbaralhado = 0;
                                    imagePiecesColocados[index].colocado =
                                        false;
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFF999999), width: 1),
                                ),
                                child: imagePiecesColocados[index].colocado
                                    ? Image.memory(
                                        imagePiecesColocados[index].ints,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(color: Colors.grey),
                              ),
                            );
                          },
                        );
                      }),
                ),
              ),

            // Espaçamento de 50px entre o quebra-cabeça e as peças
            SizedBox(height: 50),

            // Peças
            Center(
              child: SizedBox(
                width: dificuldade * 32.0 * pieceSize * 4,
                height: dificuldade * 32.0 * pieceSize * 4,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: dificuldade * 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: imagePieces.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF999999), width: 1),
                      ),
                      child: !usados.contains(index)
                          ? Draggable<int>(
                              data: index,
                              child: Image.memory(
                                imagePieces[embaralhado[index]].ints,
                                fit: BoxFit.cover,
                              ),
                              feedback: Image.memory(
                                imagePieces[embaralhado[index]].ints,
                                fit: BoxFit.cover,
                                width: 30,
                                height: 30,
                              ),
                              childWhenDragging: Container(color: Colors.grey),
                            )
                          : Container(color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
