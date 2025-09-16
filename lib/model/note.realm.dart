// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class Note extends _Note with RealmEntity, RealmObjectBase, RealmObject {
  Note(
    String id,
    String title,
    String content,
    DateTime created,
    int color,
    bool isFavorite,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'content', content);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'color', color);
    RealmObjectBase.set(this, 'isFavorite', isFavorite);
  }

  Note._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get content => RealmObjectBase.get<String>(this, 'content') as String;
  @override
  set content(String value) => RealmObjectBase.set(this, 'content', value);

  @override
  DateTime get created =>
      RealmObjectBase.get<DateTime>(this, 'created') as DateTime;
  @override
  set created(DateTime value) => RealmObjectBase.set(this, 'created', value);

  @override
  int get color => RealmObjectBase.get<int>(this, 'color') as int;
  @override
  set color(int value) => RealmObjectBase.set(this, 'color', value);

  @override
  bool get isFavorite => RealmObjectBase.get<bool>(this, 'isFavorite') as bool;
  @override
  set isFavorite(bool value) => RealmObjectBase.set(this, 'isFavorite', value);

  @override
  Stream<RealmObjectChanges<Note>> get changes =>
      RealmObjectBase.getChanges<Note>(this);

  @override
  Stream<RealmObjectChanges<Note>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Note>(this, keyPaths);

  @override
  Note freeze() => RealmObjectBase.freezeObject<Note>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'title': title.toEJson(),
      'content': content.toEJson(),
      'created': created.toEJson(),
      'color': color.toEJson(),
      'isFavorite': isFavorite.toEJson(),
    };
  }

  static EJsonValue _toEJson(Note value) => value.toEJson();
  static Note _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'title': EJsonValue title,
        'content': EJsonValue content,
        'created': EJsonValue created,
        'color': EJsonValue color,
        'isFavorite': EJsonValue isFavorite,
      } =>
        Note(
          fromEJson(id),
          fromEJson(title),
          fromEJson(content),
          fromEJson(created),
          fromEJson(color),
          fromEJson(isFavorite),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Note._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Note, 'Note', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('content', RealmPropertyType.string),
      SchemaProperty('created', RealmPropertyType.timestamp),
      SchemaProperty('color', RealmPropertyType.int),
      SchemaProperty('isFavorite', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
