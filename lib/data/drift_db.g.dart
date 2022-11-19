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
  final String genre;
  final String tag;
  final String label;
  final String reference;
  final double rating;
  final double difficulty;
  const Score(
      {required this.id,
      required this.name,
      required this.file,
      required this.composer,
      required this.genre,
      required this.tag,
      required this.label,
      required this.reference,
      required this.rating,
      required this.difficulty});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['file'] = Variable<String>(file);
    map['composer'] = Variable<String>(composer);
    map['genre'] = Variable<String>(genre);
    map['tag'] = Variable<String>(tag);
    map['label'] = Variable<String>(label);
    map['reference'] = Variable<String>(reference);
    map['rating'] = Variable<double>(rating);
    map['difficulty'] = Variable<double>(difficulty);
    return map;
  }

  ScoresCompanion toCompanion(bool nullToAbsent) {
    return ScoresCompanion(
      id: Value(id),
      name: Value(name),
      file: Value(file),
      composer: Value(composer),
      genre: Value(genre),
      tag: Value(tag),
      label: Value(label),
      reference: Value(reference),
      rating: Value(rating),
      difficulty: Value(difficulty),
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
      genre: serializer.fromJson<String>(json['genre']),
      tag: serializer.fromJson<String>(json['tag']),
      label: serializer.fromJson<String>(json['label']),
      reference: serializer.fromJson<String>(json['reference']),
      rating: serializer.fromJson<double>(json['rating']),
      difficulty: serializer.fromJson<double>(json['difficulty']),
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
      'genre': serializer.toJson<String>(genre),
      'tag': serializer.toJson<String>(tag),
      'label': serializer.toJson<String>(label),
      'reference': serializer.toJson<String>(reference),
      'rating': serializer.toJson<double>(rating),
      'difficulty': serializer.toJson<double>(difficulty),
    };
  }

  Score copyWith(
          {int? id,
          String? name,
          String? file,
          String? composer,
          String? genre,
          String? tag,
          String? label,
          String? reference,
          double? rating,
          double? difficulty}) =>
      Score(
        id: id ?? this.id,
        name: name ?? this.name,
        file: file ?? this.file,
        composer: composer ?? this.composer,
        genre: genre ?? this.genre,
        tag: tag ?? this.tag,
        label: label ?? this.label,
        reference: reference ?? this.reference,
        rating: rating ?? this.rating,
        difficulty: difficulty ?? this.difficulty,
      );
  @override
  String toString() {
    return (StringBuffer('Score(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('file: $file, ')
          ..write('composer: $composer, ')
          ..write('genre: $genre, ')
          ..write('tag: $tag, ')
          ..write('label: $label, ')
          ..write('reference: $reference, ')
          ..write('rating: $rating, ')
          ..write('difficulty: $difficulty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, file, composer, genre, tag, label,
      reference, rating, difficulty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Score &&
          other.id == this.id &&
          other.name == this.name &&
          other.file == this.file &&
          other.composer == this.composer &&
          other.genre == this.genre &&
          other.tag == this.tag &&
          other.label == this.label &&
          other.reference == this.reference &&
          other.rating == this.rating &&
          other.difficulty == this.difficulty);
}

class ScoresCompanion extends UpdateCompanion<Score> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> file;
  final Value<String> composer;
  final Value<String> genre;
  final Value<String> tag;
  final Value<String> label;
  final Value<String> reference;
  final Value<double> rating;
  final Value<double> difficulty;
  const ScoresCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.file = const Value.absent(),
    this.composer = const Value.absent(),
    this.genre = const Value.absent(),
    this.tag = const Value.absent(),
    this.label = const Value.absent(),
    this.reference = const Value.absent(),
    this.rating = const Value.absent(),
    this.difficulty = const Value.absent(),
  });
  ScoresCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String file,
    this.composer = const Value.absent(),
    this.genre = const Value.absent(),
    this.tag = const Value.absent(),
    this.label = const Value.absent(),
    this.reference = const Value.absent(),
    this.rating = const Value.absent(),
    this.difficulty = const Value.absent(),
  })  : name = Value(name),
        file = Value(file);
  static Insertable<Score> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? file,
    Expression<String>? composer,
    Expression<String>? genre,
    Expression<String>? tag,
    Expression<String>? label,
    Expression<String>? reference,
    Expression<double>? rating,
    Expression<double>? difficulty,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (file != null) 'file': file,
      if (composer != null) 'composer': composer,
      if (genre != null) 'genre': genre,
      if (tag != null) 'tag': tag,
      if (label != null) 'label': label,
      if (reference != null) 'reference': reference,
      if (rating != null) 'rating': rating,
      if (difficulty != null) 'difficulty': difficulty,
    });
  }

  ScoresCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? file,
      Value<String>? composer,
      Value<String>? genre,
      Value<String>? tag,
      Value<String>? label,
      Value<String>? reference,
      Value<double>? rating,
      Value<double>? difficulty}) {
    return ScoresCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      file: file ?? this.file,
      composer: composer ?? this.composer,
      genre: genre ?? this.genre,
      tag: tag ?? this.tag,
      label: label ?? this.label,
      reference: reference ?? this.reference,
      rating: rating ?? this.rating,
      difficulty: difficulty ?? this.difficulty,
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
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<double>(difficulty.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScoresCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('file: $file, ')
          ..write('composer: $composer, ')
          ..write('genre: $genre, ')
          ..write('tag: $tag, ')
          ..write('label: $label, ')
          ..write('reference: $reference, ')
          ..write('rating: $rating, ')
          ..write('difficulty: $difficulty')
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
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant("No Composer"));
  final VerificationMeta _genreMeta = const VerificationMeta('genre');
  @override
  late final GeneratedColumn<String> genre = GeneratedColumn<String>(
      'genre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant("No Genre"));
  final VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
      'tag', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant("No Tag"));
  final VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant("No Label"));
  final VerificationMeta _referenceMeta = const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
      'reference', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant("No Reference"));
  final VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
      'rating', aliasedName, false,
      check: () => rating.isBetween(Constant(0), Constant(5)),
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _difficultyMeta = const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<double> difficulty = GeneratedColumn<double>(
      'difficulty', aliasedName, false,
      check: () => difficulty.isBetween(Constant(0), Constant(3)),
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        file,
        composer,
        genre,
        tag,
        label,
        reference,
        rating,
        difficulty
      ];
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
    }
    if (data.containsKey('genre')) {
      context.handle(
          _genreMeta, genre.isAcceptableOrUnknown(data['genre']!, _genreMeta));
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
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
      genre: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}genre'])!,
      tag: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}tag'])!,
      label: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      reference: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}reference'])!,
      rating: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}rating'])!,
      difficulty: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}difficulty'])!,
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
