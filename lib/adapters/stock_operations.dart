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
      unityValue: this['unityValue']!.asMoney(),
      operationFee: this['operationFee']!.asMoney(),
      emoluments: this['emoluments']!.asMoney(),
      liquidationFee: this['liquidationFee']!.asMoney(),
      otherFees: this['otherFees']!.asMoney(),
      unities: BigInt.parse(this['unities']!),
      taxes: this['taxes']!.asMoney(),
      operationType: this['operationType']!
          .toOperationType(), // Assuming all are 'buy', change if needed
    );
  }
}
