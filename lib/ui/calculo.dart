import 'dart:math';

class FinanciamentoResultado {
  final double parcela;
  final double montante;

  FinanciamentoResultado(this.parcela, this.montante);
}

class FinanciamentoHelper {
  static FinanciamentoResultado calcular({
    required double valor,
    required int parcelas,
    required double jurosMensalPercentual,
    required double taxasAdicionais,
  }) {
    double juros = jurosMensalPercentual / 100;

    if (parcelas > 0 && juros > 0) {
      // Fórmula da Tabela Price
      double i = juros;
      double numerador = valor * i * pow(1 + i, parcelas);
      double denominador = pow(1 + i, parcelas) - 1;
      double parcela = numerador / denominador;
      double montante = parcela * parcelas + taxasAdicionais;
      return FinanciamentoResultado(parcela, montante);
    } else if (parcelas > 0) {
      // Sem juros
      double parcela = (valor + taxasAdicionais) / parcelas;
      double montante = parcela * parcelas;
      return FinanciamentoResultado(parcela, montante);
    } else {
      return FinanciamentoResultado(0.0, 0.0);
    }
  }
}