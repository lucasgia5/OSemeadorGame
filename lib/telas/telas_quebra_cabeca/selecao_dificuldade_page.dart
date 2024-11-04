import 'package:flutter/material.dart';
import 'selecao_quebra_cabeca_page.dart';
import 'package:flutterosemeador/telas/telas_quebra_cabeca/dificuldadeqc.dart';

class SelecaoDificuldadePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione a Dificuldade'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _botaoDificuldade(context, 'Fácil', Dificuldade.facil),
            _botaoDificuldade(context, 'Médio', Dificuldade.medio),
            _botaoDificuldade(context, 'Difícil', Dificuldade.dificil),
          ],
        ),
      ),
    );
  }

  // Botão para selecionar a dificuldade
  Widget _botaoDificuldade(BuildContext context, String titulo, Dificuldade dificuldade) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelecaoQuebraCabecaPage(dificuldade: dificuldade),
          ),
        );
      },
      child: Text(titulo),
    );
  }
}
