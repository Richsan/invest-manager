import 'package:collection/collection.dart';
import 'package:invest_manager/models/stock_operation.dart';

StockOperationTaxReport taxReport(
  List<StockOperation> operations,
  int year,
) {
  operations.sortBy((element) => element.operationDate);
  final Map<String, List<StockOperation>> opsByTicker =
      groupBy(operations, (op) => op.ticker);

  final List<StockOperationReportPosition> positions = [];
  final List<StockOperationSellProfitReport> profits = [];

  for (final tickerOps in opsByTicker.entries) {
    final company = tickerOps.value.first.company;

    var position = StockOperationReportPosition(
      ticker: tickerOps.key,
      company: company,
    );

    for (final op in tickerOps.value) {
      if (op.operationType == OperationType.buy) {
        final newUnities = position.unities +
            BigInt.from((op.unities.toDouble() * op.splitFactor).round());
        position = position.copyWith(
          unities: newUnities,
          weightedValue:
              (((position.weightedValue * position.unities.toDouble()) +
                          ((op.unities.toDouble() * op.unityValue.toDouble()) +
                                  op.additionalCost().toDouble()) /
                              100)
                      .toDouble() /
                  newUnities.toDouble()),
        );
      } else if (op.operationType == OperationType.sell) {
        final profit = StockOperationSellProfitReport(
          sellDate: op.operationDate,
          liquidationDate: op.liquidationDate,
          ticker: tickerOps.key,
          company: company,
          costs: op.additionalCost(),
          referenceWeightedValue: position.weightedValue,
          soldUnities: op.unities,
          soldValue: op.unityValue,
        );

        profits.add(profit);

        final newUnities = position.unities -
            BigInt.from((op.unities.toDouble() * op.splitFactor).round());
        position = position.copyWith(
          unities: newUnities,
        );
      }
    }
    positions.add(position);
  }

  return StockOperationTaxReport(
    positions:
        positions.where((element) => element.unities > BigInt.zero).toList(),
    sellProfits: profits
        .where((element) => element.liquidationDate.year == (year - 1))
        .toList(),
  );
}
