import 'package:flutter/material.dart';
import 'package:flutterosemeador/telas/telas_jogo_memoria/personagens_memoria.dart'; // Importa a classe Personagem
import 'package:confetti/confetti.dart';

class JogoDaMemoria extends StatefulWidget {
  final List<Personagem> personagens;

  JogoDaMemoria({required this.personagens});

  @override
  _JogoDaMemoriaState createState() => _JogoDaMemoriaState();
}

class _JogoDaMemoriaState extends State<JogoDaMemoria> with TickerProviderStateMixin {
  late List<Personagem> cartas;
  List<bool> cartasReveladas = [];
  List<bool> cartasCorretas = []; // Novo estado para rastrear cartas corretas
  Personagem? primeiraCarta;
  int primeiraCartaIndex = -1;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    cartas = gerarCartas(widget.personagens);
    cartasReveladas = List.generate(cartas.length, (index) => false);
    cartasCorretas = List.generate(cartas.length, (index) => false); // Inicializa as cartas corretas
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void verificarPar(int index) {
    setState(() {
      cartasReveladas[index] = true;
    });

    if (primeiraCarta == null) {
      primeiraCarta = cartas[index];
      primeiraCartaIndex = index;
    } else {
      if (primeiraCarta!.nome == cartas[index].nome && primeiraCartaIndex != index) {
        // Encontrou um par
        cartasCorretas[primeiraCartaIndex] = true; // Marca a primeira carta como correta
        cartasCorretas[index] = true; // Marca a segunda carta como correta
        primeiraCarta = null;
        // Verifica se todos os pares foram encontrados
        if (cartasReveladas.every((revelada) => revelada)) {
          _onGameCompleted(); // Mostra os confetes e o popup
        }
      } else {
        // Não é par, esconde as cartas novamente
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            cartasReveladas[primeiraCartaIndex] = false;
            cartasReveladas[index] = false;
          });
          primeiraCarta = null;
        });
      }
    }
  }

void _onGameCompleted() {
  _confettiController.play();
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Parabéns!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        content: const Text('Você completou o jogo da memória!'),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue[900],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
            onPressed: () async {
              // Fecha o pop-up primeiro
              Navigator.of(context).pop();

              // Adiciona um pequeno delay para garantir que o pop-up foi fechado
              await Future.delayed(Duration(milliseconds: 300));

              // Reinicia o jogo
              setState(() {
                cartas = gerarCartas(widget.personagens);
                cartasReveladas = List.generate(cartas.length, (index) => false);
                cartasCorretas = List.generate(cartas.length, (index) => false); // Reinicia o estado das cartas corretas
                primeiraCarta = null; // Reseta a primeira carta
                primeiraCartaIndex = -1; // Reseta o índice da primeira carta
              });

              // Reinicia os fogos para o próximo uso
              _confettiController.stop();
            },
            child: const Text(
              'Reiniciar Jogo',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    // Obtém a largura total da tela
    double screenWidth = MediaQuery.of(context).size.width;

    // Define o número de colunas e o aspecto das cartas com base na dificuldade
    int numColumns;
    double aspectRatio;
    if (widget.personagens.length == 3) {
      numColumns = 3; // Fácil: 3 colunas
      aspectRatio = 1.5; // Ajusta para que as cartas fiquem menores em altura
    } else if (widget.personagens.length == 5) {
      numColumns = 5; // Médio: 5 colunas
      aspectRatio = 1; // Médio e Difícil permanecem quadradas
    } else {
      numColumns = 7; // Difícil: 7 colunas
      aspectRatio = 0.7;
    }

    // Calcula o tamanho das cartas com base na largura da tela e no número de colunas
    double cardSize = (screenWidth / numColumns) - 12; // Inclui espaçamento

    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Memória - Folclore Brasileiro'),
      ),
      body: Stack(
        children: [
          GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: numColumns,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: aspectRatio, // Ajusta proporção para cartas menores no fácil
            ),
            itemCount: cartas.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: cartasReveladas[index]
                    ? null
                    : () {
                        verificarPar(index);
                      },
                child: Container(
                  width: cardSize,
                  height: cardSize,
                  decoration: BoxDecoration(
                    color: cartasCorretas[index] ? Colors.green : Colors.blue, // Atualiza a cor se for correta
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: cartasReveladas[index]
                      ? Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            cartas[index].imagem,
                            fit: BoxFit.contain,
                            width: cardSize * 0.7,
                            height: cardSize * 0.7,
                          ),
                        )
                      : Icon(Icons.help_outline, color: Colors.white, size: cardSize / 2),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: [Colors.red, Colors.green, Colors.blue, Colors.purple],
            ),
          ),
        ],
      ),
    );
  }
}

// Função para gerar cartas embaralhadas
List<Personagem> gerarCartas(List<Personagem> personagens) {
  List<Personagem> cartas = [...personagens, ...personagens];
  cartas.shuffle();
  return cartas;
}
