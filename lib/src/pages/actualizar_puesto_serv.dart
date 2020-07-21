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
  final String comercioNombre;
  final String comercioCuit;
  final String comercioDireccion;
  final String comercioDireccionEntrega;
  final String comercioTelefono;
  final String comercioEmail;
  final String comercioPuesto;
  final String comercioNumNave;
  final String gx;

  Puesto({this.idComercio,this.id, this.comercioNombre,this.comercioCuit, this.comercioDireccion,this.comercioDireccionEntrega,
         this.comercioTelefono,this.comercioEmail, this.comercioPuesto,this.comercioNumNave,this.gx});

  factory Puesto.fromJsonMap(Map<String, dynamic> parsedJson) {
    return Puesto(
      idComercio: parsedJson['ComercioID'],
      id: parsedJson['ComercioExternalID'], 
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
  Widget puesto(String nombre, cuit, direccion, telefono, email, puesto, nave, idUser,mercadoId,userId,nombreUser,fotoUser,idComercio,BuildContext context ) {
    
    return FutureBuilder<Puesto>(
      future: updatePuesto(nombre, cuit, direccion, telefono, email, puesto, nave, idUser,mercadoId,userId,nombreUser,fotoUser,idComercio,context),
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

Future<Puesto> updatePuesto(String nombre, cuit, direccion, telefono, email, puesto, nave, idUser,mercadoId,userId,userNombre,fotoUser,idComercio,BuildContext context) async {

  
    SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
    String externalId2 = prefs.getString('usuarioId');
    setState(() {
      idUser = externalId2;
    }); 
    
    
    String url = "https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/oauth/access_token";
    String urlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/oauth/access_token';

    Map<String, String> bodyToken = {
      "client_id": "d6471aff30e64770bd9da53caccc4cc4",
      "client_secret": "7dae40626f4f45378b22bb47aa750024",
      "scope": "FullControl",
      "username": "admin",
      "password": "admin123",
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

    final mercadosListAPIUrl = 'https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/rest/comercio/2,0,$idUser';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/comercio/$mercadoId,$idComercio';

    final response = await http.get('$mercadosListAPIUrlQA', headers: headers2);

    if (response.statusCode == 200) {
      final decodedData2 = json.decode(response.body);
      final puesto2 =  Puesto.fromJsonMap(decodedData2);
    
      final http.Response response2 = await http.put(
        '$mercadosListAPIUrlQA',
    
        headers: headers3,
        body: jsonEncode(<String, String>{
          'MercadoID': mercadoId,
          'ComercioID': idComercio,
          'ComercioExternalID': externalId2,
          'ComercioNombre': nombre,
          'ComercioCuit': cuit,
          'ComercioTelefono': telefono,
          'ComercioEmail': email,
          'ComercioPuesto': puesto,
          'ComercioNumNave': nave,
          "gx_md5_hash": puesto2.gx
        }),
      );
      
      if (response2.statusCode == 200) { 
          Navigator.pop(context);
          final decodedData3 = json.decode(response.body);
          final puesto =  Puesto.fromJsonMap(decodedData2);
          String comercio = puesto.idComercio;
          Navigator.pushNamed(context, 'actPuesOk' ,arguments: PuestoArguments(userId,userNombre,fotoUser, mercadoId, comercio,puesto.comercioNumNave,puesto.comercioPuesto,
          puesto.comercioCuit,puesto.comercioTelefono,puesto.comercioEmail,puesto.comercioNombre));
         
    
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