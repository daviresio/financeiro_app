import 'package:financeiro_app/database/dao/tag_dao.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'dao/categoria_dao.dart';
import 'dao/conta_dao.dart';
import 'dao/despesa_dao.dart';
import 'dao/subcategoria_dao.dart';

part 'database.g.dart';

class Despesas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text()();
  TextColumn get anexo => text()();
  TextColumn get localizacao => text()();
  TextColumn get observacao => text()();
  BoolColumn get despesaFixa => boolean().withDefault(Constant(false))();
  BoolColumn get pago => boolean().withDefault(Constant(false))();
  BoolColumn get favorito => boolean().withDefault(Constant(false))();
  DateTimeColumn get data => dateTime()();
  DateTimeColumn get lembrete => dateTime()();
  IntColumn get categoriaId => integer().named('categoria_id')();
  IntColumn get contaId => integer().named('conta_id')();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();
}

class Categorias extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text()();
  TextColumn get icone => text()();
  TextColumn get cor => text()();
  TextColumn get tipo => text()();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();
}

class Subcategorias extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text()();
  IntColumn get categoriaId => integer().named('categoria_id')();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();
}

class Contas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text()();
  TextColumn get tipo => text()();
  TextColumn get cor => text()();
  BoolColumn get incluirSomaTelaInicial => boolean().withDefault(Constant(false))();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();
}

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text()();
  IntColumn get despesaId => integer().named('despesa_id')();
  IntColumn get receitaId => integer().named('receita_id')();
  DateTimeColumn get createdAt => dateTime().named('created_at')();
  DateTimeColumn get updatedAt => dateTime().named('updated_at')();
}


@UseMoor(tables: [Despesas, Categorias, Subcategorias, Contas, Tags], daos: [TagDao])
class Database extends _$Database {
  static Database instance = Database._internal();

  CategoriaDao categoriaDao;
  SubcategoriaDao subcategoriaDao;
  ContaDao contaDao;
  DespesaDao despesaDao;
  TagDao tagDao;

  Database._internal() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite', logStatements: true)..doWhenOpened((e) => e.runCustom('PRAGMA foreign_keys = ON'))) {
    categoriaDao = CategoriaDao(this);
    subcategoriaDao = SubcategoriaDao(this);
    contaDao = ContaDao(this);
    despesaDao = DespesaDao(this);
    tagDao = TagDao(this);
  }


  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      onCreate: (Migrator m) async {
        m.createAllTables().then((onValue) async {
          await into(categorias).insert(Categoria(nome: 'Alimentacao', icone: 'alimentacao', cor: 'azul', tipo: 'despesa', createdAt: DateTime.now(), updatedAt: DateTime.now()));
          await into(categorias).insert(Categoria(nome: 'Educacao', icone: 'educacao', cor: 'azul', tipo: 'despesa', createdAt: DateTime.now(), updatedAt: DateTime.now()));
          await into(categorias).insert(Categoria(nome: 'Lazer', icone: 'lazer', cor: 'vermelho', tipo: 'despesa', createdAt: DateTime.now(), updatedAt: DateTime.now()));
          await into(categorias).insert(Categoria(nome: 'Moradia', icone: 'moradia', cor: 'roxo_claro', tipo: 'despesa', createdAt: DateTime.now(), updatedAt: DateTime.now()));
          await into(categorias).insert(Categoria(nome: 'Pagamentos', icone: 'pagamentos', cor: 'laranjado', tipo: 'despesa', createdAt: DateTime.now(), updatedAt: DateTime.now()));
          await into(categorias).insert(Categoria(nome: 'Roupa', icone: 'roupa', cor: 'verde', tipo: 'despesa', createdAt: DateTime.now(), updatedAt: DateTime.now()));
          await into(categorias).insert(Categoria(nome: 'Saude', icone: 'saude', cor: 'azul_claro', tipo: 'despesa', createdAt: DateTime.now(), updatedAt: DateTime.now()));
          await into(categorias).insert(Categoria(nome: 'Transporte', icone: 'transporte', cor: 'roxo', tipo: 'despesa', createdAt: DateTime.now(), updatedAt: DateTime.now()));

          await into(categorias).insert(Categoria(nome: 'Investimentos', icone: 'investimentos', cor: 'verde', tipo: 'receita', createdAt: DateTime.now(), updatedAt: DateTime.now()));
          await into(categorias).insert(Categoria(nome: 'Outros', icone: 'outros', cor: 'vermelho', tipo: 'receita', createdAt: DateTime.now(), updatedAt: DateTime.now()));
          await into(categorias).insert(Categoria(nome: 'Presente', icone: 'presente', cor: 'roxo', tipo: 'receita', createdAt: DateTime.now(), updatedAt: DateTime.now()));
          await into(categorias).insert(Categoria(nome: 'Premios', icone: 'premios', cor: 'laranjado', tipo: 'receita', createdAt: DateTime.now(), updatedAt: DateTime.now()));
          await into(categorias).insert(Categoria(nome: 'Salario', icone: 'salario', cor: 'azul', tipo: 'receita', createdAt: DateTime.now(), updatedAt: DateTime.now()));

          await into(contas).insert(Conta(nome: 'Carteira', tipo: 'dinheiro', cor: 'azul', incluirSomaTelaInicial: true, createdAt: DateTime.now(), updatedAt: DateTime.now()));
          await into(contas).insert(Conta(nome: 'Dinheiro', tipo: 'dinheiro', cor: 'roxo', incluirSomaTelaInicial: true, createdAt: DateTime.now(), updatedAt: DateTime.now()));


        });
      });


}