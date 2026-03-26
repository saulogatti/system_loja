import 'package:drift/drift.dart';
import 'package:system_loja/core/models/user.dart';
import 'package:system_loja/data/database/system_database.dart';
import 'package:system_loja/data/database/table/system/users_records.dart';
import 'package:system_loja/data/entry/user_entry.dart';

part 'users_dao.g.dart';

@DriftAccessor(tables: [UsersRecords])
class UsersDao extends DatabaseAccessor<SystemDatabase> with _$UsersDaoMixin {
  final SystemDatabase db;

  UsersDao(this.db) : super(db);

  Future<int> deleteUser(int id) {
    return (delete(usersRecords)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<User?> findByEmail(String email) async {
    final row = await (select(usersRecords)..where((tbl) => tbl.email.equals(email))).getSingleOrNull();
    return row?.toUser();
  }

  Future<List<User>> getAll() async {
    final rows = await select(usersRecords).get();
    return rows.map((e) => e.toUser()).toList();
  }

  Future<User?> getById(int id) async {
    final row = await (select(usersRecords)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row?.toUser();
  }

  Future<User?> insertUser(User user) async {
    final userEntry = UserEntry.fromUser(user);
    final userEntryResult = await into(usersRecords).insertReturning(
      UsersRecordsCompanion(
        email: Value(userEntry.email),
        name: Value(userEntry.name),
        passwordHash: Value(userEntry.passwordHash),
        permission: Value(userEntry.permission),
        registrationDate: Value(userEntry.registrationDate),
        lastUpdatedDate: Value(userEntry.lastUpdatedDate),
      ),
    );
    return userEntryResult.toUser();
  }

  Future<bool> updateUser(User user) async {
    final userEntry = UserEntry.fromUser(user);
    final result = await update(usersRecords).replace(
      UsersRecordsCompanion(
        id: Value(userEntry.id),
        email: Value(userEntry.email),
        name: Value(userEntry.name),
        passwordHash: Value(userEntry.passwordHash),
        permission: Value(userEntry.permission),
        lastUpdatedDate: Value(DateTime.now()),
        registrationDate: Value(userEntry.registrationDate),
      ),
    );
    return result;
  }
}
