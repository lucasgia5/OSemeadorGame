import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoServico {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> cadastrarUsuario({required String nome, required String senha, required String email}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      // Atualizar o nome do usuário (opcional)
      await userCredential.user!.updateDisplayName(nome);
      print("Usuário cadastrado com sucesso: ${userCredential.user!.email}");
    } catch (e) {
      print("Erro ao cadastrar usuário: $e");
    }
  }

  Future<void> entrarUsuario({required String email, required String senha}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      print("Usuário logado com sucesso: ${userCredential.user!.email}");
    } catch (e) {
      print("Erro ao entrar: $e");
    }
  }
}
