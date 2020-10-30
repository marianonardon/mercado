
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';


class ProductosProvider {

  List<Producto> _productos = new List();
  List<Producto> _productosSinPrecio = new List();
  bool _cargando     = false;
  int _page = 0;

  
  
  final _productosStreamController = StreamController<List<Producto>>.broadcast();

  Function(List<Producto>) get productosSink => _productosStreamController.sink.add; 

  Stream<List<Producto>> get productosStream => _productosStreamController.stream;


  void disposeStreams() {
    _productosStreamController?.close();
  }

  Future<List<Producto>> fetchProductos(categoriaId,mercadoId,productoBuscado,puestosId) async { 
    String filtroPuesto;
    if (puestosId == ''){
      filtroPuesto = '';
    } else{
      filtroPuesto = '&comercioID=$puestosId';
    }

    if (_cargando) return [];

    _cargando = true;

    print('cargando siguientes');

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

    _page++;

    if(categoriaId != ''){
    int categoria = int.parse(categoriaId);
    }
    int mercado   = int.parse(mercadoId); 
    final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/consultaProducto?pageNumber=$_page&pageSize=6&categoriaID=$categoriaId&destacado=0&mercadoID=$mercado&productoNombre=$productoBuscado';
    //final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultaProducto?categoriaID=$categoria&destacado=0&mercadoID=$mercado&productoNombre=$productoBuscado';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultaProducto?pageNumber=$_page&pageSize=6&categoriaID=$categoriaId&destacado=0&mercadoID=$mercado&productoNombre=$productoBuscado';

    final response = await http.get('$mercadosListAPIUrl$filtroPuesto', headers: headers2);

    print('servicio');
    _cargando = false;

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final productos = new Productos.fromJsonList(decodedData);
      final productosLista = productos.items;
      final productosSprec = productosLista.where((element) => element.precios.isEmpty == true).toList();
      productosLista.removeWhere((element) => element.precios.isEmpty == true);

      _productos.addAll(productosLista);
      _productosSinPrecio.addAll(productosSprec);
      if(productosLista.isEmpty == true){
        _productos.addAll(_productosSinPrecio);
        _productosSinPrecio.clear();
      }
      productosSink(_productos);
      return productos.items;
      //List jsonResponse = json.decode(response.body);
      //return jsonResponse.map<dynamic>((mercado) => new Mercados.fromJsonList(mercado));
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }



}