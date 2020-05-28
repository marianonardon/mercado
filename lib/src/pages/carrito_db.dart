import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider {


    Future<List<Carrito>> insertCarrito(Carrito carrito) async {

          final database = openDatabase(
      // Establecer la ruta a la base de datos. Nota: Usando la función `join` del
      // complemento `path` es la mejor práctica para asegurar que la ruta sea correctamente
      // construida para cada plataforma.
      join(await getDatabasesPath, 'carrito3_database.db'),
      // Cuando la base de datos se crea por primera vez, crea una tabla para almacenar dogs
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE carritos(id INTEGER PRIMARY KEY AUTOINCREMENT, nombreProducto TEXT, fotoProducto TEXT, comercioProducto TEXT, cantidadProducto INTEGER, unidadProducto TEXT, precioProducto TEXT)",
        );
      },
      // Establece la versión. Esto ejecuta la función onCreate y proporciona una
      // ruta para realizar actualizacones y defradaciones en la base de datos.
      version: 1,
    );

    // Obtiene una referencia de la base de datos
    final Database db = await database;

    // Inserta el Dog en la tabla correcta. También puede especificar el
    // `conflictAlgorithm` para usar en caso de que el mismo Dog se inserte dos veces.
    // En este caso, reemplaza cualquier dato anterior.
    await db.insert(
      'carritos',
      carrito.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
    Future<List<Carrito>> getCarritos() async {

      final database = openDatabase(
      // Establecer la ruta a la base de datos. Nota: Usando la función `join` del
      // complemento `path` es la mejor práctica para asegurar que la ruta sea correctamente
      // construida para cada plataforma.
      join(await getDatabasesPath, 'carrito3_database.db'),
      // Cuando la base de datos se crea por primera vez, crea una tabla para almacenar dogs
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE carritos(id INTEGER PRIMARY KEY AUTOINCREMENT, nombreProducto TEXT, fotoProducto TEXT, comercioProducto TEXT, cantidadProducto INTEGER, unidadProducto TEXT, precioProducto INTEGER)",
        );
      },
      // Establece la versión. Esto ejecuta la función onCreate y proporciona una
      // ruta para realizar actualizacones y defradaciones en la base de datos.
      version: 1,
    );
    
    // Obtiene una referencia de la base de datos
    final Database db = await database;

    // Consulta la tabla por todos los Dogs.
    final List<Map<String, dynamic>> maps = await db.query('carritos');

    // Convierte List<Map<String, dynamic> en List<Dog>.
    return List.generate(maps.length, (i) {
      return Carrito(
        id: maps[i]['id'],
        nombreProducto: maps[i]['nombreProducto'],
        fotoProducto: maps[i]['fotoProducto'],
        comercioProducto: maps[i]['comercioProducto'],
        cantidadProducto: maps[i]['cantidadProducto'],
        unidadProducto: maps[i]['unidadProducto'],
        precioProducto: maps[i]['precioProducto']
      );
    });
  }

      Future<void> updateCarrito(Carrito carrito) async {

            final database = openDatabase(
      // Establecer la ruta a la base de datos. Nota: Usando la función `join` del
      // complemento `path` es la mejor práctica para asegurar que la ruta sea correctamente
      // construida para cada plataforma.
      join(await getDatabasesPath, 'carrito_database.db'),
      // Cuando la base de datos se crea por primera vez, crea una tabla para almacenar dogs
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE carritos(id INTEGER PRIMARY KEY, nombreProducto TEXT, fotoProducto TEXT, comercioProducto TEXT, cantidadProducto INTEGER, unidadProducto TEXT, precioProducto INTEGER)",
        );
      },
      // Establece la versión. Esto ejecuta la función onCreate y proporciona una
      // ruta para realizar actualizacones y defradaciones en la base de datos.
      version: 1,
    );
    // Obtiene una referencia de la base de datos
    final db = await database;

    // Actualiza el Dog dado
    await db.update(
      'carritos',
      carrito.toMap(),
      // Aseguúrate de que solo actualizarás el Dog con el id coincidente
       where: "id = ?",
      // Pasa el id Dog a través de whereArg para prevenir SQL injection
      whereArgs: [carrito.id],
    );
  }

  Future<void> deleteCarrito(int id) async {


        final database = openDatabase(
      // Establecer la ruta a la base de datos. Nota: Usando la función `join` del
      // complemento `path` es la mejor práctica para asegurar que la ruta sea correctamente
      // construida para cada plataforma.
      join(await getDatabasesPath, 'carrito_database.db'),
      // Cuando la base de datos se crea por primera vez, crea una tabla para almacenar dogs
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE carritos(id INTEGER PRIMARY KEY, nombreProducto TEXT, fotoProducto TEXT, comercioProducto TEXT, cantidadProducto INTEGER, unidadProducto TEXT, precioProducto INTEGER)",
        );
      },
      // Establece la versión. Esto ejecuta la función onCreate y proporciona una
      // ruta para realizar actualizacones y defradaciones en la base de datos.
      version: 1,
    );
    // Obtiene una referencia de la base de datos
    final db = await database;

    // Elimina el Dog de la base de datos
    await db.delete(
      'carritos',
      // Utiliza la cláusula `where` para eliminar un dog específico
       where: "id = ?",
      // Pasa el id Dog a través de whereArg para prevenir SQL injection
      whereArgs: [id],
    );
  }

}







    var producto = Carrito(
    id: 0,
    nombreProducto: 'Manzanas',
    fotoProducto: 'foto',
    comercioProducto: 'berbo',
    cantidadProducto: 12,
    unidadProducto: 'kg',
    precioProducto: 120.toString()
  );

  // Inserta un dog en la base de datos
 // await insertCarrito(producto);

  // Imprime la lista de dogs (solamente Fido por ahora)
/*   print(await getCarritos());

  // Actualiza la edad de Fido y lo guarda en la base de datos
    producto = Carrito(
    id: producto.id,
    nombreProducto: 'peras',
    fotoProducto: 'foto',
    comercioProducto: 'berbo',
    cantidadProducto: 12,
    unidadProducto: 'kg',
    precioProducto: 120
  );
  await updateCarrito(producto);

  // Imprime la información de Fido actualizada
  print(await getCarritos());

  // Elimina a Fido de la base de datos
  await deleteCarrito(producto.id);

  // Imprime la lista de dos (vacía)
  print(await getCarritos());
} */


class Carrito {
  final int    id;
  final String nombreProducto;
  final String fotoProducto;
  final String comercioProducto;
  int cantidadProducto;
  final String unidadProducto;
  final String precioProducto;
  Carrito({this.id, this.nombreProducto, this.fotoProducto, this.comercioProducto,this.cantidadProducto, this.unidadProducto, this.precioProducto});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombreProducto': nombreProducto,
      'fotoProducto': fotoProducto,
      'comercioProducto': comercioProducto,
      'cantidadProducto': cantidadProducto,
      'unidadProducto': unidadProducto,
      'precioProducto': precioProducto,
    };
  }

   @override
  String toString() {
    return 'Carrito{id: $id, nombreProducto: $nombreProducto, fotoProducto: $fotoProducto, comercioProducto: $comercioProducto, cantidadProducto: $cantidadProducto, unidadProducto: $unidadProducto, precioProducto: $precioProducto}';
  }

}
