import 'package:flutter/material.dart';
import 'package:flutterosemeador/telas/jogos_tela.dart';
import 'package:flutterosemeador/telas/telas_jogo_memoria/jogo_da_memoria.dart';

class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fundo branco para destacar o logo azul escuro
      body: SafeArea(
        child: Stack(
          children: [
            // Elementos decorativos extras nas laterais
            Positioned(
              top: 40,
              left: 20,
              child: Icon(Icons.star, color: Colors.orange.shade200, size: 40),
            ),
            Positioned(
              bottom: 80,
              right: 20,
              child: Icon(Icons.circle, color: Colors.orange.shade200, size: 30),
            ),
            Positioned(
              top: 150,
              right: 60,
              child: Icon(Icons.favorite, color: Colors.orange.shade100, size: 30),
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
                  // Imagem central no topo
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Image.asset(
                      'assets/imagens/semeador_logo.png',
                      height: 350, // Aumentado para dar mais destaque
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
                  SizedBox(height: 25), // Aumentado para maior espaçamento entre botões

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

  // Função para criar botões personalizados
  Widget _buildButton({
    required String label,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 250, // Largura aumentada
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.blue.shade900, size: 32), // Ícone um pouco maior
        label: Text(
          label,
          style: TextStyle(
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 22, // Fonte um pouco maior
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 20), // Altura aumentada
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          shadowColor: Colors.orange.shade100,
          elevation: 8,
        ),
        onPressed: onTap,
      ),
    );
  }
}
