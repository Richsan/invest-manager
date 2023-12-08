import 'package:invest_manager/models/stock_operation.dart';

final List<StockOperation> _db = [];

void save(StockOperation operation) {
  _db.add(operation);
}

List<StockOperation> getAll() {
  return _db;
}
