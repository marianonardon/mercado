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



class PedidoDetalleEstado {
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
  final String gx_md5_hash;


  PedidoDetalleEstado({this.pedidoID, this.pedidoFecha,this.pedidoComercioID,this.comercioID, this.comercioNombre, this.mercadoID,
          this.mercadoNombre, this.estadoID, this.estadoNombre,this.productos,this.pedidoPrecioTotal,this.gx_md5_hash});

  factory PedidoDetalleEstado.fromJsonMap(Map<String, dynamic> parsedJson) {

    var list = parsedJson['Producto'] != null ? parsedJson['Producto'] as List : List<ProdDet>();
    List<ProdDet> productosList = list.map((i) => ProdDet.toJson(i)).toList();


    //productosList = parsedJson['Producto'] != null ? list.map((i) => ProdDet.toJson(i)).toList() : List<ProdDet>();


    return PedidoDetalleEstado(
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
      gx_md5_hash: parsedJson['gx_md5_hash'],

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

  factory ProdDet.toJson(Map<String, dynamic> parsedJson) {
    return ProdDet(
      productoID: parsedJson['ProductoID'],
      productoNombre: parsedJson['ProductoNombre'],
      pedidoProductoCantidad: parsedJson['PedidoProductoCantidad'],
      pedidoProductoPrecio: parsedJson['PedidoProductoPrecio'],
      pedidoProductoPrecioTotal: parsedJson['PedidoProductoPrecioTotal']
    );
  }

  Map<String, dynamic> toJson(){
  return {
    "ProductoID": this.productoID,
    "ProductoNombre": this.productoNombre,
    "PedidoProductoCantidad": this.pedidoProductoCantidad,
    "PedidoProductoPrecio": this.pedidoProductoPrecio,
    "PedidoProductoPrecioTotal": this.pedidoProductoPrecioTotal
  };


}
}
class PedidoActualizar extends StatefulWidget {
  Widget producto(String estadoId,BuildContext context ) {
    
    return FutureBuilder<PedidoDetalleEstado>(
      future: updatePedido( estadoId,'','',context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.estadoID);
        } else if (snapshot.hasError) {
          Navigator.pushNamed(context, 'errorRegPues');
          return Text("${snapshot.error}");
        }

        return Center(child: Container(child: CircularProgressIndicator()));
      },
    );
  }

Future<PedidoDetalleEstado> updatePedido(String idEstado,pedidoId,pedidoComercioId,BuildContext context) async {
    
    

    
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

    final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/pedidoComercio/$pedidoId,$pedidoComercioId';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/pedidoComercio/$pedidoId,$pedidoComercioId';
    final response = await http.get('$mercadosListAPIUrl', headers: headers2);

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final pedidos = new PedidoDetalleEstado.fromJsonMap(decodedData);
      final actprodListAPIUrl = 'https://agilemarket.com.ar/rest/pedidoComercio/$pedidoId,$pedidoComercioId';
      final actprodListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/pedidoComercio/$pedidoId,$pedidoComercioId';
    
    
         http.Response response2 = await http.put(
          '$actprodListAPIUrl',
      
          headers: headers3,
          body: jsonEncode(<String, dynamic>
          {
            "PedidoID": pedidos.pedidoID,
            "PedidoFecha": pedidos.pedidoFecha,
            "PedidoComercioID": pedidos.pedidoComercioID,
            "ComercioID": pedidos.comercioID,
            "ComercioNombre": pedidos.comercioNombre,
            "MercadoID": pedidos.mercadoID,
            "MercadoNombre": pedidos.mercadoNombre,
            "EstadoID": idEstado,
            "EstadoNombre": "En preparación",
            "Producto": pedidos.productos,
            "PedidoPrecioTotal": pedidos.pedidoPrecioTotal,
            "gx_md5_hash": pedidos.gx_md5_hash
        }
          
          ),
        );

        
        if (response2.statusCode == 200) {
            setState(() => null);
            Navigator.of(context).pop();
            final decodedData2 = json.decode(response2.body);
            final producto =  PedidoDetalleEstado.fromJsonMap(decodedData2);
            String comercio = producto.comercioID;
            //Navigator.pushNamed(context, 'altaProdOk' ,arguments: PuestoArguments(user,nombreUser,foto,mercado,comercio,numNave, comercioPuesto,comercioCuit,comercioTelefono,comercioMail,comercioNombre));
      
          //return Puesto.fromJson(json.decode(response.body));
        } else {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, 'errorRegProd'
              //, arguments: PuestoArguments(user,nombreUser,foto,mercado,comercioId)
              );
        }


      //List jsonResponse = json.decode(response.body);
      //return jsonResponse.map<dynamic>((mercado) => new Mercados.fromJsonList(mercado));
    } else {
      Navigator.of(context).pop();
     // Navigator.pushNamed(context, 'errorRegProd', arguments: PuestoArguments(user,nombreUser,foto,mercado,comercioId,numNave, comercioPuesto,comercioCuit,comercioTelefono,comercioMail,comercioNombre));
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