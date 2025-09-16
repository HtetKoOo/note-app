import 'package:note_app/model/note.dart';
import 'package:realm/realm.dart';

class NoteService {
  final Realm realm;

  const NoteService(this.realm);

  Stream<RealmResultsChanges<Note>> getAllNotes() {
    return realm.query<Note>('TRUEPREDICATE SORT(created DESC)').changes;
  }

  Stream<RealmResultsChanges<Note>> getAllFavoriteNotes() {
    return realm.query<Note>('isFavorite == true SORT(created DESC)').changes;
  }

  void addNote(Note note) {
    realm.write(() {
      realm.add(note);
    });
  }

  Note _getNote(String id) {
    final Note? note = realm.find<Note>(id);
    if (note != null) {
      return note;
    } else {
      throw Exception("Not found");
    }
  }

  void updateNote(Note note) {
    realm.write(() {
      final myNote = _getNote(note.id);
      myNote.title = note.title;
      myNote.content = note.content;
      myNote.created = note.created;
      myNote.color = note.color;
    });
  }

  void deleteNote(Note note) {
    realm.write(() {
      realm.delete(note);
    });
  }

  List<Note> searchNote(String text){
    return realm.query<Note>(r'title CONTAINS[c] $0 || content CONTAINS[c] $0', [text]).map((e) => e).toList();
  }

  void toggleFavoriteStatus(Note note) {
    realm.write(() {
      final myNote = _getNote(note.id);
      myNote.isFavorite = !myNote.isFavorite;
    });
  }
  
}
