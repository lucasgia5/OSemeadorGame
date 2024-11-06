import 'package:flutter/material.dart';
import 'package:flutterosemeador/telas/jogos_tela.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Seleção de Dificuldade'),
        backgroundColor: Colors.deepOrange,
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
                difficulty: 'Fácil',
              ),
              const SizedBox(height: 20),
              _buildDifficultyButton(
                context,
                label: 'Médio',
                icon: FontAwesomeIcons.handPeace,
                color: Colors.blue.shade500,
                difficulty: 'Médio',
              ),
              const SizedBox(height: 20),
              _buildDifficultyButton(
                context,
                label: 'Difícil',
                icon: FontAwesomeIcons.fistRaised,
                color: Colors.blue.shade700,
                difficulty: 'Difícil',
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
    required String difficulty,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PuzzleGameScreen(difficulty: difficulty),
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class PuzzleGameScreen extends StatefulWidget {
  final String difficulty;
  const PuzzleGameScreen({Key? key, required this.difficulty})
      : super(key: key);

  @override
  State<PuzzleGameScreen> createState() => _PuzzleGameScreenState();
}

class _PuzzleGameScreenState extends State<PuzzleGameScreen> {
  final List<PuzzleLevel> _allLevels = [
    PuzzleLevel(
        difficulty: 'Fácil',
        puzzle: 'N A T _ _',
        answer: 'NATAL',
        imagePath: 'assets/imagens/datas_comemorativas/papai_noel_correto.png'),
    PuzzleLevel(
        difficulty: 'Fácil',
        puzzle: 'A N _  N _ _ O',
        answer: 'ANO NOVO',
        imagePath: 'assets/imagens/datas_comemorativas/ano_novo.png'),
    PuzzleLevel(
        difficulty: 'Fácil',
        puzzle: 'P A _ C _ A',
        answer: 'PASCOA',
        imagePath: 'assets/imagens/datas_comemorativas/pascoa.png'),
    PuzzleLevel(
        difficulty: 'Médio',
        puzzle: 'D I _  D _ S C R I _ _ Ç _ S',
        answer: 'DIA DAS CRIANCAS',
        imagePath: 'assets/imagens/datas_comemorativas/dia_das_craincas.png'),
    PuzzleLevel(
        difficulty: 'Médio',
        puzzle: 'H A L _ _ W _ _ _',
        answer: 'HALLOWEEN',
        imagePath: 'assets/imagens/datas_comemorativas/halloween.png'),
    PuzzleLevel(
        difficulty: 'Médio',
        puzzle: 'T I R _ _ _ N T E _',
        answer: 'TIRADENTES',
        imagePath: 'assets/imagens/datas_comemorativas/tiradentes.webp'),
    PuzzleLevel(
        difficulty: 'Difícil',
        puzzle: 'P R O C _ _ M A Ç Ã _  D _  R E P _ _ _ _ C A',
        answer: 'PROCLAMACAO DA REPUBLICA',
        imagePath: 'assets/imagens/datas_comemorativas/proclamacao_certa.png'),
    PuzzleLevel(
        difficulty: 'Difícil',
        puzzle: 'C O N S _ _ _ _ C I A  N E G_ _',
        answer: 'CONSCIENCIA NEGRA',
        imagePath: 'assets/imagens/datas_comemorativas/consciencia_certa.png'),
    PuzzleLevel(
        difficulty: 'Difícil',
        puzzle: 'I N D E P _ _ _ D E N _ I A  D _  B R A _ _',
        answer: 'INDEPENDENCIA DO BRASIL',
        imagePath: 'assets/imagens/datas_comemorativas/independencia.png'),
  ];

  late List<PuzzleLevel> _levels;
  int _currentLevelIndex = 0;
  String _userInput = '';
  String _errorMessage = '';
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _levels = _allLevels
        .where((level) => level.difficulty == widget.difficulty)
        .toList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String _normalize(String input) {
    return input
        .toLowerCase()
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
        _userInput = '';
        _controller.clear();
        _errorMessage = '';

        if (_currentLevelIndex < _levels.length - 1) {
          _currentLevelIndex++;
          _focusNode.requestFocus();
        } else {
          _showCompletionDialog();
        }
      });
    } else {
      setState(() {
        _errorMessage = 'Resposta incorreta, tente novamente.';
      });
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Parabéns!'),
          content: const Text('Você completou todos os níveis!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PuzzleGameApp(),
                          ),
                        );
              },
              child: const Text('Jogar novamente'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLevel = _levels[_currentLevelIndex];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Nível ${_currentLevelIndex + 1} - ${widget.difficulty}'),
        backgroundColor: Colors.deepOrange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentLevel.puzzle,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Image.asset(
                currentLevel.imagePath,
                width: 200,
                height: 200, // Aumenta o tamanho da imagem
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                onChanged: (value) {
                  setState(() {
                    _userInput = value;
                  });
                },
                onSubmitted: (_) => _checkAnswer(), // Envia a resposta com Enter
                decoration: InputDecoration(
                  labelText: 'Digite a resposta',
                  errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Verificar',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
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
