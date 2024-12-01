import 'package:flutter/material.dart';
import 'package:flutterosemeador/telas/telas_jogo_quebra_cabeca/jogo.dart';

class EscolhaImagem extends StatefulWidget {
  final int dificuldade;

  EscolhaImagem({required this.dificuldade});

  @override
  _EscolhaImagemState createState() => _EscolhaImagemState();
}

class _EscolhaImagemState extends State<EscolhaImagem> {
  late int dificuldade;
  final List<String> imagens = [
    'assets/imagens/quebra_cabeca/bolinha.png',
    'assets/imagens/quebra_cabeca/gol quadrado.png',
    'assets/imagens/quebra_cabeca/jogadores.png',
  ];

  @override
  void initState() {
    super.initState();
    dificuldade = widget.dificuldade;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double imageSize = constraints.maxWidth > 600 ? 400 : 200;

            if (constraints.maxWidth > 600) {
              // Layout para PC
              return GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Três imagens lado a lado
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: imagens.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JogoQuebraCabeca(
                              dificuldade: this.dificuldade, imagem: index),
                        ),
                      );
                    },
                    child: Container(
                      width: imageSize,
                      height: imageSize,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF999999), width: 1),
                      ),
                      child: Image.asset(
                        imagens[index],
                        fit: BoxFit.cover, // Ajusta a imagem para cobrir o espaço disponível
                      ),
                    ),
                  );
                },
              );
            } else {
              // Layout para dispositivos móveis
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(imagens.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JogoQuebraCabeca(
                              dificuldade: this.dificuldade, imagem: index),
                        ),
                      );
                    },
                    child: Container(
                      width: imageSize,
                      height: imageSize,
                      margin: EdgeInsets.only(bottom: 10), // Espaço entre as imagens
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF999999), width: 1),
                      ),
                      child: Image.asset(
                        imagens[index],
                        fit: BoxFit.cover, // Ajusta a imagem para cobrir o espaço disponível
                      ),
                    ),
                  );
                }),
              );
            }
          },
        ),
      ),
    );
  }
}
