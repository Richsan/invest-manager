import 'package:invest_manager/adapters/string.dart';
import 'package:invest_manager/models/b3.dart';
import 'package:invest_manager/models/stock_operation.dart';
import 'package:uuid/uuid.dart';

extension StockOperationEntity on StockOperation {
  Map<String, dynamic> toEntity() {
    return {
      'stock_operation_id': id.uuid,
      'stock_operation_operation_date': operationDate.toIso8601String(),
      'company_tax_id': company.taxId,
      'ticker_code': ticker,
      'stock_operation_liquidation_date': liquidationDate.toIso8601String(),
      'stock_operation_unity_value': unityValue.toInt(),
      'stock_operation_unities': unities.toInt(),
      'stock_operation_taxes': taxes.toInt(),
      'stock_operation_operation_fee': operationFee.toInt(),
      'stock_operation_emoluments': emoluments.toInt(),
      'stock_operation_liquidation_fee': liquidationFee.toInt(),
      'stock_operation_other_fees': otherFees.toInt(),
      'stock_operation_split_factor': splitFactor,
      'stock_operation_type': operationType.toEnumString(),
      'stock_operation_tags': tags.join(','),
    };
  }
}

extension FromEntity on Map<String, dynamic> {
  StockOperation fromStockOperationEntity(Company company) {
    final String tags = this['stock_operation_tags'] ?? '';

    return StockOperation(
      id: UuidValue.fromString(this['stock_operation_id']),
      operationDate: DateTime.parse(this['stock_operation_operation_date']),
      liquidationDate: DateTime.parse(this['stock_operation_liquidation_date']),
      company: company,
      ticker: this['ticker_code'],
      tags: tags.trim().split(','),
      unityValue: BigInt.from(this['stock_operation_unity_value']),
      taxes: BigInt.from(this['stock_operation_taxes']),
      operationFee: BigInt.from(this['stock_operation_operation_fee']),
      emoluments: BigInt.from(this['stock_operation_emoluments']),
      liquidationFee: BigInt.from(this['stock_operation_liquidation_fee']),
      otherFees: BigInt.from(this['stock_operation_other_fees']),
      unities: BigInt.from(this['stock_operation_unities']),
      splitFactor: this['stock_operation_split_factor'].toDouble(),
      operationType: (this['stock_operation_type'] as String).toOperationType(),
    );
  }
}

extension OperationTypeStr on OperationType {
  String toEnumString() {
    return this == OperationType.buy ? 'buy' : 'sell';
  }
}
