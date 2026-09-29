import 'package:flutter/foundation.dart';

import '../models/calculadora_model.dart';

class CalculadoraViewModel extends ChangeNotifier {
  CalculadoraViewModel({CalculadoraModel? model})
      : _model = model ?? CalculadoraModel();

  final CalculadoraModel _model;

  // ----------------------------- ESTADO -----------------------------
  String _visor = '0';
  String _expressao = '';
  double? _primeiroOperando;
  Operacao? _operacao;
  bool _novoNumero = true;
  bool _erro = false;

  String get visor => _visor;
  String get expressao => _expressao;
  bool get temErro => _erro;

  // ---------------------------- COMANDOS ----------------------------
  void digitar(String digito) {
    if (_erro) _reiniciar();
    if (_novoNumero) {
      _visor = digito;
      _novoNumero = false;
    } else if (_visor == '0') {
      _visor = digito;
    } else if (_visor.length < 15) {
      _visor += digito;
    }
    notifyListeners();
  }

  void inserirPonto() {
    if (_erro) _reiniciar();
    if (_novoNumero) {
      _visor = '0.';
      _novoNumero = false;
    } else if (!_visor.contains('.')) {
      _visor += '.';
    }
    notifyListeners();
  }

  void definirOperacao(Operacao operacao) {
    if (_erro) return;

    if (_operacao != null && !_novoNumero) {
      if (!_efetuarCalculo()) {
        notifyListeners();
        return;
      }
    }
    _primeiroOperando = double.parse(_visor);
    _operacao = operacao;
    _expressao = '${_formatar(_primeiroOperando!)} ${operacao.simbolo}';
    _novoNumero = true;
    notifyListeners();
  }

  void calcularResultado() {
    if (_erro || _operacao == null || _primeiroOperando == null) return;
    final a = _primeiroOperando!;
    final b = double.parse(_visor);
    final operacao = _operacao!;

    if (_efetuarCalculo()) {
      _expressao = '${_formatar(a)} ${operacao.simbolo} ${_formatar(b)} =';
      _operacao = null;
      _primeiroOperando = null;
    }
    notifyListeners();
  }

  void alternarSinal() {
    if (_erro || _visor == '0') return;
    _visor = _visor.startsWith('-') ? _visor.substring(1) : '-$_visor';
    notifyListeners();
  }

  void apagar() {
    if (_erro) {
      _reiniciar();
    } else if (!_novoNumero) {
      if (_visor.length <= 1 ||
          (_visor.length == 2 && _visor.startsWith('-'))) {
        _visor = '0';
        _novoNumero = true;
      } else {
        _visor = _visor.substring(0, _visor.length - 1);
      }
    }
    notifyListeners();
  }

  void limpar() {
    _reiniciar();
    notifyListeners();
  }

  // ---------------------------- INTERNOS ----------------------------
  bool _efetuarCalculo() {
    try {
      final resultado = _model.calcular(
        _primeiroOperando!,
        double.parse(_visor),
        _operacao!,
      );
      _visor = _formatar(resultado);
      _primeiroOperando = resultado;
      _novoNumero = true;
      return true;
    } on DivisaoPorZeroException {
      _reiniciar();
      _visor = 'Erro: divisão por zero';
      _erro = true;
      return false;
    }
  }

  void _reiniciar() {
    _visor = '0';
    _expressao = '';
    _primeiroOperando = null;
    _operacao = null;
    _novoNumero = true;
    _erro = false;
  }

  String _formatar(double valor) {
    if (valor == valor.truncateToDouble() && valor.abs() < 1e15) {
      return valor.toInt().toString();
    }
    var texto = valor.toStringAsFixed(8);
    texto = texto.replaceAll(RegExp(r'0+$'), '');
    texto = texto.replaceAll(RegExp(r'\.$'), '');
    return texto;
  }
}