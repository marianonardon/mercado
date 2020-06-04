import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';



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

class Categorias{

  List<Categoria> items = new List();

  Categorias();

  Categorias.fromJsonList(List<dynamic> jsonList) {

    if (jsonList == null) return;

    for (var item in jsonList) {
      final categoria = new Categoria.fromJsonMap(item);
      items.add(categoria);
      
    }

  }



}



class Categoria {
  final String categoriaID;
  final String categoriaNombre;
  final String categoriaImagen;


  Categoria({this.categoriaID, this.categoriaNombre, this.categoriaImagen});

  factory Categoria.fromJsonMap(Map<String, dynamic> parsedJson) {
    return Categoria(
      categoriaID: parsedJson['categoriaID'],
      categoriaNombre: parsedJson['categoriaNombre'],
      categoriaImagen: parsedJson['categoriaImagen'],
    );
  }
}

class CategoriasListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Categoria>>(
      future: _fetchCategorias(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Categoria> data = snapshot.data;
          return _categoriasListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<List<Categoria>> _fetchCategorias() async {

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



    final categoriasListAPIUrl = 'https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/rest/consultarCategoria';
    final response = await http.get('$categoriasListAPIUrl',headers: headers2);

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final categoria = new Categorias.fromJsonList(decodedData);
      return categoria.items;
      //List jsonResponse = json.decode(response.body);
      //return jsonResponse.map<dynamic>((mercado) => new Mercados.fromJsonList(mercado));
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _categoriasListView(data) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _crearLista(data[index].categoriaNombre,
                        data[index].categoriaImagen,context);
        });
  }


  Widget _crearLista(String title, String imagen,context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        
          width: 600.0,
      //   height: 500.0, */
        child: Column(
          children: <Widget>[
          //  _crearTitulo(),
            SizedBox(height: 15.0),
            GestureDetector(
              onTap: () {Navigator.pushNamed(context, 'productos', arguments: title);},
            child:_crearTarjetas(title, imagen))
          ],
        ),
      ),
    );
  }


  _crearTarjetas(title,imagen) {
  return Stack(
    fit: StackFit.loose,
    children: <Widget> [
      ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
        height: 180,
        width: 400,
        fit: BoxFit.fill,
        image: NetworkImage(imagen),

        placeholder: AssetImage('assets/img/original.gif')),
      ),

      Positioned(
        bottom: 10,
        left: 0,
        right: 0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0), 
          child: Container(
            child: Column(
              children:<Widget>[ 
                Row(
                  mainAxisAlignment: MainAxisAlignment.end ,
                  children: <Widget>[
                    Text(
                    title, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.white,
                      fontSize: 25.0, fontWeight: FontWeight.normal,
                      )),
                    ),
                    SizedBox(width: 30.0),
                  ],
                ),
              ]
            ),
          ),
        ),
      ),
      SizedBox(height: 20.0),
      ]
  );

  }

}