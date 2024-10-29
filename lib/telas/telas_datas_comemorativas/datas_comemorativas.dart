import 'package:flutter/material.dart';
import 'package:flutterosemeador/telas/jogos_tela.dart';  // Importa o arquivo jogos_tela.dart

void main() {
  runApp(const PuzzleGameApp());
}

class PuzzleGameApp extends StatelessWidget {
  const PuzzleGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Puzzle de Datas Comemorativas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DifficultySelectionScreenDatas(),
    );
  }
}

class DifficultySelectionScreenDatas extends StatelessWidget {
  const DifficultySelectionScreenDatas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleção de Dificuldade'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => JogosTela()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PuzzleGameScreen(difficulty: 'Fácil')),
                );
              },
              child: const Text('Fácil'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PuzzleGameScreen(difficulty: 'Médio')),
                );
              },
              child: const Text('Médio'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PuzzleGameScreen(difficulty: 'Difícil')),
                );
              },
              child: const Text('Difícil'),
            ),
          ],
        ),
      ),
    );
  }
}


class PuzzleGameScreen extends StatefulWidget {
  final String difficulty;
  const PuzzleGameScreen({Key? key, required this.difficulty}) : super(key: key);

  @override
  State<PuzzleGameScreen> createState() => _PuzzleGameScreenState();
}

class _PuzzleGameScreenState extends State<PuzzleGameScreen> {
  final List<PuzzleLevel> _allLevels = [
    PuzzleLevel(difficulty: 'Fácil', puzzle: 'N A T _ _', answer: 'NATAL', imagePath: 'assets/imagens/datas_comemorativas/papai_noel_correto.png'),
    PuzzleLevel(difficulty: 'Fácil', puzzle: 'A N _ N _ _ O', answer: 'ANO NOVO', imagePath: 'assets/ano_novo.png'),
    PuzzleLevel(difficulty: 'Fácil', puzzle: 'P A _ C _ A', answer: 'PASCOA', imagePath: 'assets/pascoa.png'),
    PuzzleLevel(difficulty: 'Médio', puzzle: 'D I _ D _ S C R I _ _ Ç _ S', answer: 'DIA DAS CRIANCAS', imagePath: 'assets/dia_das_criancas.png'),
    PuzzleLevel(difficulty: 'Médio', puzzle: 'H A L _ _ W _ _ _', answer: 'HALLOWEEN', imagePath: 'assets/halloween.png'),
    PuzzleLevel(difficulty: 'Médio', puzzle: 'T I R _ _ _ N T E _', answer: 'TIRADENTES', imagePath: 'assets/tiradentes.png'),
    PuzzleLevel(difficulty: 'Difícil', puzzle: 'P R O C _ _ M A Ç Ã _  D _ R E P _ _ _ _ C A', answer: 'PROCLAMACAO DA REPUBLICA', imagePath: 'assets/proclamacao_republica.png'),
    PuzzleLevel(difficulty: 'Difícil', puzzle: 'C O N S _ _ _ _ C I A  N E G_ _', answer: 'CONSCIENCIA NEGRA', imagePath: 'assets/consciencia_negra.png'),
    PuzzleLevel(difficulty: 'Difícil', puzzle: 'I N D E P _ _ _ D E N _ I A D _ B R A _ _', answer: 'INDEPENDENCIA DO BRASIL', imagePath: 'assets/independencia_brasil.png'),
  ];

  late List<PuzzleLevel> _levels;
  int _currentLevelIndex = 0;
  String _userInput = '';
  String _errorMessage = '';
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // FocusNode para o foco automático

  @override
  void initState() {
    super.initState();
    _levels = _allLevels.where((level) => level.difficulty == widget.difficulty).toList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus(); // Coloca foco no campo de texto ao iniciar
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose(); // Libera o FocusNode
    super.dispose();
  }

  String _normalize(String input) {
    return input.toLowerCase()
        .replaceAll(RegExp(r'[áàãâä]'), 'a')
        .replaceAll(RegExp(r'[éèêë]'), 'e')
        .replaceAll(RegExp(r'[íìîï]'), 'i')
        .replaceAll(RegExp(r'[óòõôö]'), 'o')
        .replaceAll(RegExp(r'[úùûü]'), 'u')
        .replaceAll(RegExp(r'[ç]'), 'c')
        .replaceAll(' ', '');
  }

  void _checkAnswer() {
    final currentLevel = _levels[_currentLevelIndex];
    if (_normalize(_userInput) == _normalize(currentLevel.answer)) {
      setState(() {
        _userInput = ''; // Limpa o texto armazenado
        _controller.clear(); // Limpa o campo de entrada
        _errorMessage = ''; // Limpa a mensagem de erro
        _currentLevelIndex++;
        _focusNode.requestFocus(); // Recoloca o foco no campo de entrada
      });
      if (_currentLevelIndex >= _levels.length) {
        _showCompletionDialog();
      }
    } else {
      setState(() {
        _errorMessage = 'Palavra incorreta, tente novamente.';
      });
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Parabéns!'),
        content: const Text('Você completou todos os níveis!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(); // Fecha o diálogo
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => JogosTela()), // Navega para JogosTela
              );
            },
            child: const Text('Voltar ao Menu'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLevel = _levels[_currentLevelIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Modo: ${widget.difficulty}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              currentLevel.imagePath, // Imagem do nível
              height: 150,
            ),
            const SizedBox(height: 20),
            Text(
              currentLevel.puzzle,
              style: const TextStyle(fontSize: 28, letterSpacing: 2),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              focusNode: _focusNode, // Associa o FocusNode ao campo de texto
              onChanged: (value) {
                setState(() {
                  _userInput = value;
                });
              },
              onSubmitted: (_) => _checkAnswer(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite o nome do feriado',
              ),
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: const Text('Verificar'),
            ),
            const SizedBox(height: 10),
            Text(
              _errorMessage,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class PuzzleLevel {
  final String difficulty;
  final String puzzle;
  final String answer;
  final String imagePath;

  PuzzleLevel({
    required this.difficulty,
    required this.puzzle,
    required this.answer,
    required this.imagePath,
  });
}
