import 'package:flutter/material.dart';
import 'package:flutterosemeador/telas/telas_formas_geometricas/dificuldades.dart';
import 'package:flutterosemeador/telas/telas_datas_comemorativas/datas_comemorativas.dart';
import 'package:flutterosemeador/telas/telas_jogo_memoria/tela_inicial_memoria.dart';

class JogosTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700, // Fundo azul
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
            child: Text(
              "ESCOLHA SEU JOGO",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                letterSpacing: 2,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 2.5, // Define a proporção dos botões
                  children: [
                    buildGameTile(
                      context,
                      title: "DATAS COMEMORATIVAS",
                      icon: Icons.event,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PuzzleGameApp(),
                          ),
                        );
                      },
                    ),
                    buildGameTile(
                      context,
                      title: "FOLCLORE",
                      icon: Icons.landscape,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaInicial(),
                          ),
                        );
                      },
                    ),
                    buildGameTile(
                      context,
                      title: "FORMAS GEOMÉTRICAS",
                      icon: Icons.category,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DifficultySelectionScreen(),
                          ),
                        );
                      },
                    ),
                    buildGameTile(
                      context,
                      title: "FUTEBOL",
                      icon: Icons.sports_soccer,
                      onTap: null, // Ainda sem ação
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGameTile(BuildContext context, {required String title, required IconData icon, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white), // Ícone menor
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14, // Tamanho de fonte reduzido
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
