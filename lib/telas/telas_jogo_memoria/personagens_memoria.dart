class Personagem {
  final String nome;
  final String imagem;

  Personagem({required this.nome, required this.imagem});
}

List<Personagem> personagensFacil = [
  Personagem(nome: "Saci", imagem: "assets/imagens/jogo_memoria/saci.png"),
  Personagem(nome: "Curupira", imagem: "assets/imagens/jogo_memoria/curupira.png"),
  Personagem(nome: "Cuca", imagem: "assets/imagens/jogo_memoria/cuca.png"),
];

List<Personagem> personagensMedio = [
  ...personagensFacil,
  Personagem(nome: "Boto Cor-de-Rosa", imagem: "assets/imagens/jogo_memoria/boto.png"),
  Personagem(nome: "Mula Sem Cabeça", imagem: "assets/imagens/jogo_memoria/mula.webp"),
];

List<Personagem> personagensDificil = [
  ...personagensMedio,
  Personagem(nome: "Lobisomem", imagem: "assets/imagens/jogo_memoria/lobisomen.png"),
  Personagem(nome: "Boitatá", imagem: "assets/imagens/jogo_memoria/boitata.png"),
];
