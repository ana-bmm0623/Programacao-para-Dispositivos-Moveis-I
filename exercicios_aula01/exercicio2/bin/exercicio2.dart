import 'package:exercicio2/exercicio2.dart' as exercicio2;

void main(List<String> arguments) {
  print('Olá, ${exercicio2.nome}!');
  print('Você tem ${exercicio2.idade} anos.');
  print('Sua altura é ${exercicio2.altura}m.');
  print('Você é ${exercicio2.estudante ? 'estudante' : 'não estudante'}.');
}
