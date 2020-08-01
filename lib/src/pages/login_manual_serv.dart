import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserInfo {
  final String guid;
  final String name;
  final String lastName;
  final String fotoUser;
  



  UserInfo({this.guid, this.name, this.lastName, this.fotoUser});

  factory UserInfo.fromJsonMap(Map<String, dynamic> parsedJson) {
    return UserInfo(
      guid: parsedJson['GUID'],
      name: parsedJson['FirstName'],
      lastName: parsedJson['LastName'],
      fotoUser: parsedJson['URLImage'],
    );
  }
}


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



class LoginManual extends StatefulWidget {
  Widget login(String nombreUsuario, contrasenia,BuildContext context ) {
    
    return FutureBuilder<Token>(
      future: createLogin( nombreUsuario, contrasenia,context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.userGuid);
        } else if (snapshot.hasError) {
          Navigator.pushNamed(context, 'errorRegPues');
          return Text("${snapshot.error}");
        }

        return Center(child: Container(child: CircularProgressIndicator()));
      },
    );
  }

Future<Token> createLogin(String nombreUsuario, contrasenia,BuildContext context) async {
    
    MediaQueryData media = MediaQuery.of(context);
    
    String url = "https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/oauth/access_token";
    String urlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/oauth/access_token';

    Map<String, String> bodyToken = {
      "client_id": "d6471aff30e64770bd9da53caccc4cc4",
      "client_secret": "7dae40626f4f45378b22bb47aa750024",
      "scope": "FullControl",
      "username": nombreUsuario,
      "password": contrasenia,
    };

        Map<String, String> bodyTokenQA = {
      "client_id": "32936ed0b05f48859057b6a2dd5aee6f",
      "client_secret": "915b06d26cdf44f7b832c66fe6e58743",
      "scope": "FullControl",
      "username": nombreUsuario,
      "password": contrasenia,
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

      if (responseToken.statusCode == 200) {
          final decodedData2 = json.decode(responseToken.body);
          final token =  Token.fromJsonMap(decodedData2);
          String userGuid = token.userGuid;
          final mercadosListAPIUrl = 'https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/oauth/userinfo';
          final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/oauth/userinfo';
          final response = await http.get('$mercadosListAPIUrlQA', headers: headers2);

          if (response.statusCode == 200) {
            final decodedData = json.decode(response.body);
            final userInfo = new UserInfo.fromJsonMap(decodedData);
            String userNombre = userInfo.name;
            String userApellido = userInfo.lastName;
            String userFoto = userInfo.fotoUser;
            String userId = userInfo.guid;
            String nombreCompleto = '$userNombre $userApellido';

            if(userFoto == ''){
              userFoto = 'https://res.cloudinary.com/agilemarket/image/upload/v1594599858/m3wh5dxmlwmyjbpit3cr.png';
            }

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('usuarioId2', userId);
            prefs.setString('usuarioId', '');
            prefs.setString('nombre', nombreCompleto);
            prefs.setString('fotoUser', userFoto);

            Navigator.pushNamed(context, 'mercado');
            //List jsonResponse = json.decode(response.body);
            //return jsonResponse.map<dynamic>((mercado) => new Mercados.fromJsonList(mercado));
          } else {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (context) => WillPopScope(
                onWillPop: () async => false,
                              child: AlertDialog(
                  title: Center(child: Text('Error al iniciar sesión')),
                  content: Text('Usuario y/o contraseña inválidos'),
                  backgroundColor: Colors.white,
                  actions: [
                      Padding(
                        padding: const EdgeInsets.only(right:65.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FlatButton(
                              color: Color.fromRGBO(29, 233, 182, 1),
                              onPressed: () {
                              Navigator.pushNamed(context, 'loginManual');},
                              child: Text('Volver a intentar'),
                              textColor: Colors.black,
                            
                            ),
                              
                          ],
                        ),
                      ),
                      
                    ],

            ),
              ),
            barrierDismissible: false,
              ).then((_) => setState((){}));
          }
       } else {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (context) => WillPopScope(
                onWillPop: () async => false,
                              child: AlertDialog(
                  title: Center(child: Text('Error al iniciar sesión')),
                  content: Text('Usuario y/o contraseña inválidos'),
                  backgroundColor: Colors.white,
                  actions: [
                      Padding(
                        padding: const EdgeInsets.only(right:65.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FlatButton(
                              color: Color.fromRGBO(29, 233, 182, 1),
                              onPressed: () {
                              Navigator.pushNamed(context, 'loginManual');},
                              child: Text('Volver a intentar'),
                              textColor: Colors.black,
                            
                            ),
                              
                          ],
                        ),
                      ),
                      
                    ],

            ),
              ),
            barrierDismissible: false,
              ).then((_) => setState((){}));
            //Navigator.pushNamed(context, 'errorRegProd');
      }
    }
    
      @override
      State<StatefulWidget> createState() {
        throw UnimplementedError();
      }
    
      void setState(Null Function() param0) {}



}
