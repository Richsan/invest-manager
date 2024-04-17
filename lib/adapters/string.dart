import 'package:invest_manager/models/stock_operation.dart';

extension StringAdapter on String {
  String onlyNumbers() {
    return replaceAll('.', '');
  }

  String onlyDecimals() {
    return replaceAll(' ', '')
        .replaceAll(RegExp(r'[^\d,]'), '')
        .replaceAll(',', '.');
  }

  BigInt doubleToMoney() {
    return BigInt.from((double.parse(this) * 100).round());
  }

  BigInt asMoney() {
    return BigInt.parse(onlyNumbers());
  }

  OperationType toOperationType() {
    return this == 'buy' ? OperationType.buy : OperationType.sell;
  }
}
