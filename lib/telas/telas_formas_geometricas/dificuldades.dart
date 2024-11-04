import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'formas_geometricas.dart';

void main() => runApp(ShapeLinkerGame());

class ShapeLinkerGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shape Linker Game',
      home: DifficultySelectionScreen(),
    );
  }
}

class DifficultySelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Escolha a Dificuldade'),
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
                difficulty: 'easy',
              ),
              SizedBox(height: 20),
              _buildDifficultyButton(
                context,
                label: 'Médio',
                icon: FontAwesomeIcons.handPeace,
                color: Colors.blue.shade500,
                difficulty: 'medium',
              ),
              SizedBox(height: 20),
              _buildDifficultyButton(
                context,
                label: 'Difícil',
                icon: FontAwesomeIcons.fistRaised,
                color: Colors.blue.shade700,
                difficulty: 'hard',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(BuildContext context, {required String label, required IconData icon, required Color color, required String difficulty}) {
    return ElevatedButton(
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
          MaterialPageRoute(builder: (context) => GameScreen(difficulty: difficulty)),
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
    );
  }
}
