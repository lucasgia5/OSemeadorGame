import 'package:flutter/material.dart';
import 'package:flutterosemeador/componentes/decoracao_campo_autenticacao.dart';
import 'package:flutterosemeador/servicos/autenticacao_servico.dart';
import 'package:flutterosemeador/telas/tela_menu.dart'; // Importando a TelaMenu

class AutenticacaoTela extends StatefulWidget {
  const AutenticacaoTela({super.key});

  @override
  State<AutenticacaoTela> createState() => _AutenticacaoTelaState();
}

class _AutenticacaoTelaState extends State<AutenticacaoTela> {
  bool queroEntrar = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _senhacontroller = TextEditingController();
  final TextEditingController _confirmarSenhacontroller =
      TextEditingController(); // Adicionado
  final TextEditingController _nomecontroller = TextEditingController();

  final AutenticacaoServico _autenServico = AutenticacaoServico();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 255, 255, 255),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "O Semeador",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailcontroller,
                    decoration: getAuthenticationInputDecoration("E-mail"),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "O e-mail não pode ser vazio";
                      }
                      if (value.length < 5) {
                        return "O e-mail é muito curto";
                      }
                      if (!value.contains("@")) {
                        return "O e-mail não é válido";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _senhacontroller,
                    decoration: getAuthenticationInputDecoration("Senha"),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "A senha não pode ser vazia";
                      }
                      if (value.length < 5) {
                        return "A senha é muito curta";
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  const SizedBox(height: 8),
                  Visibility(
                    visible: !queroEntrar,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _confirmarSenhacontroller,
                          decoration: getAuthenticationInputDecoration(
                              "Confirme Senha"),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "A confirmação de senha não pode ser vazia";
                            }
                            if (value != _senhacontroller.text) {
                              return "As senhas não coincidem";
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _nomecontroller,
                          decoration: getAuthenticationInputDecoration("Nome"),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "O nome não pode ser vazio";
                            }
                            if (value.length < 5) {
                              return "O nome é muito curto";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      botaoPrincipalClicado();
                    },
                    child: Text((queroEntrar) ? "Entrar" : "Cadastrar"),
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        queroEntrar = !queroEntrar;
                      });
                    },
                    child: Text((queroEntrar)
                        ? "Ainda não tem uma conta? Cadastre-se!"
                        : "Já tem uma conta? Entre!"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void botaoPrincipalClicado() async {
    String email = _emailcontroller.text;
    String senha = _senhacontroller.text;
    String nome = _nomecontroller.text;

    if (_formKey.currentState!.validate()) {
      // Mostra um SnackBar para dar feedback visual ao usuário
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processando...')),
      );

      try {
        if (queroEntrar) {
          // Tentativa de login
          await _autenServico.entrarUsuario(email: email, senha: senha);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login bem-sucedido!')),
          );

          // Navegar para a Tela de Menu após o login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TelaMenu()),
          );
        } else {
          // Tentativa de cadastro
          await _autenServico.cadastrarUsuario(
              nome: nome, email: email, senha: senha);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cadastro realizado com sucesso!')),
          );

          // Navegar para a Tela de Menu após o cadastro
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TelaMenu()),
          );
        }
      } catch (e) {
        // Captura o erro e exibe ao usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${e.toString()}')),
        );
      }
    } else {
      print("form inválido");
    }
  }
}
