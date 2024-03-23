import 'package:intl/intl.dart';

final currencyFormat = NumberFormat.simpleCurrency();

extension CurrencyFormatter on int {
  String asCurrency() {
    return currencyFormat.format(this / 100);
  }
}

extension BigIntCurrencyFormatter on BigInt {
  String asCurrency() {
    return currencyFormat.format(toDouble() / 100);
  }
}

extension MoneyExtractor on double {
  BigInt asMoneyInt() {
    return BigInt.from((this * 100).round());
  }
}

extension Statistics on List<num> {
  num perc95() {
    final copy = List<num>.from(this);

    copy.sort();

    final percIdx = (copy.length * 0.95).round();

    return copy[percIdx - 1];
  }
}
