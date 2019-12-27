import 'package:financeiro_app/database/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'categoria_dao.g.dart';

@UseDao(tables: [Categorias])
class CategoriaDao extends DatabaseAccessor<Database> with _$CategoriaDaoMixin {
  final Database db;

  CategoriaDao(this.db) : super(db);

  Future<Categoria> find(int id) => (select(categorias)..where((t) => t.id.equals(id))).getSingle();

  Stream<List<Categoria>> listCategorias() => select(categorias).watch();

  Stream<List<Categoria>> search(String v) => (select(categorias)..where((t) => t.nome.like('%$v%'))).watch();

  Future insertCategoria(Categoria categoria) => into(categorias).insert(categoria.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now()));

  Future updateCategoria(Categoria categoria) => update(categorias).replace(categoria.copyWith(updatedAt: DateTime.now()));

  Future deleteCategoria(id) => (delete(categorias)..where((t) => t.id.equals(id))).go();

}