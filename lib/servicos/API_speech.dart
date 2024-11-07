import 'dart:html' as html;

void speakWeb(String text) {
  // Cancela qualquer fala anterior antes de iniciar uma nova
  html.window.speechSynthesis?.cancel(); 

  // Cria um novo enunciado de fala com o texto desejado
  final utterance = html.SpeechSynthesisUtterance(text);
  utterance.lang = 'pt-BR'; // Define o idioma para português do Brasil
  utterance.volume = 1.0; // Volume (0.0 a 1.0)
  utterance.rate = 1.0; // Velocidade de fala (0.1 a 10)
  utterance.pitch = 1.0; // Tom da voz (0.0 a 2.0)

  // Inicia a fala
  html.window.speechSynthesis?.speak(utterance);
}
