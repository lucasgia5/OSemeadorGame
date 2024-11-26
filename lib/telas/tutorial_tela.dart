import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TutorialTela extends StatefulWidget {
  @override
  _TutorialTelaState createState() => _TutorialTelaState();
}

class _TutorialTelaState extends State<TutorialTela> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _controller = VideoPlayerController.network(
      'assets/video/video-entrando.mp4', // Substitua pelo link do vídeo ou use um arquivo local
    )
      ..initialize().then((_) {
        setState(() {}); // Atualiza a tela para mostrar o vídeo inicializado
      })
      ..setLooping(true); // Repete o vídeo automaticamente
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        // Adicionado para evitar overflow
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_controller.value.isInitialized)
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.stop),
                    onPressed: () {
                      setState(() {
                        _controller.pause();
                        _controller.seekTo(Duration.zero);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
