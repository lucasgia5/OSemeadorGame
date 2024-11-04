import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

void main() => runApp(PuzzleApp());

class PuzzleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PuzzleSelectionScreen(),
    );
  }
}

class PuzzleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quebra-Cabeça')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var level in ['Fácil', 'Médio', 'Difícil'])
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PuzzleCategoryScreen(level: level),
                    ),
                  );
                },
                child: Text('Dificuldade: $level'),
              ),
          ],
        ),
      ),
    );
  }
}

class PuzzleCategoryScreen extends StatelessWidget {
  final String level;
  PuzzleCategoryScreen({required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categoria de Quebra-Cabeça - $level')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var category in ['Futebol', 'Vôlei', 'Basquete'])
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PuzzleGameScreen(
                        level: level,
                        category: category,
                      ),
                    ),
                  );
                },
                child: Text('Categoria: $category'),
              ),
          ],
        ),
      ),
    );
  }
}

class PuzzleGameScreen extends StatefulWidget {
  final String level;
  final String category;

  PuzzleGameScreen({required this.level, required this.category});

  @override
  _PuzzleGameScreenState createState() => _PuzzleGameScreenState();
}

class _PuzzleGameScreenState extends State<PuzzleGameScreen> {
  late int gridSize;
  late ui.Image fullImage;
  List<ImagePiece> puzzlePieces = [];
  List<int> userPositions = [];

  @override
  void initState() {
    super.initState();
    _setupPuzzle();
  }

  Future<void> _setupPuzzle() async {
    // Define o tamanho do grid com base na dificuldade
    if (widget.level == 'Fácil') gridSize = 3;
    if (widget.level == 'Médio') gridSize = 6;
    if (widget.level == 'Difícil') gridSize = 9;

    String imagePath = 'assets/imagens/quebra_cabeca_img/${widget.category.toLowerCase()}${widget.level == 'Fácil' ? 1 : widget.level == 'Médio' ? 2 : 3}.png';
    fullImage = await _loadImage(imagePath);

    _createPuzzlePieces();
    setState(() {});
  }

  Future<ui.Image> _loadImage(String asset) async {
    final ByteData data = await rootBundle.load(asset);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(data.buffer.asUint8List(), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  void _createPuzzlePieces() {
    // Define o tamanho de cada peça com base na imagem e grid
    double pieceWidth = fullImage.width / gridSize;
    double pieceHeight = fullImage.height / gridSize;
    puzzlePieces = [];

    // Divide a imagem em peças e cria uma lista embaralhada de posições de peças
    for (int y = 0; y < gridSize; y++) {
      for (int x = 0; x < gridSize; x++) {
        Rect rect = Rect.fromLTWH(
          x * pieceWidth,
          y * pieceHeight,
          pieceWidth,
          pieceHeight,
        );
        puzzlePieces.add(ImagePiece(rect: rect, originalIndex: y * gridSize + x));
      }
    }

    puzzlePieces.shuffle();
    userPositions = List<int>.filled(gridSize * gridSize, -1);
  }

  bool _isPuzzleCorrect() {
    for (int i = 0; i < gridSize * gridSize; i++) {
      if (userPositions[i] != i) return false;
    }
    return true;
  }

  void _checkPuzzle() {
    if (_isPuzzleCorrect()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Parabéns!'),
          content: Text('Você completou o quebra-cabeça!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.category} - ${widget.level}')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                width: 300, // Tamanho fixo para o grid do meio
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridSize,
                  ),
                  itemCount: puzzlePieces.length, // Limita o número de blocos ao número de peças
                  itemBuilder: (context, index) {
                    return DragTarget<int>(
                      onWillAccept: (data) => true,
                      onAccept: (data) {
                        setState(() {
                          userPositions[index] = data;
                        });
                      },
                      builder: (context, candidateData, rejectedData) {
                        int pieceIndex = userPositions[index];
                        return Container(
                          margin: EdgeInsets.all(1),
                          color: pieceIndex == -1 ? Colors.grey[300] : Colors.transparent,
                          child: pieceIndex != -1
                              ? CustomPaint(
                                  painter: ImagePainter(
                                    fullImage: fullImage,
                                    pieceRect: puzzlePieces[pieceIndex].rect,
                                  ),
                                )
                              : Container(),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: puzzlePieces.length,
              itemBuilder: (context, index) {
                return Draggable<int>(
                  data: index,
                  feedback: CustomPaint(
                    painter: ImagePainter(
                      fullImage: fullImage,
                      pieceRect: puzzlePieces[index].rect,
                    ),
                    child: Container(width: 80, height: 80),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.5,
                    child: CustomPaint(
                      painter: ImagePainter(
                        fullImage: fullImage,
                        pieceRect: puzzlePieces[index].rect,
                      ),
                      child: Container(width: 80, height: 80),
                    ),
                  ),
                  child: userPositions.contains(index)
                      ? Container(width: 80)
                      : CustomPaint(
                          painter: ImagePainter(
                            fullImage: fullImage,
                            pieceRect: puzzlePieces[index].rect,
                          ),
                          child: Container(width: 80, height: 80),
                        ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _checkPuzzle,
            child: Text('Verificar Quebra-Cabeça'),
          ),
          SizedBox(height: 10),
          if (!_isPuzzleCorrect())
            Text(
              'Ainda não está correto, continue tentando!',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}

class ImagePiece {
  final Rect rect;
  final int originalIndex;

  ImagePiece({required this.rect, required this.originalIndex});
}

class ImagePainter extends CustomPainter {
  final ui.Image fullImage;
  final Rect pieceRect;

  ImagePainter({required this.fullImage, required this.pieceRect});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    canvas.drawImageRect(
      fullImage,
      pieceRect,
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
