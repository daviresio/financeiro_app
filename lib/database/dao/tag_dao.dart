import 'package:financeiro_app/database/database.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'tag_dao.g.dart';

@UseDao(tables: [Tags])
class TagDao extends DatabaseAccessor<Database> with _$TagDaoMixin {
  final Database db;

  TagDao(this.db) : super(db);

  Stream<List<Tag>> listTags() => select(tags).watch();

  Future insertTag(Tag tag) => into(tags).insert(tag.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now()));

  Future updateTag(Tag tag) => update(tags).replace(tag.copyWith(updatedAt: DateTime.now()));

  Future deleteTag(id) => (delete(tags)..where((t) => t.id.equals(id))).go();

}