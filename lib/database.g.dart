// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  StudentDao? _studentDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `students` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `rollno` TEXT NOT NULL, `course` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  StudentDao get studentDao {
    return _studentDaoInstance ??= _$StudentDao(database, changeListener);
  }
}

class _$StudentDao extends StudentDao {
  _$StudentDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _studentInsertionAdapter = InsertionAdapter(
            database,
            'students',
            (Student item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'rollno': item.rollno,
                  'course': item.course
                }),
        _studentUpdateAdapter = UpdateAdapter(
            database,
            'students',
            ['id'],
            (Student item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'rollno': item.rollno,
                  'course': item.course
                }),
        _studentDeletionAdapter = DeletionAdapter(
            database,
            'students',
            ['id'],
            (Student item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'rollno': item.rollno,
                  'course': item.course
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Student> _studentInsertionAdapter;

  final UpdateAdapter<Student> _studentUpdateAdapter;

  final DeletionAdapter<Student> _studentDeletionAdapter;

  @override
  Future<List<Student>> findAllStudents() async {
    return _queryAdapter.queryList('SELECT * FROM students',
        mapper: (Map<String, Object?> row) => Student(
            id: row['id'] as int?,
            name: row['name'] as String,
            rollno: row['rollno'] as String,
            course: row['course'] as String));
  }

  @override
  Future<Student?> findStudentById(int id) async {
    return _queryAdapter.query('SELECT * FROM students WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Student(
            id: row['id'] as int?,
            name: row['name'] as String,
            rollno: row['rollno'] as String,
            course: row['course'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertStudent(Student student) async {
    await _studentInsertionAdapter.insert(student, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateStudent(Student student) async {
    await _studentUpdateAdapter.update(student, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteStudent(Student student) async {
    await _studentDeletionAdapter.delete(student);
  }
}
