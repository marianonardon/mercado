import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
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
  final String id;
  final String comercioNombre;
  final String comercioCuit;
  final String comercioDireccion;
  final String comercioDireccionEntrega;
  final String comercioTelefono;
  final String comercioEmail;
  final String comercioPuesto;
  final String comercioNumNave;

  Puesto({this.id, this.comercioNombre,this.comercioCuit, this.comercioDireccion,this.comercioDireccionEntrega,
         this.comercioTelefono,this.comercioEmail, this.comercioPuesto,this.comercioNumNave});

  factory Puesto.fromJson(Map<String, dynamic> json) {
    return Puesto(
      id: json['ComercioExternalID'], 
      comercioNombre: json['comercioNombre'], 
      comercioCuit: json['comercioCuit'], 
      comercioDireccion: json['comercioDireccion'], 
      comercioDireccionEntrega: json['comercioDireccionEntrega'], 
      comercioTelefono: json['comercioTelefono'], 
      comercioEmail: json['comercioEmail'], 
      comercioPuesto: json['comercioPuesto'], 
      comercioNumNave: json['comercioNumNave'], 
      
      
      
    );
  }
}

class PuestoCrear extends StatefulWidget {
  Widget puesto(String nombre, cuit, direccion, telefono, email, puesto, nave, idUser,BuildContext context ) {
    
    return FutureBuilder<Puesto>(
      future: createPuesto(nombre, cuit, direccion, telefono, email, puesto, nave, idUser,context),
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

Future<Puesto> createPuesto(String nombre, cuit, direccion, telefono, email, puesto, nave, idUser,BuildContext context) async {

  
    SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
    String externalId2 = prefs.getString('usuarioId');
    setState(() {
      idUser = externalId2;
    }); 
    
    
        String url = "https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/oauth/access_token";
    
        Map<String, String> bodyToken = {
          "client_id": "d6471aff30e64770bd9da53caccc4cc4",
          "client_secret": "7dae40626f4f45378b22bb47aa750024",
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
    
      final http.Response response = await http.post(
        'https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/rest/comercio/3,0,$idUser',
    
        headers: headers3,
        body: jsonEncode(<String, String>{
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
        
      
          final puesto = new Puesto.fromJson(json.decode(response.body));
          Navigator.pushNamed(context, 'altaComOk');
         
    
        //return Puesto.fromJson(json.decode(response.body));
      } else {
            Navigator.pushNamed(context, 'errorRegPues');
      }
    }
    
      @override
      State<StatefulWidget> createState() {
        throw UnimplementedError();
      }
    
      void setState(Null Function() param0) {}



}