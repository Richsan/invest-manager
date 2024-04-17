import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

Future<Database> getDatabase() async {
  final databasePath = await getDatabasesPath();

  final path = join(databasePath, 'stocks.db');

  return await openDatabase(
    path,
    onCreate: (db, version) async {
      await db
          .execute(
            'CREATE TABLE stock_operation(stock_operation_id TEXT PRIMARY KEY,'
            ' stock_operation_operation_date TEXT NOT NULL, '
            ' company_tax_id TEXT NOT NULL,'
            ' ticker_code TEXT NOT NULL,'
            ' stock_operation_liquidation_date TEXT NOT NULL, '
            ' stock_operation_unity_value INTEGER NOT NULL,'
            ' stock_operation_unities INTEGER NOT NULL,'
            ' stock_operation_taxes INTEGER NOT NULL,'
            ' stock_operation_operation_fee INTEGER NOT NULL,'
            ' stock_operation_emoluments INTEGER NOT NULL,'
            ' stock_operation_liquidation_fee INTEGER NOT NULL,'
            ' stock_operation_other_fees INTEGER NOT NULL,'
            ' stock_operation_split_factor DOUBLE NOT NULL,'
            ' stock_operation_type TEXT NOT NULL,'
            ' stock_operation_tags TEXT'
            ')',
          )
          .onError((error, stackTrace) => print('$error'));
    },
    version: 1,
  );
}
