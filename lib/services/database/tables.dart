class Tables {
  static String createTableDisciplina = '''
  CREATE TABLE disciplina
  (
    id INTEGER PRIMARY KEY,
    nome TEXT
  )''';

  static String createTableFrequencia = '''
  CREATE TABLE frequencia
  (
    id INTEGER PRIMARY KEY,
    valorFrequencia TEXT
  )''';

  static String createTableRevisao = '''
  CREATE TABLE revisao
  (
    id INTEGER PRIMARY KEY,
    idDisciplina INTEGER,
    idFrequencia INTEGER,
    nome TEXT,
    vezesRevisadas INTEGER,
    dataCadastro TEXT,
    proxRevisao TEXT,
    isArchived BIT NOT NULL,
    FOREIGN KEY (idDisciplina) REFERENCES disciplinaTable(id) ON DELETE CASCADE,
    FOREIGN KEY (idFrequencia) REFERENCES frequenciaTable(id) ON DELETE CASCADE
  )''';

  static String createTableLogRevisao = '''
  CREATE TABLE logRevisao
  (
    id INTEGER PRIMARY KEY,
    idRevisao INTEGER,
    dataRevisao TEXT,
    FOREIGN KEY (idRevisao) REFERENCES revisaoTable(id) ON DELETE CASCADE
  )''';
}
