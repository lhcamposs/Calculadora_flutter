import 'package:flutter/material.dart';

import 'views/calculadora_view.dart';

void main() => runApp(const CalculadoraApp());

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const CalculadoraView(),
    );
  }
}