
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:flutter_login_ui/src/providers/pedidos_comprador_provider.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';




class PedidosVendedorProvider {

  List<PedidoComprador> _pedidoComprador = new List();


  Future<List<PedidoComprador>> fetchPedidosVendedor(comercioId) async { 


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




    final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/consultarPedido?comercioID=$comercioId';
    //final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultaProducto?categoriaID=$categoria&destacado=0&mercadoID=$mercado&productoNombre=$productoBuscado';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultarPedido?comercioID=$comercioId';

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