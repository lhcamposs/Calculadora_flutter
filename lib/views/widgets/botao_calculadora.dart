import 'package:flutter/material.dart';

enum TipoBotao { numero, operador, acao, igual }

class BotaoCalculadora extends StatelessWidget {
  const BotaoCalculadora({
    super.key,
    required this.texto,
    required this.aoPressionar,
    this.tipo = TipoBotao.numero,
    this.flex = 1,
  });

  final String texto;
  final VoidCallback aoPressionar;
  final TipoBotao tipo;
  final int flex;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    final (Color fundo, Color letra) = switch (tipo) {
      TipoBotao.operador => (cores.secondaryContainer, cores.onSecondaryContainer),
      TipoBotao.igual => (cores.primary, cores.onPrimary),
      TipoBotao.acao => (cores.tertiaryContainer, cores.onTertiaryContainer),
      TipoBotao.numero => (cores.surfaceContainerHighest, cores.onSurface),
    };

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: FilledButton(
          onPressed: aoPressionar,
          style: FilledButton.styleFrom(
            backgroundColor: fundo,
            foregroundColor: letra,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(texto, style: const TextStyle(fontSize: 26)),
        ),
      ),
    );
  }
}