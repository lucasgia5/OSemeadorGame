import 'package:flutter/foundation.dart'; // Para usar kIsWeb
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutterosemeador/telas/jogos_tela.dart';

class MenuPrincipal extends StatelessWidget {
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Ícones de estrela decorativos nas laterais
            Positioned(
              top: 40,
              left: 20,
              child: Icon(Icons.star, color: Colors.orange.shade200, size: 40),
            ),
            Positioned(
              bottom: 80,
              right: 20,
              child: Icon(Icons.star, color: Colors.orange.shade200, size: 30),
            ),
            Positioned(
              top: 150,
              right: 60,
              child: Icon(Icons.star, color: Colors.orange.shade100, size: 30),
            ),
            Positioned(
              bottom: 150,
              left: 50,
              child: Icon(Icons.star, color: Colors.orange.shade100, size: 50),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Imagem no topo da coluna de botões
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Image.asset(
                      'assets/imagens/semeador_logo.png', // Caminho da imagem
                      height: 350, // Ajuste o tamanho conforme necessário
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Botão JOGAR
                  _buildButton(
                    label: 'JOGAR',
                    color: Colors.orange,
                    icon: Icons.play_arrow,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JogosTela(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 25),

                  // Botão PONTUAÇÃO
                  _buildButton(
                    label: 'PONTUAÇÃO',
                    color: Colors.white,
                    icon: Icons.leaderboard,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JogosTela(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 25),

                  // Botão TUTORIAL
                  _buildButton(
                    label: 'TUTORIAL',
                    color: Colors.orange,
                    icon: Icons.help_outline,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JogosTela(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para criar botões com acessibilidade
  Widget _buildButton({
    required String label,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      onEnter: (_) {
        if (kIsWeb) {
          speakWeb(label); // Usa a API Web Speech no navegador
        }
      },
      onExit: (_) {
        if (kIsWeb) {
          html.window.speechSynthesis?.cancel(); // Para a fala ao sair do botão
        }
      },
      child: SizedBox(
        width: 250,
        child: ElevatedButton.icon(
          icon: Icon(icon, color: Colors.blue.shade900, size: 32),
          label: Text(
            label,
            style: TextStyle(
              color: Colors.blue.shade900,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            shadowColor: Colors.orange.shade100,
            elevation: 8,
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
