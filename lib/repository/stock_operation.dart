import 'package:invest_manager/adapters/entity.dart';
import 'package:invest_manager/components/b3.dart';
import 'package:invest_manager/components/db.dart';
import 'package:invest_manager/models/stock_operation.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

Future<void> save(Future<Database> database, StockOperation operation) async {
  await (await database).transaction((txn) async {
    await txn.insert('stock_operation', operation.toEntity(),
        conflictAlgorithm: ConflictAlgorithm.rollback);
  });
}

Future<void> saveAll(
    Future<Database> database, List<StockOperation> operations) async {
  final b = (await database).batch();

  for (StockOperation operation in operations) {
    b.insert('stock_operation', operation.toEntity(),
        conflictAlgorithm: ConflictAlgorithm.rollback);
  }

  print('saved');

  await b.commit().onError((error, stackTrace) {
    print('error->$error');
    throw Exception();
  });
}

Future<List<StockOperation>> getAllStockOperations(
    Future<Database> database) async {
  final companies = await listedCompanies;
  return (await (await database).query(
    'stock_operation',
    orderBy: 'stock_operation_operation_date desc',
  ))
      .map((e) => e.fromStockOperationEntity(companies.firstWhere(
          (element) => (e['company_tax_id'] as String) == element.taxId)))
      .toList();
}
