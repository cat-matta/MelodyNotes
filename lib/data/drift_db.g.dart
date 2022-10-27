// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_db.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Score extends DataClass implements Insertable<Score> {
  final int id;
  final String name;
  final String file;
  final String composer;
  const Score(
      {required this.id,
      required this.name,
      required this.file,
      required this.composer});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['file'] = Variable<String>(file);
    map['composer'] = Variable<String>(composer);
    return map;
  }

  ScoresCompanion toCompanion(bool nullToAbsent) {
    return ScoresCompanion(
      id: Value(id),
      name: Value(name),
      file: Value(file),
      composer: Value(composer),
    );
  }

  factory Score.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Score(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      file: serializer.fromJson<String>(json['file']),
      composer: serializer.fromJson<String>(json['composer']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'file': serializer.toJson<String>(file),
      'composer': serializer.toJson<String>(composer),
    };
  }

  Score copyWith({int? id, String? name, String? file, String? composer}) =>
      Score(
        id: id ?? this.id,
        name: name ?? this.name,
        file: file ?? this.file,
        composer: composer ?? this.composer,
      );
  @override
  String toString() {
    return (StringBuffer('Score(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('file: $file, ')
          ..write('composer: $composer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, file, composer);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Score &&
          other.id == this.id &&
          other.name == this.name &&
          other.file == this.file &&
          other.composer == this.composer);
}

class ScoresCompanion extends UpdateCompanion<Score> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> file;
  final Value<String> composer;
  const ScoresCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.file = const Value.absent(),
    this.composer = const Value.absent(),
  });
  ScoresCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String file,
    required String composer,
  })  : name = Value(name),
        file = Value(file),
        composer = Value(composer);
  static Insertable<Score> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? file,
    Expression<String>? composer,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (file != null) 'file': file,
      if (composer != null) 'composer': composer,
    });
  }

  ScoresCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? file,
      Value<String>? composer}) {
    return ScoresCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      file: file ?? this.file,
      composer: composer ?? this.composer,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (file.present) {
      map['file'] = Variable<String>(file.value);
    }
    if (composer.present) {
      map['composer'] = Variable<String>(composer.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScoresCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('file: $file, ')
          ..write('composer: $composer')
          ..write(')'))
        .toString();
  }
}

class $ScoresTable extends Scores with TableInfo<$ScoresTable, Score> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScoresTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _fileMeta = const VerificationMeta('file');
  @override
  late final GeneratedColumn<String> file = GeneratedColumn<String>(
      'file', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _composerMeta = const VerificationMeta('composer');
  @override
  late final GeneratedColumn<String> composer = GeneratedColumn<String>(
      'composer', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, file, composer];
  @override
  String get aliasedName => _alias ?? 'scores';
  @override
  String get actualTableName => 'scores';
  @override
  VerificationContext validateIntegrity(Insertable<Score> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('file')) {
      context.handle(
          _fileMeta, file.isAcceptableOrUnknown(data['file']!, _fileMeta));
    } else if (isInserting) {
      context.missing(_fileMeta);
    }
    if (data.containsKey('composer')) {
      context.handle(_composerMeta,
          composer.isAcceptableOrUnknown(data['composer']!, _composerMeta));
    } else if (isInserting) {
      context.missing(_composerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Score map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Score(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      file: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}file'])!,
      composer: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}composer'])!,
    );
  }

  @override
  $ScoresTable createAlias(String alias) {
    return $ScoresTable(attachedDatabase, alias);
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  late final $ScoresTable scores = $ScoresTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [scores];
}
