import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';
import 'package:http/http.dart' as http;
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



class Puesto {
  final String idComercio;
  final String id;
  final String id2;
  final String comercioNombre;
  final String comercioCuit;
  final String comercioDireccion;
  final String comercioDireccionEntrega;
  final String comercioTelefono;
  final String comercioEmail;
  final String comercioPuesto;
  final String comercioNumNave;
  final String comercioFoto;
  final String comercioCantPuntaje;
  final String comercioPuntaje;
  final String gx;

  Puesto({this.idComercio,this.id,this.id2, this.comercioNombre,this.comercioCuit, this.comercioDireccion,this.comercioDireccionEntrega,
         this.comercioTelefono,this.comercioEmail, this.comercioPuesto,this.comercioNumNave,this.comercioFoto,this.comercioCantPuntaje,this.comercioPuntaje,this.gx});

  factory Puesto.fromJsonMap(Map<String, dynamic> parsedJson) {
    return Puesto(
      idComercio: parsedJson['ComercioID'],
      id: parsedJson['ComercioExternalID'], 
      id2: parsedJson['comercioUserID'], 
      comercioNombre: parsedJson['ComercioNombre'], 
      comercioCuit: parsedJson['ComercioCuit'], 
      comercioDireccion: parsedJson['ComercioDireccion'], 
      comercioDireccionEntrega: parsedJson['ComercioDireccionEntrega'], 
      comercioTelefono: parsedJson['ComercioTelefono'], 
      comercioEmail: parsedJson['ComercioEmail'], 
      comercioPuesto: parsedJson['ComercioPuesto'], 
      comercioNumNave: parsedJson['ComercioNumNave'], 
      comercioFoto: parsedJson['ComercioFoto'],
      comercioCantPuntaje: parsedJson['ComercioCantPuntaje'],
      comercioPuntaje: parsedJson['ComercioPuntaje'],
      gx: parsedJson['gx_md5_hash']
      
      
      
    );
  }
}

class PuestoValoracion extends StatefulWidget {
  Widget puesto(idComercio,idMercado,valoracion,BuildContext context ) {
    
    return FutureBuilder<Puesto>(
      future: valoracion(idComercio,idMercado,valoracion,context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.comercioNombre);
        } else if (snapshot.hasError) {
          Navigator.pushNamed(context, 'errorRegPues');
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );
  }

Future<Puesto> valoracion(idComercio,mercadoId,valoracion,BuildContext context) async {


    
    
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
    
    
      Map headers3 = <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "OAuth $token2"
        };

    final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/comercio/$mercadoId,$idComercio';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/comercio/$mercadoId,$idComercio';

    final response = await http.get('$mercadosListAPIUrlQA', headers: headers2);

    if (response.statusCode == 200) {
      int comercioPuntaje;
      int comercioCantPuntaje;

      final decodedData2 = json.decode(response.body);
      final puesto2 =  Puesto.fromJsonMap(decodedData2);  

      comercioPuntaje = int.parse(puesto2.comercioPuntaje);
      comercioCantPuntaje = int.parse(puesto2.comercioCantPuntaje);

      int puntaje = comercioPuntaje + valoracion;
      int cantidadPuntaje = comercioCantPuntaje + 1;

      String puntajeServ = puntaje.toString();
      String cantidadServ =cantidadPuntaje.toString();

    
      final http.Response response2 = await http.put(
        '$mercadosListAPIUrlQA',
    
        headers: headers3,
        body: jsonEncode(<String, String>{
          'MercadoID': mercadoId,
          'ComercioID': idComercio,
          "ComercioUserID": puesto2.id2,
          'ComercioExternalID': puesto2.id,
          'ComercioNombre': puesto2.comercioNombre,
          'ComercioCuit': puesto2.comercioCuit,
          'ComercioTelefono': puesto2.comercioTelefono,
          'ComercioEmail': puesto2.comercioEmail,
          'ComercioPuesto': puesto2.comercioPuesto,
          'ComercioNumNave': puesto2.comercioNumNave,
          'ComercioFoto':puesto2.comercioFoto,
          "ComercioCantPuntaje":cantidadServ,
          "ComercioPuntaje":puntajeServ,
          "gx_md5_hash": puesto2.gx
        }),
      );
      
      if (response2.statusCode == 200) { 
          Navigator.pop(context);
          final decodedData3 = json.decode(response2.body);
          final puesto =  Puesto.fromJsonMap(decodedData3);
          String comercio = puesto.idComercio;
          Navigator.pushNamed(context, 'valoracionOk');
         
    
        //return Puesto.fromJson(json.decode(response.body));
      } else {
        Navigator.pop(context);
      }
    }
}
    
      @override
      State<StatefulWidget> createState() {
        throw UnimplementedError();
      }
    
      void setState(Null Function() param0) {}



}

class ValoracionArguments {
  final String mercadoId;
  final String comercioId;


  ValoracionArguments(this.mercadoId, this.comercioId);
}