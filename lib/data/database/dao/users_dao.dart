import 'package:drift/drift.dart';
import 'package:system_loja/core/models/user.dart';
import 'package:system_loja/data/database/system_database.dart';
import 'package:system_loja/data/database/table/users_records.dart';

part 'users_dao.g.dart';

@DriftAccessor(tables: [UsersRecords])
class UsersDao extends DatabaseAccessor<SystemDatabase> with _$UsersDaoMixin {
  final SystemDatabase db;

  UsersDao(this.db) : super(db);

  Future<int> deleteUser(int id) {
    return (delete(usersRecords)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<User>> getAll() {
    return select(usersRecords).get();
  }

  Future<User?> getById(int id) {
    return (select(
      usersRecords,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertUser(User user) {
    return into(usersRecords).insert(user.toInsertable());
  }

  Future<bool> updateUser(User user) {
    return update(usersRecords).replace(user.toInsertable());
  }
}
