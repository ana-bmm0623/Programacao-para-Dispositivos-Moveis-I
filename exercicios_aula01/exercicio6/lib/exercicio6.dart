void lembrete(diaDaSemana) {
  switch (diaDaSemana) {
    case 'segunda-feira' || 'segunda' || 'Segunda-feira' || 'Segunda':
      print('Hoje é segunda-feira');
      break;
    case 'terça-feira' || 'terça' || 'Terça-feira' || 'Terça':
      print('Hoje é terça-feira');
      break;
    case 'quarta-feira' || 'quarta' || 'Quarta-feira' || 'Quarta':
      print('Hoje é quarta-feira');
      break;
    case 'quinta-feira' || 'quinta' || 'Quinta-feira' || 'Quinta':
      print('Hoje é quinta-feira');
      break;
    case 'sexta-feira' || 'sexta' || 'Sexta-feira' || 'Sexta': 
      print('Hoje é sexta-feira');
      break;
    case 'sábado' || 'Sabado' || 'sabado' || 'Sábado':
      print('Hoje é sábado');
      break;
    case 'domingo' || 'Domingo':
      print('Hoje é domingo');
      break;
    default:
      print('Dia da semana inválido');
      break;
  }
}
