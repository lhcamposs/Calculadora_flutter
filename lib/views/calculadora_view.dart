import 'package:flutter/material.dart';
import 'package:programacao/viewnmodels/calculadora_viewmodel.dart';

import '../models/calculadora_model.dart';
import 'widgets/botao_calculadora.dart';

class CalculadoraView extends StatefulWidget {
  const CalculadoraView({super.key});

  @override
  State<CalculadoraView> createState() => _CalculadoraViewState();
}

class _CalculadoraViewState extends State<CalculadoraView> {
  late final CalculadoraViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CalculadoraViewModel();
    _viewModel.addListener(_aoMudarEstado);
  }

  void _aoMudarEstado() => setState(() {});

  @override
  void dispose() {
    _viewModel.removeListener(_aoMudarEstado);
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    final vm = _viewModel;

    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora')),
      body: SafeArea(
        child: Column(
          children: [
            // Visor
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      vm.expressao,
                      style: TextStyle(
                        fontSize: 22,
                        color: cores.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        vm.visor,
                        style: TextStyle(
                          fontSize: vm.temErro ? 28 : 56,
                          fontWeight: FontWeight.w500,
                          color: vm.temErro ? cores.error : cores.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Teclado
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _linha([
                      BotaoCalculadora(
                        texto: 'C',
                        tipo: TipoBotao.acao,
                        aoPressionar: vm.limpar,
                      ),
                      BotaoCalculadora(
                        texto: '⌫',
                        tipo: TipoBotao.acao,
                        aoPressionar: vm.apagar,
                      ),
                      BotaoCalculadora(
                        texto: '±',
                        tipo: TipoBotao.acao,
                        aoPressionar: vm.alternarSinal,
                      ),
                      _botaoOperacao(Operacao.divisao),
                    ]),
                    _linha([
                      _botaoDigito('7'),
                      _botaoDigito('8'),
                      _botaoDigito('9'),
                      _botaoOperacao(Operacao.multiplicacao),
                    ]),
                    _linha([
                      _botaoDigito('4'),
                      _botaoDigito('5'),
                      _botaoDigito('6'),
                      _botaoOperacao(Operacao.subtracao),
                    ]),
                    _linha([
                      _botaoDigito('1'),
                      _botaoDigito('2'),
                      _botaoDigito('3'),
                      _botaoOperacao(Operacao.soma),
                    ]),
                    _linha([
                      _botaoDigito('0', flex: 2),
                      BotaoCalculadora(
                        texto: '.',
                        aoPressionar: vm.inserirPonto,
                      ),
                      BotaoCalculadora(
                        texto: '=',
                        tipo: TipoBotao.igual,
                        aoPressionar: vm.calcularResultado,
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _linha(List<Widget> botoes) => Expanded(child: Row(children: botoes));

  Widget _botaoDigito(String digito, {int flex = 1}) => BotaoCalculadora(
    texto: digito,
    flex: flex,
    aoPressionar: () => _viewModel.digitar(digito),
  );

  Widget _botaoOperacao(Operacao operacao) => BotaoCalculadora(
    texto: operacao.simbolo,
    tipo: TipoBotao.operador,
    aoPressionar: () => _viewModel.definirOperacao(operacao),
  );
}