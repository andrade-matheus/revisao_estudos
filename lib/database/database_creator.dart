import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class DatabaseCreator {
  static const disciplinaTable = 'disciplina';
  static const frequenciaTable = 'frequencia';
  static const revisaoTable = 'revisao';
  static const id = 'id';
  static const nome = 'nome';
  static const frequencia = 'frequencia';
  static const disciplina = 'disciplina';
  static const vezesRevisadas = 'vezesRevisadas';
  static const dataCadastro = 'dataCadastro';
  static const proxRevisao = 'proxRevisao';
  static const isArchived = 'isArchived';

  Future<void> createDisciplinaTable(Database db) async {
    final disciplinaSql = '''CREATE TABLE $disciplinaTable
    (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $nome TEXT,
      $isArchived BIT NOT NULL
    )''';

    await db.execute(disciplinaSql);
  }

  Future<void> createFrequenciaTable(Database db) async {
    final frequenciaSql = '''CREATE TABLE $frequenciaTable
    (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $frequencia TEXT,
      $isArchived BIT NOT NULL
    )''';

    await db.execute(frequenciaSql);
  }

  Future<void> createRevisaoTable(Database db) async {
    final revisaoSql = '''CREATE TABLE $revisaoTable
    (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $disciplina TEXT,
      $frequencia TEXT,
      $nome TEXT,
      $vezesRevisadas INTEGER,
      $dataCadastro TEXT,
      $proxRevisao TEXT,
      $isArchived BIT NOT NULL
    )''';

    await db.execute(revisaoSql);
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    //make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      //await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('revisoes_disciplinas');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async {
    await createDisciplinaTable(db);
    await createFrequenciaTable(db);
    await createRevisaoTable(db);
  }
}