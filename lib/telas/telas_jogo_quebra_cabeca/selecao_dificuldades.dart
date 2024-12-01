import 'package:flutter/material.dart';
import 'package:flutterosemeador/telas/telas_jogo_quebra_cabeca/selecao_imagem.dart'; // Importa o jogo da memória

class JogoQuebraCabecaEscolhaDificuldade extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha a Dificuldade'),
      ),
      body: Center( // Adiciona o Center aqui
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JogoQuebraCabecaEscolhaImagem(
                      dificuldade: 2
                    ),
                  ),
                );
              },
              child: Text('Fácil'),
            ),
            SizedBox(height: 20), // Adiciona um espaço entre os botões
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JogoQuebraCabecaEscolhaImagem(
                      dificuldade: 3),
                  ),
                );
              },
              child: Text('Médio'),
            ),
            SizedBox(height: 20), // Adiciona um espaço entre os botões
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JogoQuebraCabecaEscolhaImagem(
                      dificuldade: 4),
                  ),
                );
              },
              child: Text('Difícil'),
            ),
          ],
        ),
      ),
    );
  }
}