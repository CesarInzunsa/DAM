import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Conexion {
  static Future<void> script(Database db) async {
    await _createMateriaTable(db);
    await _createProfesorTable(db);
    await _createHorarioTable(db);
    await _createAsistenciaTable(db);
  }

  static Future<Database> openDB() {
    return openDatabase(join(getDatabasesPath().toString(), 'practica01.db'),
        onCreate: (db, version) {
      return script(db);
    }, version: 1);
  }

  // This function creates the 'materia' table
  static Future<void> _createMateriaTable(Database db) async {
    await db.execute('CREATE TABLE materia ('
        'idMateria INTEGER PRIMARY KEY AUTOINCREMENT, '
        'nombreMateria TEXT)');
  }

  // This function creates the 'profesor' table
  static Future<void> _createProfesorTable(Database db) async {
    await db.execute('CREATE TABLE profesor ('
        'idProfesor INTEGER PRIMARY KEY AUTOINCREMENT, '
        'nombreProfesor TEXT, '
        'carreraProfesor TEXT)');
  }

  // This function creates the 'horario' table
  static Future<void> _createHorarioTable(Database db) async {
    await db.execute('CREATE TABLE horario ('
        'idHorario INTEGER PRIMARY KEY AUTOINCREMENT, '
        'idProfesor INT NOT NULL, '
        'idMateria INT NOT NULL, '
        'horaHorario TEXT, '
        'edificioHorario TEXT, '
        'salonHorario TEXT, '
        'FOREIGN KEY (idProfesor) REFERENCES profesor(idProfesor), '
        'FOREIGN KEY (idMateria) REFERENCES materia(idMateria))');
  }

  // This function creates the 'asistencia' table
  static Future<void> _createAsistenciaTable(Database db) async {
    await db.execute('CREATE TABLE asistencia ('
        'idAsistencia INTEGER PRIMARY KEY AUTOINCREMENT, '
        'idHorario INT NOT NULL, '
        'fechaAsistencia TEXT, '
        'asistencia INT, '
        'FOREIGN KEY (idHorario) REFERENCES horario(idHorario))');
  }
}
