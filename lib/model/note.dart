import 'package:realm/realm.dart';

part 'note.realm.dart';

@RealmModel()
class _Note {
  @PrimaryKey()
  late String id;
  late String title;
  late String content;
  late DateTime created;
  late int color;

  @override
  String toString() {
    return 'Note(id: $id, title: $title, content: $content, created: $created,color:$color)';
  }
}
