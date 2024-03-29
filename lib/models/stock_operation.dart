import 'package:invest_manager/models/b3.dart';

enum OperationType {
  buy,
  sell,
}

class StockOperation {
  StockOperation({
    required this.operationDate,
    required this.liquidationDate,
    required this.company,
    required this.ticker,
    required this.unityValue,
    required this.taxes,
    required this.operationFee,
    required this.emoluments,
    required this.liquidationFee,
    required this.otherFees,
    required this.unities,
    required this.operationType,
    this.splitFactor = 1,
  });

  final DateTime operationDate;
  final DateTime liquidationDate;
  final Company company;
  final String ticker;
  final BigInt unityValue;
  final BigInt taxes;
  final BigInt operationFee;
  final BigInt emoluments;
  final BigInt liquidationFee;
  final BigInt otherFees;
  final BigInt unities;
  final double splitFactor;
  final OperationType operationType;
}
