import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:math';

class PedacoImagem {
  Uint8List ints = Uint8List(1);
  int posX = 0;
  int posY = 0;
  int index = 0;
  bool colocado = false;
  int originalEmbaralhado = 0;

  PedacoImagem({
    required this.ints,
    required this.posX,
    required this.posY,
    required this.index,
  });
}

Future<void> carregarImagensEFragmentar({
  required List<PedacoImagem> imagePieces,
  required List<PedacoImagem> imagePiecesColocados,
  required int dificuldade,
  required int imagemIndex,
  required List<String> imagens,
  required Function embaralharImagens,
  required Function setState,
}) async {
  final ByteData data = await rootBundle.load(imagens[imagemIndex]);
  final ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  final ui.FrameInfo frameInfo = await codec.getNextFrame();
  final ui.Image image = frameInfo.image;

  final int pieceSize = (image.width / dificuldade).round();
  int index = 0;
  for (int y = 0; y < dificuldade; y++) {
    for (int x = 0; x < dificuldade; x++) {
      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(recorder);
      final Rect srcRect = Rect.fromLTWH(
          x * pieceSize.toDouble(),
          y * pieceSize.toDouble(),
          pieceSize.toDouble(),
          pieceSize.toDouble());
      final Rect dstRect = Rect.fromLTWH(0, 0, pieceSize.toDouble(), pieceSize.toDouble());
      canvas.drawImageRect(image, srcRect, dstRect, Paint());
      final ui.Image piece = await recorder.endRecording().toImage(pieceSize, pieceSize);
      final ByteData? byteData = await piece.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        imagePieces.add(
          PedacoImagem(
            ints: byteData.buffer.asUint8List(),
            posX: x,
            posY: y,
            index: index,
          ),
        );
        imagePiecesColocados.add(
          PedacoImagem(
            ints: byteData.buffer.asUint8List(),
            posX: x,
            posY: y,
            index: index,
          ),
        );
      }
      index++;
    }
  }
  await embaralharImagens();
  setState(() {});
}
