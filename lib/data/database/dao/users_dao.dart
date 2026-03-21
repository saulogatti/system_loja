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

  Future<User?> findByEmail(String email) {
    return (select(
      usersRecords,
    )..where((tbl) => tbl.email.equals(email))).getSingleOrNull();
  }

  Future<List<User>> getAll() {
    return select(usersRecords).get();
  }

  Future<User?> getById(int id) {
    return (select(
      usersRecords,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
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
    return UserEntry.fromUser(userEntryResult);
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
