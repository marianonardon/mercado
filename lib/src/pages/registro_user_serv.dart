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

class Users{

  List<LoginError> items = new List();

  Users();

  Users.fromJsonList(List<dynamic> jsonList) {

    if (jsonList == null) return;

    for (var item in jsonList) {
      final mercado = new LoginError.fromJsonMap(item);
      items.add(mercado);
      
    }

  }



}

class LoginError {
  final String id;
  final int type;
  final String description;



  LoginError({this.id, this.type, this.description});

  factory LoginError.fromJsonMap(Map<String, dynamic> parsedJson) {
    return LoginError(
      id: parsedJson['Id'],
      type: parsedJson['Type'],
      description: parsedJson['Description'],
    );
  }
}



class RegistroUser extends StatefulWidget {
  Widget registro(String nombreUsuario, contrasenia,confContrasenia,nombre,apellido,mail,BuildContext context ) {
    
    return FutureBuilder<Token>(
      future: createUser( nombreUsuario, contrasenia,confContrasenia,nombre,apellido,mail,context),
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

Future<Token> createUser(String nombreUsuario, contrasenia,confContrasenia,nombre,apellido,mail,BuildContext context) async {
    
    MediaQueryData media = MediaQuery.of(context);
    
    String url = "https://agilemarket.com.ar/oauth/access_token";
    String urlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/oauth/access_token';

    Map<String, String> bodyToken = {
      "client_id": "da0d4cd9919d4d80afecf1c56d954633",
      "client_secret": "be70f816716f402b8c02e53daec3e067",
      "scope": "FullControl",
      "username": 'admin',
      "password": 'admin123',
    };

        Map<String, String> bodyTokenQA = {
      "client_id": "32936ed0b05f48859057b6a2dd5aee6f",
      "client_secret": "915b06d26cdf44f7b832c66fe6e58743",
      "scope": "FullControl",
      "username": 'admin',
      "password": 'admin123',
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

      if (responseToken.statusCode == 200) {
          final decodedData2 = json.decode(responseToken.body);
          final token =  Token.fromJsonMap(decodedData2);
          final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/GAMSDRegisterUser';
          final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/GAMSDRegisterUser';
          http.Response response = await http.post(
            '$mercadosListAPIUrl',
        
            headers: headers3,
            body: jsonEncode(<String, dynamic>{
              "ConfirmPassword": confContrasenia,
              "Email": mail,
              "FirstName": nombre,
              "LastName": apellido,
              "Password": contrasenia,
              "UserName": nombreUsuario
            }),
          );

          if (response.statusCode == 200) {
            final decodedData = json.decode(response.body);

            final descError =  Users.fromJsonList(decodedData['Messages']);
             List<LoginError> data = descError.items;
            if (data.isNotEmpty) {
             String descripcionError = data[0].description;
            if (descripcionError.isNotEmpty) {
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context) => WillPopScope(
                  onWillPop: () async => false,
                                  child: AlertDialog(
                    title: Center(child: Text('Error al registrarse')),
                    content: Text(descripcionError),
                    backgroundColor: Colors.white,
                    actions: [
                        Padding(
                          padding: const EdgeInsets.only(right:50.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              FlatButton(
                                color: Color.fromRGBO(29, 233, 182, 1),
                                onPressed: () {
                                Navigator.pushNamed(context, 'registrarse');},
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
            } else {
              showDialog(
                context: context,
                builder: (context) => WillPopScope(
                  onWillPop: () async => false,
                                  child: AlertDialog(
                    title: Center(child: Text('Registro exitoso')),
                    content:  SizedBox(
                              width: media.size.width * 0.005,
                              height: media.size.height * 0.05,
                              child: Center(
                                child: Icon(Icons.check_circle, color: Color.fromRGBO(29, 233, 182, 1),size: 50.0,)
                              ),
                          ),
                    backgroundColor: Colors.white,
                    actions: [
                        Padding(
                          padding: const EdgeInsets.only(right:50.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              FlatButton(
                                color: Color.fromRGBO(29, 233, 182, 1),
                                onPressed: () {
                                Navigator.pushNamed(context, 'loginManual');},
                                child: Text('Iniciar sesión'),
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
             
            }}else {
              showDialog(
                  context: context,
                  builder: (context) => WillPopScope(
                    onWillPop: () async => false,
                                      child: AlertDialog(
                      title: Center(child: Text('Registro exitoso')),
                      content:  SizedBox(
                                width: media.size.width * 0.005,
                                height: media.size.height * 0.05,
                                child: Center(
                                  child: Icon(Icons.check_circle, color: Color.fromRGBO(29, 233, 182, 1),size: 50.0,)
                                ),
                            ),
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
                                  child: Text('Iniciar sesión'),
                                  textColor: Colors.black,
                                
                                ),
                                  
                              ],
                            ),
                          ),
                          
                        ],

                ),
                  ),
                barrierDismissible: false,
                  ).then((_) => setState((){}));}


            
            //List jsonResponse = json.decode(response.body);
            //return jsonResponse.map<dynamic>((mercado) => new Mercados.fromJsonList(mercado));
          } else {
            final decodedData = json.decode(response.body);
            final descError =  LoginError.fromJsonMap(decodedData['Messages']);
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (context) => WillPopScope(
                onWillPop: () async => false,
                              child: AlertDialog(
                  title: Center(child: Text('Error al registrarse')),
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
                              Navigator.pushNamed(context, 'registrarse');},
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
