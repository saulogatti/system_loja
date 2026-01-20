import 'package:drift/drift.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/table/clientes_records.dart';

part 'cliente_dao.g.dart';

@DriftAccessor(tables: [ClientesRecords])
class ClienteDao extends DatabaseAccessor<AppDatabase> with _$ClienteDaoMixin {
  ClienteDao(super.db);

  Future<int> deleteCliente(int id) {
    return (delete(clientesRecords)..where((t) => t.id.equals(id))).go();
  }

  Future<List<ClientesRecord>> getAll() {
    return select(clientesRecords).get();
  }

  Future<ClientesRecord?> getById(int id) {
    return (select(
      clientesRecords,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertCliente(ClientesRecordsCompanion data) {
    return into(clientesRecords).insert(data);
  }

  Future<int> updateCliente(ClientesRecordsCompanion data) async {
    return await update(clientesRecords).replace(data) ? 1 : 0;
  }
}
