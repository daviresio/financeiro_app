import 'package:financeiro_app/database/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'subcategoria_dao.g.dart';

@UseDao(tables: [Subcategorias])
class SubcategoriaDao extends DatabaseAccessor<Database> with _$SubcategoriaDaoMixin {
  final Database db;

  SubcategoriaDao(this.db) : super(db);

  Stream<List<Subcategoria>> listSubcategorias() => select(subcategorias).watch();

  Future insertSubcategoria(Subcategoria subcategoria) => into(subcategorias).insert(subcategoria.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now()));

  Future updateSubcategoria(Subcategoria subcategoria) => update(subcategorias).replace(subcategoria.copyWith(updatedAt: DateTime.now()));

  Future deleteSubcategoria(id) => (delete(subcategorias)..where((t) => t.id.equals(id))).go();

}