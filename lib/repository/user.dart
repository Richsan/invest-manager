import 'package:invest_manager/adapters/entity.dart';
import 'package:invest_manager/components/db.dart';
import 'package:invest_manager/models/user.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

Future<void> save(User user) async {
  await (await getUsersDatabase()).transaction((txn) async {
    await txn.insert('user', user.toEntity(),
        conflictAlgorithm: ConflictAlgorithm.rollback);
  });
}

Future<User?> getUserName(String username) async {
  final user = (await (await getUsersDatabase())
          .query('user', where: 'username = ?', whereArgs: [username]))
      .map(
        (e) => e.fromUserEntity(),
      )
      .singleOrNull;

  return user;
}
