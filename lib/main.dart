import 'package:flutter/material.dart';
import 'ui/tela.dart';  // caminho para tela.dart

void main() {
  runApp(MaterialApp(
    title: 'Simulador de Financiamento',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: TelaFinanciamento(),
  ));
}