import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:html' as html;
import 'package:flutterosemeador/telas/telas_jogo_memoria/jogo_da_memoria.dart';
import 'package:flutterosemeador/telas/telas_jogo_memoria/personagens_memoria.dart';

class TelaInicial extends StatelessWidget {
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
      appBar: AppBar(
        title: MouseRegion(
          onEnter: (_) {
            speakWeb("Escolha a Dificuldade");
          },
          onExit: (_) {
            html.window.speechSynthesis?.cancel();
          },
          child: Text('Escolha a Dificuldade'),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDifficultyButton(
                context,
                label: 'Fácil',
                icon: FontAwesomeIcons.smile,
                color: Colors.blue.shade300,
                personagens: personagensFacil.cast<Personagem>(),
              ),
              SizedBox(height: 20),
              _buildDifficultyButton(
                context,
                label: 'Médio',
                icon: FontAwesomeIcons.handPeace,
                color: Colors.blue.shade500,
                personagens: personagensMedio.cast<Personagem>(),
              ),
              SizedBox(height: 20),
              _buildDifficultyButton(
                context,
                label: 'Difícil',
                icon: FontAwesomeIcons.fistRaised,
                color: Colors.blue.shade700,
                personagens: personagensDificil.cast<Personagem>(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(
      BuildContext context, {
      required String label,
      required IconData icon,
      required Color color,
      required List<Personagem> personagens,
    }) {
    return MouseRegion(
      onEnter: (_) {
        speakWeb(label); // Lê o texto do botão ao passar o mouse
      },
      onExit: (_) {
        html.window.speechSynthesis?.cancel();
      },
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JogoDaMemoria(personagens: personagens),
            ),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
