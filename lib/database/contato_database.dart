import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/contato.dart';

class ContatoDatabase {
  static final ContatoDatabase _instance = ContatoDatabase._internal();
  factory ContatoDatabase() => _instance;

  static Database? _database;

  ContatoDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'contatos.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contatos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        telefone TEXT,
        email TEXT
      )
    ''');
  }

  Future<int> adicionarContato(Contato contato) async {
    final db = await database;
    return await db.insert('contatos', contato.toMap());
  }

  Future<int> editarContato(Contato contato) async {
    final db = await database;
    return await db.update(
      'contatos',
      contato.toMap(),
      where: 'id = ?',
      whereArgs: [contato.id],
    );
  }

  Future<int> removerContato(int id) async {
    final db = await database;
    return await db.delete(
      'contatos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Contato>> getContatos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contatos');

    return List.generate(maps.length, (i) {
      return Contato(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        telefone: maps[i]['telefone'],
        email: maps[i]['email'],
      );
    });
  }
}
