import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterosemeador/telas/jogos_tela.dart'; // Importar a tela de jogos
import 'firebase_options.dart';
import 'package:flutterosemeador/telas/telas_datas_comemorativas/datas_comemorativas.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Removendo const do MyApp
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Removendo const aqui
      debugShowCheckedModeBanner: false,
      title: 'App de Autenticação',
      home: PuzzleGameApp(), // Aqui não precisa ser const
    );
  }
}
