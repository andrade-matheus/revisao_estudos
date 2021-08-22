import 'package:flutter/cupertino.dart';

class ComandosSQL {
  static String foreignKeys = 'PRAGMA foreign_keys = ON;';

  static String createTableDisciplina = '''
  CREATE TABLE disciplina
  (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT
  )''';

  static String createTableFrequencia = '''
  CREATE TABLE frequencia
  (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    valorFrequencia TEXT
  )''';

  static String createTableRevisao = '''
  CREATE TABLE revisao
  (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    idDisciplina INTEGER,
    idFrequencia INTEGER,
    nome TEXT,
    vezesRevisadas INTEGER,
    dataCadastro TEXT,
    proxRevisao TEXT,
    isArchived BIT NOT NULL,
    FOREIGN KEY (idDisciplina) REFERENCES disciplina(id) ON DELETE CASCADE,
    FOREIGN KEY (idFrequencia) REFERENCES frequencia(id) ON DELETE CASCADE
  )''';

  static String createTableLogRevisao = '''
  CREATE TABLE logRevisao
  (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    idRevisao INTEGER,
    dataRevisao TEXT,
    FOREIGN KEY (idRevisao) REFERENCES revisao(id) ON DELETE CASCADE
  )''';
}
