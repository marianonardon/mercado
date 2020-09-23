import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ComboPuesto extends StatefulWidget {
  ComboPuesto(this.mercadoId);
  final String mercadoId;
  @override
  _ComboPuesto createState() => _ComboPuesto(mercadoId);
}

class _ComboPuesto extends State<ComboPuesto> {
  _ComboPuesto(this.mercadoId);
  final String mercadoId;
  String _mySelection;


  List data = List(); //edited line

  Future<String> _fetchPuestos() async {


     String url = "https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/oauth/access_token";

    Map<String, String> bodyToken = {
      "client_id": "32936ed0b05f48859057b6a2dd5aee6f",
      "client_secret": "915b06d26cdf44f7b832c66fe6e58743",
      "scope": "FullControl",
      "username": "admin",
      "password": "admin123",
    };

    Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded"
    };

        String urlProd = "https://agilemarket.com.ar/oauth/access_token";

    Map<String, String> bodyTokenProd = {
      "client_id": "da0d4cd9919d4d80afecf1c56d954633",
      "client_secret": "be70f816716f402b8c02e53daec3e067",
      "scope": "FullControl",
      "username": "admin",
      "password": "wetiteam123",
    };


    final responseToken = await http.post(urlProd, body: bodyTokenProd, headers: headers);
    final decodedData = json.decode(responseToken.body);
    final token = new Token.fromJsonMap(decodedData);
    String token2 = token.accessToken.toString();


    Map<String, String> headers2 = {
      "Authorization": "OAuth $token2"
      };

    final mercadosListAPIUrl = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultarComercio?mercadoID=$mercadoId';
    final mercadosListAPIUrlProd = 'https://agilemarket.com.ar/rest/consultarComercio?mercadoID=$mercadoId';
    final response = await http.get('$mercadosListAPIUrlProd', headers: headers2);

    if (response.statusCode == 200) {
      var resBody = json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('idPuesto', '' );

      setState(() {
        data = resBody['comercios'];
      });
     
    } else {
      throw Exception('Failed to load jobs from API');
    }


  }

  @override
  void initState() {
    super.initState();
    this._fetchPuestos();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    if(data != null) {
      if(data.isNotEmpty){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: Color.fromRGBO(240, 241, 246, 1),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 3.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: media.size.height * 0.06,
            width: media.size.width * 0.70,
            child:  Center(
              child: DropdownButton(
                hint: Center(child: Text('Seleccione un puesto')),
                isExpanded: true,
                items: data.map((item) {
                return new DropdownMenuItem(
                  child: Center(child: new Text(item['comercioNombre'])),
                  value: item['comercioID'].toString(),
                );
                }).toList(),
               onChanged: (newVal) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('idPuesto', newVal );
                setState(() {
                  _mySelection = newVal;
                });
              },
              value: _mySelection,
          ),
            ),
          ),
        )
      ]
      );}else {
        return Container();
      }
      
      } else{
        return Container();
      }
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