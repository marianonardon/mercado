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
  final String gx;

  Puesto({this.idComercio,this.id,this.id2, this.comercioNombre,this.comercioCuit, this.comercioDireccion,this.comercioDireccionEntrega,
         this.comercioTelefono,this.comercioEmail, this.comercioPuesto,this.comercioNumNave,this.gx});

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
      gx: parsedJson['gx_md5_hash']
      
      
      
    );
  }
}

class PuestoActualizar extends StatefulWidget {
  Widget puesto(String nombre, cuit, direccion, telefono, email, puesto, nave, idUser,mercadoId,userId,nombreUser,fotoUser,idComercio,comercioFoto,BuildContext context ) {
    
    return FutureBuilder<Puesto>(
      future: updatePuesto(nombre, cuit, direccion, telefono, email, puesto, nave, idUser,mercadoId,userId,nombreUser,fotoUser,idComercio,comercioFoto,context),
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

Future<Puesto> updatePuesto(String nombre, cuit, direccion, telefono, email, puesto, nave, idUser,mercadoId,userId,userNombre,fotoUser,idComercio,comercioFoto,BuildContext context) async {

  
    SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
    String externalId2 = prefs.getString('usuarioId');
    String userId      = prefs.getString('usuarioId2');
    setState(() {
      idUser = externalId2;
    }); 

    if(externalId2 == ''){
      idUser = userId;
    }
    
    
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

    final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/comercio/$mercadoId,$idComercio';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/comercio/$mercadoId,$idComercio';

    final response = await http.get('$mercadosListAPIUrl', headers: headers2);

    if (response.statusCode == 200) {
      final decodedData2 = json.decode(response.body);
      final puesto2 =  Puesto.fromJsonMap(decodedData2);
    
      final http.Response response2 = await http.put(
        '$mercadosListAPIUrl',
    
        headers: headers3,
        body: jsonEncode(<String, String>{
          'MercadoID': mercadoId,
          'ComercioID': idComercio,
          "ComercioUserID": userId,
          'ComercioExternalID': externalId2,
          'ComercioNombre': nombre,
          'ComercioCuit': cuit,
          'ComercioTelefono': telefono,
          'ComercioEmail': email,
          'ComercioPuesto': puesto,
          'ComercioNumNave': nave,
          'ComercioFoto':comercioFoto,
          "gx_md5_hash": puesto2.gx
        }),
      );
      
      if (response2.statusCode == 200) { 
          Navigator.pop(context);
          final decodedData3 = json.decode(response2.body);
          final puesto =  Puesto.fromJsonMap(decodedData3);
          String comercio = puesto.idComercio;
          Navigator.pushNamed(context, 'actPuesOk' ,arguments: PuestoArguments(userId,userNombre,fotoUser, mercadoId, comercio,puesto.comercioNumNave,puesto.comercioPuesto,
          puesto.comercioCuit,puesto.comercioTelefono,puesto.comercioEmail,puesto.comercioNombre,comercioFoto));
         
    
        //return Puesto.fromJson(json.decode(response.body));
      } else {
        Navigator.pop(context);
        Navigator.pushNamed(context, 'errorActPues');
      }
    }
}
    
      @override
      State<StatefulWidget> createState() {
        throw UnimplementedError();
      }
    
      void setState(Null Function() param0) {}



}

class ScreensArguments {
  final String userId;
  final String nombre;
  final String foto;
  final String mercadoId;
  final String comercioId;


  ScreensArguments(this.userId, this.nombre,this.foto,this.mercadoId,this.comercioId);
}