import 'package:flutter/foundation.dart'; // Para usar kIsWeb
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutterosemeador/telas/telas_formas_geometricas/dificuldades.dart';
import 'package:flutterosemeador/telas/telas_datas_comemorativas/datas_comemorativas.dart';
import 'package:flutterosemeador/telas/telas_jogo_memoria/tela_inicial_memoria.dart';
import 'package:flutterosemeador/telas/menu.dart';
import 'package:flutterosemeador/telas/telas_jogo_quebra_cabeca/selecao_dificuldades.dart';

class JogosTela extends StatelessWidget {
  // Função para falar o texto no Flutter Web
  void speakWeb(String text) {
    html.window.speechSynthesis?.cancel();
    final utterance = html.SpeechSynthesisUtterance(text);
    utterance.lang = 'pt-BR';
    utterance.volume = 1.0;
    utterance.rate = 1.0;
    utterance.pitch = 1.0;
    html.window.speechSynthesis?.speak(utterance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MenuPrincipal()),
            );
          },
        ),
        title: Text(
          "Jogos",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.blue.shade700, // Fundo azul
      body: Column(
        children: [
          MouseRegion(
            onEnter: (_) {
              if (kIsWeb) {
                speakWeb("ESCOLHA SEU JOGO"); // Usa a API Web Speech no navegador
              }
            },
            onExit: (_) {
              if (kIsWeb) {
                html.window.speechSynthesis?.cancel(); // Para a fala ao sair do texto
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
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
                            builder: (context) => DatasComemorativas(),
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
                            builder: (context) => TelaInicialJogoDaMemoria(),
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JogoQuebraCabecaEscolhaDificuldade(),
                          ),
                        );
                      }, // Ainda sem ação
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
    return MouseRegion(
      onEnter: (_) {
        if (kIsWeb) {
          speakWeb(title); // Usa a API Web Speech no navegador para o título do botão
        }
      },
      onExit: (_) {
        if (kIsWeb) {
          html.window.speechSynthesis?.cancel(); // Para a fala ao sair do botão
        }
      },
      child: InkWell(
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
      ),
    );
  }
}
