import 'dart:async';

import 'package:financeiro_app/database/database.dart';
import 'package:financeiro_app/database/joins/receita_joins.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'receita_dao.g.dart';

@UseDao(tables: [Receitas, Categorias, Contas])
class ReceitaDao extends DatabaseAccessor<Database> with _$ReceitaDaoMixin {
  final Database db;

  ReceitaDao(this.db) : super(db);

  Future<Receita> find(int id) => (select(receitas)..where((t) => t.id.equals(id))).getSingle();

  Stream<List<Receita>> list() => select(receitas).watch();

  Stream<List<Receita>> listByDate(DateTime d) => (select(receitas)..where((t) => t.data.year.equals(d.year) & t.data.month.equals(d.month))).watch();

  Future add(Receita receita) => into(receitas).insert(receita.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now()));

  Future updat(Receita receita) => update(receitas).replace(receita.copyWith(updatedAt: DateTime.now()));

  Future delet(id) => (delete(receitas)..where((t) => t.id.equals(id))).go();
  

  Stream<List<ReceitaComRelacionamentos>> listReceitasComRelacionamentos({DateTime data}) => (select(receitas)..where((t) => t.data.year.equals(data.year) & t.data.month.equals(data.month))..orderBy([(t) => OrderingTerm(expression: t.data, mode: OrderingMode.desc)]))
      .join([leftOuterJoin(categorias, categorias.id.equalsExp(receitas.categoriaId)), leftOuterJoin(contas, contas.id.equalsExp(receitas.contaId)),])
      .watch().map((rows) {
    return rows.map((row) {
      return ReceitaComRelacionamentos(row.readTable(receitas), row.readTable(categorias), row.readTable(contas));
    }).toList();
  });

  Stream<double> totalRecebidoOuPendente({bool recebido, DateTime data}) =>
      (select(receitas)..where((t) => t.recebido.equals(recebido))..where((t) => t.data.year.equals(data.year))..where((t) => t.data.month.equals(data.month)))
          .watch().transform(new StreamTransformer.fromHandlers(handleData: (List<Receita> data, EventSink<double> sink) {
        double v = 0;
        try {
          v = data.map((value) => value.valor).reduce((val, el) => val + el);
        } catch (e) {
          print(e.toString());
        }
        sink.add(v);
      }));

}
