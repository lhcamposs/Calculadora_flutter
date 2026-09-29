enum Operacao {
  soma('+'),
  subtracao('-'),
  multiplicacao('×'),
  divisao('÷');

  const Operacao(this.simbolo);

  final String simbolo;
}

class DivisaoPorZeroException implements Exception {
  @override
  String toString() => 'Divisão por zero';
}

class CalculadoraModel {
  double calcular(double a, double b, Operacao operacao) {
    switch (operacao) {
      case Operacao.soma:
        return a + b;
      case Operacao.subtracao:
        return a - b;
      case Operacao.multiplicacao:
        return a * b;
      case Operacao.divisao:
        if (b == 0) throw DivisaoPorZeroException();
        return a / b;
    }
  }
}