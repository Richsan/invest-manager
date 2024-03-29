import 'package:invest_manager/models/stock_operation.dart';

final List<StockOperation> _db = [];

Future<void> save(StockOperation operation) {
  return Future.delayed(const Duration(seconds: 1))
      .then((value) => _db.add(operation));
}

Future<List<StockOperation>> getAllStockOperations() =>
    Future.delayed(const Duration(seconds: 3)).then((value) => _db);

Future<List<StockOperation>> getAll() {
  return Future.delayed(const Duration(seconds: 1)).then((value) => _db);
}
