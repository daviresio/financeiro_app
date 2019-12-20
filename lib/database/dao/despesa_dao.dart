import 'package:financeiro_app/database/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'despesa_dao.g.dart';

@UseDao(tables: [Despesas])
class DespesaDao extends DatabaseAccessor<Database> with _$DespesaDaoMixin {
  final Database db;

  DespesaDao(this.db) : super(db);

  Stream<List<Despesa>> listDespesas() => select(despesas).watch();

  Future insertDespesa(Despesa despesa) => into(despesas).insert(despesa.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now()));

  Future updateDespesa(Despesa despesa) => update(despesas).replace(despesa.copyWith(updatedAt: DateTime.now()));

  Future deleteDespesa(id) => (delete(despesas)..where((t) => t.id.equals(id))).go();

}