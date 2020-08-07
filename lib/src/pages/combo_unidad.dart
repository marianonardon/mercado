import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ComboUnidad extends StatefulWidget {
  ComboUnidad(this.unidadId);
  final String unidadId;
  @override
  _ComboUnidad createState() => _ComboUnidad(unidadId);
}

class _ComboUnidad extends State<ComboUnidad> {
  _ComboUnidad(this.unidadId);
  final String unidadId;
  String _mySelection;


  List data = List(); //edited line

  Future<String> _fetchUnidad() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('idTipoUnidad', unidadId );


     String url = "https://agilemarket.com.ar/oauth/access_token";
     String urlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/oauth/access_token';

    Map<String, String> bodyToken = {
      "client_id": "da0d4cd9919d4d80afecf1c56d954633",
      "client_secret": "be70f816716f402b8c02e53daec3e067",
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


    final responseToken = await http.post(url, body: bodyToken, headers: headers);
    final decodedData = json.decode(responseToken.body);
    final token = new Token.fromJsonMap(decodedData);
    String token2 = token.accessToken.toString();


    Map<String, String> headers2 = {
      "Authorization": "OAuth $token2"
      };

    final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/consultaTipoUnidad';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultaTipoUnidad';
    final response = await http.get('$mercadosListAPIUrl', headers: headers2);

    if (response.statusCode == 200) {
      var resBody = json.decode(response.body);

      setState(() {
        data = resBody['tipoUnidad'];
      });
      return 'Success';
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  void initState() {
    super.initState();
    this._fetchUnidad();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    if (_mySelection == null) {
      _mySelection = unidadId;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 18.0,),
            Text('Tipo de unidad',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
            fontWeight: FontWeight.normal, fontSize: 12.0))),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
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
          width: media.size.width * 0.90,
          child:  DropdownButton(
            hint: Text('Seleccione un tipo de unidad'),
            isExpanded: true,
            items: data.map((item) {
            return new DropdownMenuItem(
              child: new Text(item['tipoUnidadNombre']),
              value: item['tipoUnidadID'].toString(),
            );
            }).toList(),
           onChanged: (newVal) async {
             SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('idTipoUnidad', newVal );
            setState(() {
              _mySelection = newVal;
            });
          },
          value: _mySelection,
        ),
        )
      ]
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