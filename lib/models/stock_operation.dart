import 'package:invest_manager/models/b3.dart';

class StockOperation {
  StockOperation({
    required this.operationDate,
    required this.liquidationDate,
    required this.company,
    required this.unityValue,
    required this.taxes,
    required this.operationFee,
    required this.emoluments,
    required this.liquidationFee,
    required this.otherFees,
  });

  final DateTime operationDate;
  final DateTime liquidationDate;
  final Company company;
  final BigInt unityValue;
  final BigInt taxes;
  final BigInt operationFee;
  final BigInt emoluments;
  final BigInt liquidationFee;
  final BigInt otherFees;
}
