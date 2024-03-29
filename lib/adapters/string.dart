import 'dart:ffi';

import 'package:invest_manager/adapters/number.dart';
import 'package:invest_manager/models/stock_operation.dart';

extension StringAdapter on String {
  String onlyNumbers() {
    return replaceAll(' ', '').replaceAll(RegExp(r'[^0-9]'), '');
  }

  String onlyDecimals() {
    return replaceAll(' ', '')
        .replaceAll(RegExp(r'[^\d,]'), '')
        .replaceAll(',', '.');
  }

  BigInt asMoney() {
    return BigInt.parse(onlyNumbers());
  }

  OperationType toOperationType() {
    return this == 'buy' ? OperationType.buy : OperationType.sell;
  }
}
