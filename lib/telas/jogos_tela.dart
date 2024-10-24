import 'package:flutter/material.dart'; 
import 'package:flutterosemeador/componentes/flame_game_widget.dart'; // Importando a classe MyGame corretamente
import 'package:flame/game.dart'; // Isso importa o GameWidget corretamente.
import 'package:flutterosemeador/telas/telas_formas_geometricas/dificuldades.dart'; // Importe a tela de seleção de dificuldade

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
                      buildGameTile(context, "Datas Comemorativas", null),
                      buildGameTile(context, "Folclore", null),
                      buildGameTile(context, "Formas Geométricas", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DifficultySelectionScreen(),
                          ),
                        );
                      }), // Adicionando a navegação para "Formas Geométricas"
                      buildGameTile(context, "Futebol", null),
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
            child: buildGameTile(context, "Outro Jogo", null),
          ),
        ],
      ),
    );
  }

  Widget buildGameTile(BuildContext context, String title, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap, // Chama o onTap se não for null
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
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
