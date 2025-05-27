import 'package:flutter/material.dart';
import 'calculo.dart';

class TelaFinanciamento extends StatefulWidget {
  @override
  _TelaFinanciamentoState createState() => _TelaFinanciamentoState();
}

class _TelaFinanciamentoState extends State<TelaFinanciamento> {
  final _formKey = GlobalKey<FormState>();
  final _valorController = TextEditingController();
  final _parcelasController = TextEditingController();
  final _jurosController = TextEditingController();
  final _taxasController = TextEditingController();

  FinanciamentoResultado? _resultado;

  String formatarReais(double valor) {
    return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  void _calcular() {
    final valor = double.tryParse(_valorController.text) ?? 0.0;
    final parcelas = int.tryParse(_parcelasController.text) ?? 0;
    final juros = double.tryParse(_jurosController.text) ?? 0.0;
    final taxas = double.tryParse(_taxasController.text) ?? 0.0;

    final resultado = FinanciamentoHelper.calcular(
      valor: valor,
      parcelas: parcelas,
      jurosMensalPercentual: juros,
      taxasAdicionais: taxas,
    );

    setState(() {
      _resultado = resultado;
    });
  }

  @override
  void dispose() {
    _valorController.dispose();
    _parcelasController.dispose();
    _jurosController.dispose();
    _taxasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simulador de Financiamento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _valorController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Valor do Bem (R\$)'),
              ),
              TextFormField(
                controller: _parcelasController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Número de Parcelas'),
              ),
              TextFormField(
                controller: _jurosController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Taxa de Juros Mensal (%)'),
              ),
              TextFormField(
                controller: _taxasController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Taxas Adicionais (R\$)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calcular,
                child: Text('Calcular'),
              ),
              SizedBox(height: 20),
              if (_resultado != null) ...[
                Text(
                  'Parcela: ${formatarReais(_resultado!.parcela)}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Montante Total: ${formatarReais(_resultado!.montante)}',
                  style: TextStyle(fontSize: 18),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
