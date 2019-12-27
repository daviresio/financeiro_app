import 'package:financeiro_app/database/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'conta_dao.g.dart';

@UseDao(tables: [Contas])
class ContaDao extends DatabaseAccessor<Database> with _$ContaDaoMixin {
  final Database db;

  ContaDao(this.db) : super(db);

  Future<Conta> find(int id) => (select(contas)..where((t) => t.id.equals(id))).getSingle();

  Stream<List<Conta>> listContas() => select(contas).watch();

  Future insertConta(Conta conta) => into(contas).insert(conta.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now()));

  Future updateConta(Conta conta) => update(contas).replace(conta.copyWith(updatedAt: DateTime.now()));

  Future deleteConta(id) => (delete(contas)..where((t) => t.id.equals(id))).go();

}