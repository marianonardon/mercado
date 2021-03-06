
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class PedidosComprador{

  List<PedidoComprador> items = new List();

  PedidosComprador();

  PedidosComprador.fromJsonList(List<dynamic> jsonList) {

    if (jsonList == null) return;

    for (var item in jsonList) {
      final pedidosComprador = new PedidoComprador.fromJsonMap(item);
      items.add(pedidosComprador);
      
    }

  }



}


class PedidoComprador {
  final String pedidoID;
  final String pedidoFecha;
  final String pedidoExternalID;
  final String pedidoUserID;
  final String pedidoFullName;
  final String pedidoTokenDispositivo;
  final String pedidoTelefono;
  final String pedidoComercioID;
  final String comercioID;
  final String comercioNombre;
  final String comercioTelefono;
  final String comercioTokenDispositivo;
  final String mercadoID;
  final String mercadoNombre;
  final String estadoID;
  final String estadoNombre;
  final String pedidoNombre;
  final String pedidoDireccion;
  final String pedidoComentarios;
  final String pedidoPrecioTotal;


  PedidoComprador({this.pedidoID, this.pedidoFecha, this.pedidoExternalID, this.pedidoUserID,
          this.pedidoFullName, this.pedidoTokenDispositivo, this.pedidoTelefono, this.pedidoComercioID,this.comercioID, this.comercioNombre, this.comercioTelefono, this.comercioTokenDispositivo,this.mercadoID,
          this.mercadoNombre, this.estadoID, this.estadoNombre,this.pedidoNombre,this.pedidoDireccion,this.pedidoComentarios,this.pedidoPrecioTotal});

  factory PedidoComprador.fromJsonMap(Map<String, dynamic> parsedJson) {


    return PedidoComprador(
      pedidoID: parsedJson['pedidoID'],
      pedidoFecha: parsedJson['pedidoFecha'],
      pedidoExternalID: parsedJson['PedidoExternalID'],
      pedidoUserID: parsedJson['pedidoUserID'],
      pedidoFullName: parsedJson['pedidoFullName'],
      pedidoTokenDispositivo: parsedJson['pedidoTokenDispositivo'],
      pedidoTelefono: parsedJson['pedidoTelefono'],
      pedidoComercioID: parsedJson['pedidoComercioID'],
      comercioNombre: parsedJson['comercioNombre'],
      comercioTelefono: parsedJson['comercioTelefono'],
      comercioTokenDispositivo: parsedJson['comercioTokenDispositivo'],
      mercadoID: parsedJson['mercadoID'],
      mercadoNombre: parsedJson['mercadoNombre'],
      estadoID: parsedJson['estadoID'],
      estadoNombre: parsedJson['estadoNombre'],
      pedidoNombre: parsedJson['pedidoNombre'],
      pedidoDireccion: parsedJson['pedidoDireccion'],
      pedidoComentarios: parsedJson['pedidoComentarios'],
      pedidoPrecioTotal: parsedJson['pedidoPrecioTotal'],

    );
  }
}


class PedidosCompradorProvider {

  List<PedidoComprador> _pedidoComprador = new List();


  Future<List<PedidoComprador>> fetchPedidosComprador() async { 

    SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
    String externalId2 = prefs.getString('usuarioId');
    String userId2      = prefs.getString('usuarioId2');
    String nombreUser = prefs.getString('nombre');

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




    final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/consultarPedido?PedidoExternalID=$externalId2&pedidoUserID=$userId2';
    //final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultaProducto?categoriaID=$categoria&destacado=0&mercadoID=$mercado&productoNombre=$productoBuscado';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultarPedido?PedidoExternalID=$externalId2&pedidoUserID=$userId2';

    final response = await http.get('$mercadosListAPIUrl', headers: headers2);


    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final pedidoComprador = new PedidosComprador.fromJsonList(decodedData);
      return pedidoComprador.items;
      //List jsonResponse = json.decode(response.body);
      //return jsonResponse.map<dynamic>((mercado) => new Mercados.fromJsonList(mercado));
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }



}