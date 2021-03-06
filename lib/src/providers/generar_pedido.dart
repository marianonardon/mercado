import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/carrito_db.dart';
import 'package:flutter_login_ui/src/pages/categorias_serv.dart';
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Token {
  final String accessToken;
  final String scope;
  final String refreshToken;
  final String userGuid;



  Token({this.accessToken, this.scope, this.refreshToken, this.userGuid});

  factory Token.fromJsonMap(Map<String, dynamic> parsedJson) {
    return Token(
      accessToken: parsedJson['access_token'],
      scope: parsedJson['scope'],
      refreshToken: parsedJson['refresh_token'],
      userGuid: parsedJson['user_guid'],
    );
  }
}



class Pedido {
  final String pedidoExternalID;
  final String pedidoUserID;
  final String pedidoFullName;
  final String pedidoTelefono;
  final String pedidoTokenDispositivo;
  final List<ProductosPedido> productos;


  Pedido({this.pedidoExternalID, this.pedidoUserID, this.pedidoFullName,this.pedidoTelefono, this.pedidoTokenDispositivo, this.productos});

  factory Pedido.fromJsonMap(Map<String, dynamic> parsedJson) {

    var list = parsedJson['productos'] as List;
    print(list.runtimeType);
    List<ProductosPedido> productosList = list.map((i) => ProductosPedido.toJson(i)).toList();

    return Pedido(
      pedidoExternalID: parsedJson['pedidoExternalID'],
      pedidoUserID: parsedJson['pedidoUserID'],
      pedidoFullName: parsedJson['pedidoFullName'],
      pedidoTelefono: parsedJson['pedidoTelefono'],
      pedidoTokenDispositivo: parsedJson['pedidoTokenDispositivo'],
      productos: productosList

    );
  }
}

class ProductosPedido {
  final int productoID;
  final int comercioID;
  final int mercadoID;
  final int pedidoProductoCantidad;
  final double pedidoProductoPrecio;

  ProductosPedido({this.productoID, this.comercioID,this.mercadoID, this.pedidoProductoCantidad,this.pedidoProductoPrecio});

  factory ProductosPedido.toJson(Map<String, dynamic> parsedJson) {
    return ProductosPedido(
      productoID: parsedJson['productoID'],
      comercioID: parsedJson['comercioID'],
      mercadoID: parsedJson['mercadoID'],
      pedidoProductoCantidad: parsedJson['pedidoProductoCantidad'],
      pedidoProductoPrecio: parsedJson['pedidoProductoPrecio'],
    );
  }

  Map<String, dynamic> toJson(){
  return {
    "productoID": this.productoID,
    "comercioID": this.comercioID,
    "mercadoID": this.mercadoID,
    "pedidoProductoCantidad": this.pedidoProductoCantidad,
    "pedidoProductoPrecio": this.pedidoProductoPrecio
  };
}


}

class GenerarPedido extends StatefulWidget {


  GenerarPedido(this.categoriaId,this.mercadoId,this.userId,this.nombreUser,this.fotoUser,this.categoriaNombre);
  final String categoriaId;
  final String mercadoId;
  final String userId;
  final String nombreUser;
  final String fotoUser;
  final String categoriaNombre;

  
  Future<Pedido> createProducto(List<Carrito> productos,String telefono,String nombre, String direccion, String comentarios,context) async {


    final List<Carrito> maps = productos;

    // Convierte List<Map<String, dynamic> en List<Dog>.
    List<ProductosPedido> list =  List.generate(maps.length, (i) {

      return ProductosPedido(
        productoID: maps[i].productoId,
        comercioID: maps[i].comercioId,
        mercadoID: maps[i].mercadoId,
        pedidoProductoCantidad: maps[i].cantidadProducto,
        pedidoProductoPrecio: maps[i].precioUnitario,        
      );
    });


    SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
    String externalId2 = prefs.getString('usuarioId');
    String userId2      = prefs.getString('usuarioId2');
    String nombreUser = prefs.getString('nombre');
    String pedidoTokenDispositivo = prefs.getString('tokenDispositivo');
    
    String url = "https://agilemarket.com.ar/oauth/access_token";
    String urlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/oauth/access_token';

    Map<String, String> bodyToken = {
      "client_id": "da0d4cd9919d4d80afecf1c56d954633",
      "client_secret": "be70f816716f402b8c02e53daec3e067",
      "scope": "FullControl",
      "username": "admin",
      "password": "wetiteam123",
    };

        Map<String, String> bodyTokenQA = {
      "client_id": "32936ed0b05f48859057b6a2dd5aee6f",
      "client_secret": "915b06d26cdf44f7b832c66fe6e58743",
      "scope": "FullControl",
      "username": "admin",
      "password": "admin123",
    };

    Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded"
    };


    final responseToken = await http.post(url, body: bodyToken, headers: headers);
    final decodedData = json.decode(responseToken.body);
    final token = new Token.fromJsonMap(decodedData);
    String token2 = token.accessToken.toString();
    
    
        Map<String, String> headers2 = {
          "Authorization": "OAuth $token2"
          };
    
    
      Map headers3 = <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "OAuth $token2"
        };

    final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/GenerarPedido';
    
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/GenerarPedido';

    
     http.Response response = await http.post(
        '$mercadosListAPIUrl',
    
        headers: headers3,
        body: jsonEncode(<String, dynamic>{
        "pedidoSDT": {  
          "pedidoExternalID": externalId2,
          "pedidoUserID": userId2,
          "pedidoFullName": nombreUser,
          "pedidoTelefono": telefono,
          "pedidoTokenDispositivo": pedidoTokenDispositivo,
          "pedidoNombre": nombre,
          "pedidoDireccion": direccion,
          "pedidoComentarios": comentarios,          
          "productos":list
    }}),
    ); 


    
      
      
      if (response.statusCode == 200) {
          DBProvider().deleteCarrito(1);
          Navigator.pushNamed(context, 'pedidoOk',arguments: ProductosArguments(categoriaId, mercadoId,'',userId,nombreUser,fotoUser,categoriaNombre,''));
                    //String comercio = producto.comercioID;
                    //Navigator.pushNamed(context, 'altaProdOk' ,arguments: PuestoArguments(user,nombreUser,foto,mercado,comercio,numNave,comercioPuesto,comercioCuit,comercioTelefono,comercioMail,comercioNombre,));
              
                  //return Puesto.fromJson(json.decode(response.body));
                } else {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, 'errorRegProd');
                }
              }
              
                @override
                State<StatefulWidget> createState() {
                  throw UnimplementedError();
                }
              



}
