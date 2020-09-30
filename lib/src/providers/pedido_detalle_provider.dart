
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

class PedidosDetalle{

  List<PedidoDetalle> items = new List();

  PedidosDetalle();

  PedidosDetalle.fromJsonList(List<dynamic> jsonList) {

    if (jsonList == null) return;

    for (var item in jsonList) {
      final pedidoDetalle = new PedidoDetalle.fromJsonMap(item);
      items.add(pedidoDetalle);
      
    }

  }



}


class PedidoDetalle {
  final String pedidoID;
  final String pedidoFecha;
  final String pedidoComercioID;
  final String comercioID;
  final String comercioNombre;
  final String mercadoID;
  final String mercadoNombre;
  final String estadoID;
  final String estadoNombre;
  final List<ProdDet> productos;
  final String pedidoPrecioTotal;


  PedidoDetalle({this.pedidoID, this.pedidoFecha,this.pedidoComercioID,this.comercioID, this.comercioNombre, this.mercadoID,
          this.mercadoNombre, this.estadoID, this.estadoNombre,this.productos,this.pedidoPrecioTotal});

  factory PedidoDetalle.fromJsonMap(Map<String, dynamic> parsedJson) {

    var list = parsedJson['Producto'] != null ? parsedJson['Producto'] as List : List<ProdDet>();
    List<ProdDet> productosList;

    productosList = parsedJson['Producto'] != null ? list.map((i) => ProdDet.fromJson(i)).toList() : List<ProdDet>();


    return PedidoDetalle(
      pedidoID: parsedJson['PedidoID'],
      pedidoFecha: parsedJson['PedidoFecha'],
      pedidoComercioID: parsedJson['PedidoComercioID'],
      comercioID: parsedJson['ComercioID'],
      comercioNombre: parsedJson['ComercioNombre'],
      mercadoID: parsedJson['MercadoID'],
      mercadoNombre: parsedJson['MercadoNombre'],
      estadoID: parsedJson['EstadoID'],
      estadoNombre: parsedJson['EstadoNombre'],
      productos: productosList,
      pedidoPrecioTotal: parsedJson['PedidoPrecioTotal'],

    );
  }
}

class ProdDet {
  final String productoID;
  final String productoNombre;
  final String pedidoProductoCantidad;
  final String pedidoProductoPrecio;
  final String pedidoProductoPrecioTotal;

  ProdDet({this.productoID, this.productoNombre, this.pedidoProductoCantidad, this.pedidoProductoPrecio, this.pedidoProductoPrecioTotal});

  factory ProdDet.fromJson(Map<String, dynamic> parsedJson) {
    return ProdDet(
      productoID: parsedJson['ProductoID'],
      productoNombre: parsedJson['ProductoNombre'],
      pedidoProductoCantidad: parsedJson['PedidoProductoCantidad'],
      pedidoProductoPrecio: parsedJson['PedidoProductoPrecio'],
      pedidoProductoPrecioTotal: parsedJson['PedidoProductoPrecioTotal']
    );
  }


}


class PedidosDetalleProvider {

  Future<PedidoDetalle> fetchPedidosDetalle(pedidoComercioId,pedidoId) async { 


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


    final responseToken = await http.post(urlQA, body: bodyTokenQA, headers: headers);
    final decodedData = json.decode(responseToken.body);
    final token = new Token.fromJsonMap(decodedData);
    String token2 = token.accessToken.toString();


    Map<String, String> headers2 = {
      "Authorization": "OAuth $token2"
      };




    final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/pedidoComercio/$pedidoId,$pedidoComercioId';
    //final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultaProducto?categoriaID=$categoria&destacado=0&mercadoID=$mercado&productoNombre=$productoBuscado';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/pedidoComercio/$pedidoId,$pedidoComercioId';

    final response = await http.get('$mercadosListAPIUrlQA', headers: headers2);


    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final pedidoDetalleItems = new PedidoDetalle.fromJsonMap(decodedData);
      return pedidoDetalleItems;
      //List jsonResponse = json.decode(response.body);
      //return jsonResponse.map<dynamic>((mercado) => new Mercados.fromJsonList(mercado));
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }



}