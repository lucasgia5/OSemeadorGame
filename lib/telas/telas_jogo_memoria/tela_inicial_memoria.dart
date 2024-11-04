import 'package:flutter/material.dart';
import 'package:flutterosemeador/telas/telas_jogo_memoria/jogo_da_memoria.dart'; // Importa o jogo da memória
import 'package:flutterosemeador/telas/telas_jogo_memoria/personagens_memoria.dart'; // Importa as listas de personagens

class TelaInicial extends StatelessWidget {
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
                    builder: (context) => JogoDaMemoria(personagens: personagensFacil),
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
                    builder: (context) => JogoDaMemoria(personagens: personagensMedio),
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
                    builder: (context) => JogoDaMemoria(personagens: personagensDificil),
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