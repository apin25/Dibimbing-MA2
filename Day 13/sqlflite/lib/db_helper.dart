import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlflite/model/note.dart'; // Asumsi path ini benar

class DbHelper {
  static const String _databaseName = "notes.db";
  static const String _tableName = "notes";
  static final int _databaseVersion = 1;

  DbHelper._privateConstructor();
  static final DbHelper instace = DbHelper._privateConstructor();

  Future<Database> _initialDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: _databaseVersion,
      onCreate: (db, version) async{
        createTable(db);
      }
    );
  }
  
  static Database? _database;
  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _initialDatabase();
    return _database!;
  }
  
  Future createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $_tableName(
      note_id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      content TEXT NOT NULL,         -- Diperbaiki: Ditambahkan tipe data TEXT
      created_at DATE NOT NULL,      -- Diperbaiki: Ditambahkan koma (,)
      updated_at DATE NULL,          -- Diperbaiki: Menggunakan NULL, bukan NULLABLE
      pinned INTEGER NOT NULL DEFAULT 0
      )
      ''');
  }
  
  // ✅ Perbaikan 1: Melengkapi conflictAlgorithm
  Future<int> insertNotes(Note note) async{
    final db = await database;

    final data = note.toJson(); 

    final id = await db.insert(
      _tableName, 
      data, 
      conflictAlgorithm: ConflictAlgorithm.replace 
    );
    return id;
  }

  Future<List<Note>> fetchNotes() async {
    final db = await database;
    
    final maps = await db.query(
      _tableName, 
      orderBy: "pinned DESC, created_at DESC" 
    ); 

    if(maps.isEmpty) return [];

    return List.generate(maps.length,(i){
      return Note.fromJson(maps[i]);
    });
  }
}