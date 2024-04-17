import 'package:intl/intl.dart';
import 'package:invest_manager/adapters/string.dart';
import 'package:invest_manager/models/b3.dart';
import 'package:invest_manager/models/stock_operation.dart';

final DateFormat dateFormat = DateFormat("MMMM d, yyyy");

extension MapToStockOperation on Map<String, String> {
  StockOperation toStockOperation(Company company) {
    return StockOperation(
      operationDate: dateFormat.parse(this['operationDate']!),
      liquidationDate: dateFormat.parse(this['liquidationDate']!),
      splitFactor: double.parse(this['splitFactor']!),
      company: company,
      ticker: this['ticker']!,
      unityValue: this['unityValue']!.doubleToMoney(),
      operationFee: this['operationFee']!.doubleToMoney(),
      emoluments: this['emoluments']!.doubleToMoney(),
      liquidationFee: this['liquidationFee']!.doubleToMoney(),
      otherFees: this['otherFees']!.doubleToMoney(),
      unities: BigInt.parse(this['unities']!),
      taxes: this['taxes']!.doubleToMoney(),
      tags: this['tags']?.trim().split('-') ?? [],
      operationType: this['operationType']!
          .toOperationType(), // Assuming all are 'buy', change if needed
    );
  }
}
