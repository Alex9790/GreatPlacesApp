import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {

  //metodo para conectar a BD y retornar la instancia
  static Future<Database> database() async{
    //path de la base de datos a crear
    final dbPath = await sql.getDatabasesPath();
    //si esta BD ya exite, la abre sino la crea nueva
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    
    //no se tiene alcance a los metodos static dentro de la misma case, asi que se debe referenciar la clase y el metodo
    //no se puede usar solo "database()"
    Database sqlDB = await DBHelper.database();

    //para insertar los datos que vienen por parametro
    await sqlDB.insert(
      table,
      data,
      //en caso de insertar para el mismo Id se reemplazan los valores
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  //retorna toda la tabla
  static Future<List<Map<String, dynamic>>> getData(String table) async{

    //conectando a BD
    Database db = await DBHelper.database();
    return db.query(table);
  }
  
}
