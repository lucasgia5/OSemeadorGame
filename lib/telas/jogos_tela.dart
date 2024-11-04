import 'package:flutter/material.dart';
import 'package:flutterosemeador/telas/telas_formas_geometricas/dificuldades.dart';
import 'package:flutterosemeador/telas/telas_datas_comemorativas/datas_comemorativas.dart';

class JogosTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(36.0),
            child: Text(
              "Escolha seu jogo",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ),
          Container(
            height: 500,
            child: Center( // Centraliza os botões
              child: Container(
                width: 450,
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 28.0,
                  crossAxisSpacing: 23.0,
                  children: [
                    buildGameTile(context, "Datas Comemorativas", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PuzzleGameApp(),
                        ),
                      );
                    }),
                    buildGameTile(context, "Folclore", null),
                    buildGameTile(context, "Formas Geométricas", () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DifficultySelectionScreen(),
                        ),
                      );
                    }),
                    buildGameTile(context, "Futebol", null),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGameTile(BuildContext context, String title, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}