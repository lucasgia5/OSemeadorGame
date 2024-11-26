import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativo com Fonte Cabin',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: GoogleFonts.cabinTextTheme(), // Fonte global "Cabin"
      ),
      home: HomeScreen(), // Tela inicial
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicativo com Fonte Cabin'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Texto com fonte Cabin!',
            ),
            SizedBox(height: 20),
            Text(
              'Todo o app usa esta fonte automaticamente.',
            ),
          ],
        ),
      ),
    );
  }
}
