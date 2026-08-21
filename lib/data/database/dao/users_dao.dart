import 'package:drift/drift.dart';
import 'package:system_loja/core/models/user.dart';
import 'package:system_loja/data/database/system_database.dart';
import 'package:system_loja/data/database/table/system/users_records.dart';
import 'package:system_loja/data/entry/user_entry.dart';

part 'users_dao.g.dart';

/// DAO Drift de usuários no [SystemDatabase].
///
/// {@category persistencia}
/// {@subCategory Sistema}
///
/// CRUD de [User] sobre [UsersRecords], usando [UserEntry] como linha.
/// Persistência principal é Drift.
@DriftAccessor(tables: [UsersRecords])
class UsersDao extends DatabaseAccessor<SystemDatabase> with _$UsersDaoMixin {

  UsersDao(this.db) : super(db);
  final SystemDatabase db;

  /// Remove um usuário pelo [id].
  ///
  /// Retorna o número de linhas afetadas (normalmente 1 ou 0).
  Future<int> deleteUser(int id) => (delete(usersRecords)..where((tbl) => tbl.id.equals(id))).go();

  /// Busca um usuário pelo e-mail.
  ///
  /// Retorna null se não houver correspondência.
  Future<User?> findByEmail(String email) async {
    final row = await (select(
      usersRecords,
    )..where((tbl) => tbl.email.equals(email))).getSingleOrNull();
    return row?.toUser();
  }

  /// Retorna todos os usuários como objetos de domínio [User].
  Future<List<User>> getAll() async {
    final rows = await select(usersRecords).get();
    return rows.map((e) => e.toUser()).toList();
  }

  /// Busca um usuário pelo [id].
  ///
  /// Retorna null se o usuário não for encontrado.
  Future<User?> getById(int id) async {
    final row = await (select(
      usersRecords,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row?.toUser();
  }

  /// Insere um usuário e devolve a linha persistida como [User].
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

  /// Atualiza um usuário existente.
  ///
  /// Retorna true se a atualização foi bem-sucedida.
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
