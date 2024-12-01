import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutterosemeador/telas/telas_jogo_quebra_cabeca/selecao_imagem.dart'; // Importa o jogo da memória

class JogoQuebraCabecaEscolhaDificuldade extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: MouseRegion(
          child: const Text('Escolha a Dificuldade'),
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
                label: 'FÁCIL',
                icon: FontAwesomeIcons.smile,
                color: Colors.blue.shade300,
                dificuldade: 2,
              ),
              SizedBox(height: 20),
              _buildDifficultyButton(
                context,
                label: 'MÉDIO',
                icon: FontAwesomeIcons.handPeace,
                color: Colors.blue.shade500,
                dificuldade: 3,
              ),
              SizedBox(height: 20),
              _buildDifficultyButton(
                context,
                label: 'DIFÍCIL',
                icon: FontAwesomeIcons.fistRaised,
                color: Colors.blue.shade700,
                dificuldade: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(BuildContext context,
      {required String label,
      required IconData icon,
      required Color color,
      required int dificuldade}) {
    return MouseRegion(
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
              builder: (context) =>
                  JogoQuebraCabecaEscolhaImagem(dificuldade: dificuldade),
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
