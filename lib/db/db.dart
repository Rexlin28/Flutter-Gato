import 'package:gato/db/resultado.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart';


class DB{
  static Future<sqlite.Database> db() async{
    String ruta = await sqlite.getDatabasesPath();
    return sqlite.openDatabase(join(ruta,"resultado.db"),
      version: 1, singleInstance: true, onCreate: (sqlite.Database db, int version) async{
        await create(db);
        }
    );
  }

  static Future<void> create(sqlite.Database db) async{
    const String sql = """
    CREATE TABLE scores(
    id integer primary key autoincrement not null,
    cruz int,
    circulo int,
    empate int,
    fecha timestamp not null default CURRENT_TIMESTAMP
    )
    """;
    await db.execute(sql);
  }


  static Future<List<Resultado>> consulta() async {

    final sqlite.Database db = await DB.db();

    final List<Map<String, dynamic>> query = await db.query("scores");

    List<Resultado> ? resultado = query.map((e){
      return Resultado.frontMap(e);
    }).toList();

    return resultado;
  }

   Future<int> insertar(Resultado resultado) async {
    int value = 0;
    final sqlite.Database db = await DB.db();
    value = await db.insert("scores", resultado.mapeador(), conflictAlgorithm: sqlite.ConflictAlgorithm.replace);



    return value;
  }
}

