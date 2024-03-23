import 'dart:ffi';

import 'package:invest_manager/adapters/number.dart';

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
}
