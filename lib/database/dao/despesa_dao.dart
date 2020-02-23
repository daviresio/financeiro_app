import 'dart:async';

import 'package:financeiro_app/database/database.dart';
import 'package:financeiro_app/database/joins/despesa_joins.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'despesa_dao.g.dart';

@UseDao(tables: [Despesas, Categorias, Contas])
class DespesaDao extends DatabaseAccessor<Database> with _$DespesaDaoMixin {
  final Database db;

  DespesaDao(this.db) : super(db);

  Future<Despesa> find(int id) => (select(despesas)..where((t) => t.id.equals(id))).getSingle();

  Stream<List<Despesa>> list() => select(despesas).watch();

  Stream<List<Despesa>> listByDate(DateTime d) => (select(despesas)..where((t) => t.data.year.equals(d.year) & t.data.month.equals(d.month))).watch();

  Future insertDespesa(Despesa despesa) => into(despesas).insert(despesa.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now()));

  Future updateDespesa(Despesa despesa) => update(despesas).replace(despesa.copyWith(updatedAt: DateTime.now()));

  Future deleteDespesa(id) => (delete(despesas)..where((t) => t.id.equals(id))).go();

  Future<double> getMediaValorPorCategoria(int categoriaId) => (select(despesas)..where((t) => t.categoriaId.equals(categoriaId))).get().then((onValue) {
    if(onValue.length == 0) return 0.0;
    return onValue.map((m) => m.valor).reduce((a, b) => a + b) / onValue.length;
  });

  Stream<List<DespesaComRelacionamentos>> listDespesasComRelacionamentos({DateTime data}) => (select(despesas)..where((t) => t.data.year.equals(data.year) & t.data.month.equals(data.month))..orderBy([(t) => OrderingTerm(expression: t.data, mode: OrderingMode.desc)]))
      .join([leftOuterJoin(categorias, categorias.id.equalsExp(despesas.categoriaId)), leftOuterJoin(contas, contas.id.equalsExp(despesas.contaId)),])
      .watch().map((rows) {
    return rows.map((row) {
      return DespesaComRelacionamentos(row.readTable(despesas), row.readTable(categorias), row.readTable(contas));
    }).toList();
  });

  Stream<double> totalPagoOuPendente({bool pago, DateTime data}) =>
      (select(despesas)..where((t) => t.pago.equals(pago))..where((t) => t.data.year.equals(data.year))..where((t) => t.data.month.equals(data.month)))
          .watch().transform(new StreamTransformer.fromHandlers(handleData: (List<Despesa> data, EventSink<double> sink) {
        double v = 0;
        try {
          v = data.map((value) => value.valor).reduce((val, el) => val + el);
        } catch (e) {
          print(e.toString());
        }
        sink.add(v);
      }));

}
