import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/material.dart' hide Image;


class MyGame extends FlameGame {
  double personagem1ScaleFactor = 3.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    print('1. Iniciando o carregamento dos assets');
    
    // Carregando a imagem do personagem
    Image personagem1Image = await images.load('personagem1/spritesheetpersonagem1.png');
    
    // Verificando se a imagem foi carregada corretamente
    print('Imagem carregada com sucesso: $personagem1Image');
    
    // Criando o sprite com o tamanho e escala ajustados
    SpriteComponent personagem1Sprite = SpriteComponent.fromImage(
      personagem1Image,
      srcSize: Vector2(32, 34),
    )
      ..size = Vector2(32 * personagem1ScaleFactor, 34 * personagem1ScaleFactor)
      ..position = Vector2(100, 100); // Ajuste a posição como necessário

    // Adicionando o sprite ao jogo
    add(personagem1Sprite);
  }
}
