import 'dart:io';

import 'package:path/path.dart';
import 'package:revisao_estudos/controllers/database_controller.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class DatabaseCreator {
  String disciplinaTable = DatabaseController.disciplinaTable;
  String frequenciaTable = DatabaseController.frequenciaTable;
  String revisaoTable = DatabaseController.revisaoTable;
  String logRevisaoTable = DatabaseController.logRevisaoTable;

  String id = DatabaseController.id;
  String idDisciplina = DatabaseController.idDisciplina;
  String idFrequencia = DatabaseController.idFrequencia;
  String idRevisao = DatabaseController.idRevisao;

  String nome = DatabaseController.nome;
  String valorFrequencia = DatabaseController.valorFrequencia;
  String vezesRevisadas = DatabaseController.vezesRevisadas;
  String dataCadastro = DatabaseController.dataCadastro;
  String proxRevisao = DatabaseController.proxRevisao;
  String isArchived = DatabaseController.isArchived;
  String dataRevisao = DatabaseController.dataRevisao;

  Future<void> createDisciplinaTable(Database db) async {
    final disciplinaSql = '''CREATE TABLE $disciplinaTable
    (
      $id INTEGER PRIMARY KEY,
      $nome TEXT
    )''';

    await db.execute(disciplinaSql);
  }

  Future<void> createFrequenciaTable(Database db) async {
    final frequenciaSql = '''CREATE TABLE $frequenciaTable
    (
      $id INTEGER PRIMARY KEY,
      $valorFrequencia TEXT
    )''';

    await db.execute(frequenciaSql);
  }

  Future<void> createRevisaoTable(Database db) async {
    final revisaoSql = '''CREATE TABLE $revisaoTable
    (
      $id INTEGER PRIMARY KEY,
      $idDisciplina INTEGER,
      $idFrequencia INTEGER,
      $nome TEXT,
      $vezesRevisadas INTEGER,
      $dataCadastro TEXT,
      $proxRevisao TEXT,
      $isArchived BIT NOT NULL,
      FOREIGN KEY ($idDisciplina) REFERENCES $disciplinaTable($id) ON DELETE CASCADE,
      FOREIGN KEY ($idFrequencia) REFERENCES $frequenciaTable($id) ON DELETE CASCADE
    )''';

    await db.execute(revisaoSql);
  }

  Future<void> createLogRevisaoTable(Database db) async {
    final logRevisaoSql = '''CREATE TABLE $logRevisaoTable
    (
      $id INTEGER PRIMARY KEY,
      $idRevisao INTEGER,
      $dataRevisao TEXT,
      FOREIGN KEY ($idRevisao) REFERENCES $revisaoTable($id) ON DELETE CASCADE
    )''';

    await db.execute(logRevisaoSql);
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

  _onConfigure(Database db) async {
    // Ativa as foreign_keys, dando suporte a DELETE ON CASCADE
    await db.execute("PRAGMA foreign_keys = ON");
  }


  Future<void> initDatabase() async {
    final path = await getDatabasePath('revisoes_disciplinas');
    db = await openDatabase(path, version: 1, onCreate: onCreate, onConfigure: _onConfigure);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async {
    await createDisciplinaTable(db);
    await createFrequenciaTable(db);
    await createRevisaoTable(db);
    await createLogRevisaoTable(db);
  }
}