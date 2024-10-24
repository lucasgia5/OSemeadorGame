// arquivo dificuldades
import 'package:flutter/material.dart';
import 'formas_geometricas.dart';  // Importando o arquivo com a lógica do jogo

void main() => runApp(ShapeLinkerGame());

class ShapeLinkerGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shape Linker Game',
      home: DifficultySelectionScreen(), // Tela de seleção de dificuldade é a inicial
    );
  }
}

class DifficultySelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha a Dificuldade'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Iniciar o jogo com dificuldade fácil
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen(difficulty: 'easy')),  // Usa GameScreen do formas_geometricas.dart
                );
              },
              child: Text('Fácil'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Iniciar o jogo com dificuldade média
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen(difficulty: 'medium')),  // Usa GameScreen do formas_geometricas.dart
                );
              },
              child: Text('Médio'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Iniciar o jogo com dificuldade difícil
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen(difficulty: 'hard')),  // Usa GameScreen do formas_geometricas.dart
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
