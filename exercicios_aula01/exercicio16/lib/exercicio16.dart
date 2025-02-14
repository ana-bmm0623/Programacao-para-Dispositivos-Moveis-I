num dividir(num a, num b) {
  if (b == 0) {
    throw ArgumentError('Divisão por zero não é permitida.');
  }
  return a / b;
}
