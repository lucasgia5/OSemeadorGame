import 'package:flutter/material.dart';
import 'quebra_cabeca_page.dart';
import 'package:flutterosemeador/telas/telas_quebra_cabeca/dificuldadeqc.dart';

class SelecaoQuebraCabecaPage extends StatelessWidget {
  final Dificuldade dificuldade;

  SelecaoQuebraCabecaPage({required this.dificuldade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha um Quebra-Cabeça - ${_nomeDificuldade(dificuldade)}'),
      ),
      body: ListView(
        children: [
          _buildQuebraCabecaOption(context, 'Futebol', 'futebol'),
          _buildQuebraCabecaOption(context, 'Basquete', 'basquete'),
          _buildQuebraCabecaOption(context, 'Vôlei', 'volei'),
        ],
      ),
    );
  }

  Widget _buildQuebraCabecaOption(BuildContext context, String titulo, String esporte) {
    return ListTile(
      title: Text(titulo),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuebraCabecaPage(
              dificuldade: dificuldade,
              esporte: esporte,
            ),
          ),
        );
      },
    );
  }

  String _nomeDificuldade(Dificuldade dificuldade) {
    switch (dificuldade) {
      case Dificuldade.facil:
        return 'Fácil';
      case Dificuldade.medio:
        return 'Médio';
      case Dificuldade.dificil:
        return 'Difícil';
    }
  }
}
