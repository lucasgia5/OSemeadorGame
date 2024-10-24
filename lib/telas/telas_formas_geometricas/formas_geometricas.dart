import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

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
      appBar: AppBar(
        title: Text('Escolha a Dificuldade'),
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
                      builder: (context) => GameScreen(difficulty: 'easy')),
                );
              },
              child: Text('Fácil'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GameScreen(difficulty: 'medium')),
                );
              },
              child: Text('Médio'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GameScreen(difficulty: 'hard')),
                );
              },
              child: Text('Difícil'),
            ),
          ],
        ),
      ),
    );
  }
}

class GameScreen extends StatelessWidget {
  final String difficulty;

  const GameScreen({required this.difficulty, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo - Dificuldade: $difficulty'),
      ),
      body: ShapeLinkerGameBody(difficulty: difficulty),
    );
  }
}

class ShapeLinkerGameBody extends StatefulWidget {
  final String difficulty;

  const ShapeLinkerGameBody({required this.difficulty, Key? key})
      : super(key: key);

  @override
  _ShapeLinkerGameBodyState createState() => _ShapeLinkerGameBodyState();
}

class _ShapeLinkerGameBodyState extends State<ShapeLinkerGameBody>
    with TickerProviderStateMixin {
  late List<String> shapes;
  late List<String> shuffledShapes;
  late List<String> matchedShapes;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _setDifficulty(widget.difficulty);
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _setDifficulty(String difficulty) {
    if (difficulty == 'easy') {
      shapes = ['Circle', 'Triangle', 'Square'];
    } else if (difficulty == 'medium') {
      shapes = [
        'Circle',
        'Triangle',
        'Square',
        'Pentagon',
        'Hexagon',
        'Rhombus'
      ];
    } else if (difficulty == 'hard') {
      shapes = [
        'Circle',
        'Triangle',
        'Square',
        'Pentagon',
        'Hexagon',
        'Rhombus',
        'Octagon',
        'Star'
      ];
    }
    _shuffleShapes();
  }

  void _shuffleShapes() {
    shuffledShapes = List.from(shapes);
    shuffledShapes.shuffle();
    matchedShapes = [];
  }

  void _onGameCompleted() {
    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: shuffledShapes
                    .map((shape) => _buildTarget(shape, isNeutral: true))
                    .toList(),
              ),
            ),
            Divider(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                    shapes.map((shape) => _buildDraggable(shape)).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _shuffleShapes();
                });
              },
              child: Text('Recomeçar'),
            ),
          ],
        ),
        if (matchedShapes.length == shapes.length)
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: [Colors.red, Colors.green, Colors.blue, Colors.purple],
            ),
          ),
        if (matchedShapes.length == shapes.length)
          Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Parabéns! Você completou o jogo!',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _shuffleShapes();
                        _onGameCompleted();
                      });
                    },
                    child: Text('Reiniciar Jogo'),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDraggable(String shape) {
    return Draggable<String>(
      data: shape,
      child: _buildShape(shape),
      feedback: _buildShape(shape, isDragging: true),
      childWhenDragging: Container(),
    );
  }

  Widget _buildTarget(String shape, {bool isNeutral = false}) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return _buildShape(
          shape,
          isMatched: matchedShapes.contains(shape),
          isNeutral: isNeutral,
        );
      },
      onWillAccept: (data) => data == shape,
      onAccept: (data) {
        setState(() {
          matchedShapes.add(shape);
          // Chama o método para mostrar o confete se todas as formas estiverem combinadas
          if (matchedShapes.length == shapes.length) {
            _onGameCompleted(); // Adicionada chamada para mostrar confete
          }
        });
      },
    );
  }

  Widget _buildShape(String shape,
      {bool isMatched = false,
      bool isNeutral = false,
      bool isDragging = false}) {
    Color color;
    if (isMatched) {
      color = Colors.green;
    } else if (isNeutral) {
      color = Colors.grey;
    } else {
      color = Colors.blue;
    }

    const double shapeSize = 80;
    const double largeShape = 100;

    switch (shape) {
      case 'Circle':
        return Container(
          width: shapeSize,
          height: shapeSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDragging ? Colors.yellow : color,
          ),
        );
      case 'Triangle':
        return CustomPaint(
          size: Size(shapeSize, shapeSize),
          painter: TrianglePainter(color: isDragging ? Colors.yellow : color),
        );
      case 'Square':
        return Container(
          width: shapeSize,
          height: shapeSize,
          color: isDragging ? Colors.yellow : color,
        );
      case 'Pentagon':
        return CustomPaint(
          size: Size(largeShape, largeShape),
          painter: PentagonPainter(color: isDragging ? Colors.yellow : color),
        );
      case 'Hexagon':
        return CustomPaint(
          size: Size(largeShape, largeShape),
          painter: HexagonPainter(color: isDragging ? Colors.yellow : color),
        );
      case 'Rhombus':
        return CustomPaint(
          size: Size(shapeSize, shapeSize),
          painter: RhombusPainter(color: isDragging ? Colors.yellow : color),
        );
      case 'Octagon':
        return CustomPaint(
          size: Size(largeShape, largeShape),
          painter: OctagonPainter(color: isDragging ? Colors.yellow : color),
        );
      case 'Star':
        return CustomPaint(
          size: Size(largeShape, largeShape),
          painter: StarPainter(color: isDragging ? Colors.yellow : color),
        );
      default:
        return Container();
    }
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class PentagonPainter extends CustomPainter {
  final Color color;

  PentagonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height * 0.38)
      ..lineTo(size.width * 0.81, size.height)
      ..lineTo(size.width * 0.19, size.height)
      ..lineTo(0, size.height * 0.38)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HexagonPainter extends CustomPainter {
  final Color color;

  HexagonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(size.width, size.height * 0.25)
      ..lineTo(size.width, size.height * 0.75)
      ..lineTo(size.width * 0.5, size.height)
      ..lineTo(0, size.height * 0.75)
      ..lineTo(0, size.height * 0.25)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class RhombusPainter extends CustomPainter {
  final Color color;

  RhombusPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0, size.height / 2)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class OctagonPainter extends CustomPainter {
  final Color color;

  OctagonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path()
      ..moveTo(size.width * 0.25, 0)
      ..lineTo(size.width * 0.75, 0)
      ..lineTo(size.width, size.height * 0.25)
      ..lineTo(size.width, size.height * 0.75)
      ..lineTo(size.width * 0.75, size.height)
      ..lineTo(size.width * 0.25, size.height)
      ..lineTo(0, size.height * 0.75)
      ..lineTo(0, size.height * 0.25)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class StarPainter extends CustomPainter {
  final Color color;

  StarPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path();
    double width = size.width;
    double height = size.height;

    path.moveTo(width / 2, 0);
    path.lineTo(width * 0.6, height * 0.38);
    path.lineTo(width * 1, height * 0.38);
    path.lineTo(width * 0.68, height * 0.62);
    path.lineTo(width * 0.8, height);
    path.lineTo(width / 2, height * 0.75);
    path.lineTo(width * 0.2, height);
    path.lineTo(width * 0.32, height * 0.62);
    path.lineTo(0, height * 0.38);
    path.lineTo(width * 0.4, height * 0.38);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
