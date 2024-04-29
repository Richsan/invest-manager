import 'package:equatable/equatable.dart';
import 'package:invest_manager/adapters/number.dart';
import 'package:invest_manager/models/b3.dart';
import 'package:uuid/uuid.dart';

enum OperationType {
  buy,
  sell,
}

class StockOperation extends Equatable {
  StockOperation({
    UuidValue? id,
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
    this.tags = const [],
    this.splitFactor = 1,
  }) : id = id ?? const Uuid().v4obj();

  final UuidValue id;
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
  final List<String> tags;

  BigInt additionalCost() =>
      (taxes + liquidationFee + operationFee + emoluments + otherFees);

  @override
  List<Object> get props => [
        id,
        operationDate,
        liquidationDate,
        company,
        ticker,
        unityValue,
        taxes,
        operationFee,
        emoluments,
        liquidationFee,
        otherFees,
        unities,
        splitFactor,
        operationType,
      ];
}

class StockOperationReportPosition extends Equatable {
  StockOperationReportPosition({
    BigInt? unities,
    double? weightedValue,
    required this.ticker,
    required this.company,
  })  : weightedValue = weightedValue ?? 0,
        unities = unities ?? BigInt.zero;

  final BigInt unities;
  final double weightedValue;
  final String ticker;
  final Company company;

  BigInt get total => (weightedValue * unities.toDouble()).asMoneyInt();

  StockOperationReportPosition copyWith({
    BigInt? unities,
    double? weightedValue,
    String? ticker,
    Company? company,
  }) =>
      StockOperationReportPosition(
        unities: unities ?? this.unities,
        weightedValue: weightedValue ?? this.weightedValue,
        ticker: ticker ?? this.ticker,
        company: company ?? this.company,
      );

  @override
  List<Object> get props => [
        unities,
        ticker,
        company,
        weightedValue,
      ];
}

class StockOperationSellProfitReport extends Equatable {
  StockOperationSellProfitReport({
    required this.sellDate,
    required this.liquidationDate,
    required this.ticker,
    required this.company,
    required this.referenceWeightedValue,
    required this.soldUnities,
    required this.soldValue,
  }) : profitAmount = (soldValue * soldUnities) -
            (referenceWeightedValue * soldUnities.toDouble()).asMoneyInt();

  final DateTime sellDate;
  final DateTime liquidationDate;
  final BigInt profitAmount;
  final String ticker;
  final Company company;
  final double referenceWeightedValue;
  final BigInt soldUnities;
  final BigInt soldValue;

  @override
  List<Object> get props => [
        sellDate,
        profitAmount,
        ticker,
        company,
        referenceWeightedValue,
        soldUnities,
        soldValue,
      ];
}

class StockOperationTaxReport extends Equatable {
  const StockOperationTaxReport({
    required this.positions,
    required this.sellProfits,
  });

  final List<StockOperationReportPosition> positions;
  final List<StockOperationSellProfitReport> sellProfits;

  @override
  List<Object> get props => [
        positions,
        sellProfits,
      ];
}
