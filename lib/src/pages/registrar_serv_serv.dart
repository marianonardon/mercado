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

  Puesto({this.idComercio,this.id, this.id2,this.comercioNombre,this.comercioCuit, this.comercioDireccion,this.comercioDireccionEntrega,
         this.comercioTelefono,this.comercioEmail, this.comercioPuesto,this.comercioNumNave});

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
      
      
      
    );
  }
}

class PuestoCrear extends StatefulWidget {
  Widget puesto(String nombre, cuit, direccion, telefono, email, puesto, nave, idUser,mercadoId,userId,nombreUser,fotoUser,BuildContext context ) {
    
    return FutureBuilder<Puesto>(
      future: createPuesto(nombre, cuit, direccion, telefono, email, puesto, nave, idUser,mercadoId,userId,nombreUser,fotoUser,context),
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

Future<Puesto> createPuesto(String nombre, cuit, direccion, telefono, email, puesto, nave, idUser,mercadoId,userId,userNombre,fotoUser,BuildContext context) async {

  
    SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
    String externalId2 = prefs.getString('usuarioId');
    String userId      = prefs.getString('usuarioId2');
    setState(() {
      idUser = externalId2;
    }); 

    if(externalId2 == ''){
      idUser = userId;
    } else {
      idUser = externalId2;
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

    final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/comercio/$mercadoId,0,$idUser';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/comercio/$mercadoId,0,$idUser';
    
      final http.Response response = await http.post(
        '$mercadosListAPIUrl',
    
        headers: headers3,
        body: jsonEncode(<String, String>{
          "ComercioUserID": userId,
          'ComercioExternalID': externalId2,
          'ComercioNombre': nombre,
          'ComercioCuit': cuit,
          'ComercioDireccion': direccion,
          'ComercioDireccionEntrega': direccion,
          'ComercioTelefono': telefono,
          'ComercioEmail': email,
          'ComercioPuesto': puesto,
          'ComercioNumNave': nave,
        }),
      );
      
      if (response.statusCode == 201) { 
          Navigator.pop(context);
          final decodedData2 = json.decode(response.body);
          final puesto =  Puesto.fromJsonMap(decodedData2);
          String comercio = puesto.idComercio;
          Navigator.pushNamed(context, 'altaComOk' ,arguments: PuestoArguments(userId,userNombre,fotoUser, mercadoId, comercio,puesto.comercioNumNave,puesto.comercioPuesto,
          puesto.comercioCuit,puesto.comercioTelefono,puesto.comercioEmail,puesto.comercioNombre));
         
    
        //return Puesto.fromJson(json.decode(response.body));
      } else {
        Navigator.pop(context);
        Navigator.pushNamed(context, 'errorRegPues');
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