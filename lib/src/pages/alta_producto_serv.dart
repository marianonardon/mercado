import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
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



class Producto {
  final String productoID;
  final String productoNombre;
  final String productoDescripcion;
  final String productoStock;
  final double productoCalidad;
  final String productoFoto;
  final String categoriaID;
  final String categoriaNombre;
  final String tipoUnidadID;
  final String tipoUnidadNombre;
  final String comercioID;
  final String comercioNombre;
  final String mercadoID;
  final String mercadoNombre;
  final bool   productoDestacado;
  final List<Precio> precios;


  Producto({this.productoID, this.productoNombre, this.productoDescripcion, this.productoStock,
          this.productoCalidad, this.productoFoto,this.categoriaID, this.categoriaNombre, this.tipoUnidadID,
          this.tipoUnidadNombre, this.comercioID, this.comercioNombre, this.mercadoID,
          this.mercadoNombre, this.productoDestacado, this.precios});

  factory Producto.fromJsonMap(Map<String, dynamic> parsedJson) {

    var list = parsedJson['Precio'] as List;
    print(list.runtimeType);
    List<Precio> preciosList = list.map((i) => Precio.fromJson(i)).toList();

    return Producto(
      productoID: parsedJson['ProductoID'],
      productoNombre: parsedJson['ProductoNombre'],
      productoDescripcion: parsedJson['ProductoDescripcion'],
      productoStock: parsedJson['ProductoStock'],
      productoCalidad: parsedJson['ProductoCalidad'].toDouble(),
      productoFoto: parsedJson['ProductoFoto'],
      categoriaID: parsedJson['CategoriaID'],
      categoriaNombre: parsedJson['CategoriaNombre'],
      tipoUnidadID: parsedJson['TipoUnidadID'],
      tipoUnidadNombre: parsedJson['TipoUnidadNombre'],
      comercioID: parsedJson['ComercioID'],
      comercioNombre: parsedJson['ComercioNombre'],
      mercadoID: parsedJson['MercadoID'],
      mercadoNombre: parsedJson['MercadoNombre'],
      productoDestacado: parsedJson['ProductoDestacado'],
      precios: preciosList

    );
  }
}

class Precio {
  final String precioCantidad;
  final String precioProducto;

  Precio({this.precioCantidad, this.precioProducto});

  factory Precio.fromJson(Map<String, dynamic> parsedJson) {
    return Precio(
      precioCantidad: parsedJson['PrecioCantidad'],
      precioProducto: parsedJson['PrecioProducto']
    );
  }


}

class ProductoCrear extends StatefulWidget {
  Widget producto(String nombre, descripcion, categoria, stock, int calidad,String urlFoto, tipoUnidadId, comercioId,precio1, cantidad1,
                  precio2,cantidad2,precio3,cantidad3,mercado,foto,nombreUser,user,numNave,comercioPuesto,comercioCuit,comercioTelefono,comercioMail,comercioNombre,bool productoDestacado,comercioFoto,BuildContext context ) {
    
    return FutureBuilder<Producto>(
      future: createProducto( nombre, descripcion, categoria, stock, calidad, urlFoto, tipoUnidadId, comercioId,precio1,cantidad1,
                  precio2,cantidad2,precio3,cantidad3,mercado,foto,nombreUser,user,numNave,comercioPuesto,comercioCuit,comercioTelefono,comercioMail,comercioNombre, productoDestacado,comercioFoto,context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.comercioNombre);
        } else if (snapshot.hasError) {
          Navigator.pushNamed(context, 'errorRegPues');
          return Text("${snapshot.error}");
        }

        return Center(child: Container(child: CircularProgressIndicator()));
      },
    );
  }

Future<Producto> createProducto(String nombre, descripcion, categoria, stock, int calidad,String urlFoto, tipoUnidadId, comercioId,precio1, cantidad1,
                  precio2,cantidad2,precio3,cantidad3,mercado,foto,nombreUser,user,numNave,comercioPuesto,comercioCuit,comercioTelefono,comercioMail,comercioNombre,bool productoDestacado,String comercioFoto,BuildContext context) async {
    
    
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

    final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/producto/0';
    
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/producto/0';
    http.Response response;

    if(precio3 != '') {

    
     response = await http.post(
        '$mercadosListAPIUrl',
    
        headers: headers3,
        body: jsonEncode(<String, dynamic>{
        "ProductoNombre": nombre,
        "ProductoDescripcion": descripcion,
        "ProductoStock": stock,
        "ProductoCalidad": calidad,
        "ProductoFoto": urlFoto,
        "CategoriaID": categoria,
        "TipoUnidadID": tipoUnidadId,
        "ComercioID": comercioId,
        "MercadoID": mercado,
        "ProductoDestacado": productoDestacado,
        "Precio": [
            {
                "PrecioCantidad": cantidad1,
                "ProductoPrecio": precio1
            },
            {
                "PrecioCantidad": cantidad2,
                "ProductoPrecio": precio2,
            },
            {
                "PrecioCantidad": cantidad3,
                "ProductoPrecio": precio3
            }
        ]
    }),
      );
      }

    if (precio1 == ''){
         response = await http.post(
        '$mercadosListAPIUrl',
    
        headers: headers3,
        body: jsonEncode(<String, dynamic>{
        "ProductoNombre": nombre,
        "ProductoDescripcion": descripcion,
        "ProductoStock": stock,
        "ProductoCalidad": calidad,
        "ProductoFoto": urlFoto,
        "CategoriaID": categoria,
        "TipoUnidadID": tipoUnidadId,
        "ComercioID": comercioId,
        "MercadoID": mercado,
        "ProductoDestacado": productoDestacado,
    }),
    );
      
    } else {
    
    if (precio2 == ''){
         response = await http.post(
        '$mercadosListAPIUrl',
    
        headers: headers3,
        body: jsonEncode(<String, dynamic>{
        "ProductoNombre": nombre,
        "ProductoDescripcion": descripcion,
        "ProductoStock": stock,
        "ProductoCalidad": calidad,
        "ProductoFoto": urlFoto,
        "CategoriaID": categoria,
        "TipoUnidadID": tipoUnidadId,
        "ComercioID": comercioId,
        "MercadoID": mercado,
        "ProductoDestacado": productoDestacado,
        "Precio": [
            {
                "PrecioCantidad": cantidad1,
                "ProductoPrecio": precio1
            }
        ]
    }),
    );
      
    } else {
      if (precio3 == ''){
        response = await http.post(
        '$mercadosListAPIUrl',
    
        headers: headers3,
        body: jsonEncode(<String, dynamic>{
        "ProductoNombre": nombre,
        "ProductoDescripcion": descripcion,
        "ProductoStock": stock,
        "ProductoCalidad": calidad,
        "ProductoFoto": urlFoto,
        "CategoriaID": categoria,
        "TipoUnidadID": tipoUnidadId,
        "ComercioID": comercioId,
        "MercadoID": mercado,
        "ProductoDestacado": productoDestacado,
        "Precio": [
            {
                "PrecioCantidad": cantidad1,
                "ProductoPrecio": precio1
            },
            {
                "PrecioCantidad": cantidad2,
                "ProductoPrecio": precio2,
            },
        ]
    }),
    ); 
    } 
    }
    }
    


    
      
      
      if (response.statusCode == 201) {
          Navigator.of(context).pop();
          final decodedData2 = json.decode(response.body);
          final producto =  Producto.fromJsonMap(decodedData2);
          String comercio = producto.comercioID;
          Navigator.pushNamed(context, 'altaProdOk' ,arguments: PuestoArguments(user,nombreUser,foto,mercado,comercio,numNave,comercioPuesto,comercioCuit,comercioTelefono,comercioMail,comercioNombre,comercioFoto));
    
        //return Puesto.fromJson(json.decode(response.body));
      } else {
            Navigator.of(context).pop();
            Navigator.pushNamed(context, 'errorRegProd', arguments: PuestoArguments(user,nombreUser,foto,mercado,comercioId,numNave,comercioPuesto,comercioCuit,comercioTelefono,comercioMail,comercioNombre,comercioFoto));
      }
    }
    
      @override
      State<StatefulWidget> createState() {
        throw UnimplementedError();
      }
    
      void setState(Null Function() param0) {}



}

class ScreenArguments {
  final String userId;
  final String nombre;
  final String foto;
  final String mercadoId;
  final String comercioId;


  ScreenArguments(this.userId, this.nombre,this.foto,this.mercadoId,this.comercioId);
}