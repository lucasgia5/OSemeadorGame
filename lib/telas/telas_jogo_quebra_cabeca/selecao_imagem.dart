import 'package:flutter/material.dart';
import 'package:flutterosemeador/telas/telas_jogo_quebra_cabeca/imagens.dart'; // Importa o jogo da memória

class JogoQuebraCabecaEscolhaImagem extends StatefulWidget {
  final int dificuldade;

  JogoQuebraCabecaEscolhaImagem({required this.dificuldade});

  @override
  _JogoQuebraCabecaEscolhaImagemState createState() => _JogoQuebraCabecaEscolhaImagemState();
}

class _JogoQuebraCabecaEscolhaImagemState extends State<JogoQuebraCabecaEscolhaImagem> {
  late int dificuldade;

  @override
  void initState() {
    super.initState();
    dificuldade = widget.dificuldade;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha a Imagem'),
      ),
      body: EscolhaImagem(dificuldade: dificuldade),
    );
  }
}
