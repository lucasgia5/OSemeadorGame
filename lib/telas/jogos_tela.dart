import 'package:flutter/material.dart'; 
import 'package:flutterosemeador/componentes/flame_game_widget.dart'; // Importando a classe MyGame corretamente
import 'package:flame/game.dart'; // Isso importa o GameWidget corretamente.


// Classe principal que representa a tela de jogos
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
                  color: Colors.orange),
            ),
          ),
          Container( 
            height: 500,
            child: Row( 
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 100,
                      height: 200,
                      child: GameWidget( // Usando o GameWidget para carregar MyGame
                        game: MyGame(),
                      ),
                    ),
                  ),
                ),
                Container( 
                  height: 500,
                  width: 450,
                  child: GridView.count( 
                    crossAxisCount: 2,
                    mainAxisSpacing: 28.0,
                    crossAxisSpacing: 23.0,
                    children: [
                      buildGameTile("Datas Comemorativas"),
                      buildGameTile("Folclore"),
                      buildGameTile("Formas Geométricas"),
                      buildGameTile("Futebol"),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 100,
                      height: 200,
                      child: GameWidget( // Usando o GameWidget para carregar MyGame
                        game: MyGame(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            width: 250,
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: buildGameTile("Outro Jogo"),
          ),
        ],
      ),
    );
  }

  Widget buildGameTile(String title) {
    return Container(
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
              color: Colors.white),
        ),
      ),
    );
  }
}
