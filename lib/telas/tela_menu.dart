import 'package:flutter/material.dart';

class TelaMenu extends StatelessWidget {
  const TelaMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela Principal"),
        backgroundColor: Colors.orange, // Cor da AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegar para a tela de Jogos
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaJogos()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: Colors.orange,
              ),
              child: const Text(
                "JOGOS",
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navegar para a tela de Pontuação
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaPontuacao()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                "PONTUAÇÃO",
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navegar para a tela de Perguntas
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaPerguntas()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: Colors.green,
              ),
              child: const Text(
                "PERGUNTAS",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder para a Tela de Jogos
class TelaJogos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jogos"),
      ),
      body: const Center(child: Text("Aqui estão os jogos")),
    );
  }
}

// Placeholder para a Tela de Pontuação
class TelaPontuacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pontuação"),
      ),
      body: const Center(child: Text("Aqui está a pontuação")),
    );
  }
}

// Placeholder para a Tela de Perguntas
class TelaPerguntas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perguntas"),
      ),
      body: const Center(child: Text("Aqui estão as perguntas")),
    );
  }
}
