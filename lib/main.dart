import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Importar o Firebase
import 'firebase_options.dart'; // Importar as opções geradas pelo CLI
import 'telas/autenticacao_tela.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Inicializando Firebase
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App de Autenticação',
      home: AutenticacaoTela(),
    );
  }
}
