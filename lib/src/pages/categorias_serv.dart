import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
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

class CategoriasListView extends StatefulWidget {
  CategoriasListView(this.mercadoId,this.userId,this.nombreUser,this.fotoUser);
  final String mercadoId;
  final String userId;
  final String nombreUser;
  final String fotoUser; 

  @override
  _CategoriasListViewState createState() => _CategoriasListViewState();
}

class _CategoriasListViewState extends State<CategoriasListView> {
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
        return Center(child: CircularProgressIndicator(
          backgroundColor:  Color.fromRGBO(29, 233, 182, 1),
        ));
      },
    );
  }

  Future<List<Categoria>> _fetchCategorias() async {
    

    String url = "https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/oauth/access_token";

    Map<String, String> bodyToken = {
      "client_id": "32936ed0b05f48859057b6a2dd5aee6f",
      "client_secret": "915b06d26cdf44f7b832c66fe6e58743",
      "scope": "FullControl",
      "username": "admin",
      "password": "admin123",
    };

        String urlProd = "https://agilemarket.com.ar/oauth/access_token";

    Map<String, String> bodyTokenProd = {
      "client_id": "da0d4cd9919d4d80afecf1c56d954633",
      "client_secret": "be70f816716f402b8c02e53daec3e067",
      "scope": "FullControl",
      "username": "admin",
      "password": "wetiteam123",
    };

    Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded"
    };


    final responseToken = await http.post(url, body: bodyToken, headers: headers);
    final decodedData = json.decode(responseToken.body);
    final token = new Token.fromJsonMap(decodedData);
    String token2 = token.accessToken.toString();

    //SharedPreferences prefs = await SharedPreferences.getInstance();
      //String token2 = prefs.getString('token');
    //String token2 = 'maro';
       



    Map<String, String> headers2 = {
      "Authorization": "OAuth $token2"
      };



    final categoriasListAPIUrl = 'https://agilemarket.com.ar/rest/consultarCategoria';
    final categoriasListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultarCategoria';
    var response = await http.get('$categoriasListAPIUrlQA',headers: headers2);

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final categoria = new Categorias.fromJsonList(decodedData);
      return categoria.items;
      //List jsonResponse = json.decode(response.body);
      //return jsonResponse.map<dynamic>((mercado) => new Mercados.fromJsonList(mercado));
    } else {
      if (response.statusCode == 401) {
        final responseToken = await http.post(urlProd, body: bodyTokenProd, headers: headers);
        final decodedData = json.decode(responseToken.body);
        final token = new Token.fromJsonMap(decodedData);
        token2 = token.accessToken.toString();
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
    }
  }

  ListView _categoriasListView(data) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _crearLista(data[index].categoriaNombre,
                        data[index].categoriaImagen,data[index].categoriaID,context);
        });
  }

  Widget _crearLista(String title, String imagen,String categoriaID,context) {
    MediaQueryData media = MediaQuery.of(context);
    return  ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        
          width: media.size.width * 0.95,
      //   height: 500.0, */
        child: Column(
          children: <Widget>[
          //  _crearTitulo(),
            SizedBox(height: 15.0),
            GestureDetector(
              onTap: () {Navigator.pushNamed(context, 'productos', arguments: ProductosArguments(categoriaID, widget.mercadoId,'',widget.userId,widget.nombreUser,widget.fotoUser,title));},
            child:_crearTarjetas(title, imagen,context))
          ],
        ),
      ),
    );
  }

  _crearTarjetas(title,imagen,context) {
    MediaQueryData media = MediaQuery.of(context);
  return Stack(
    fit: StackFit.loose,
    children: <Widget> [
      ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image(
        height: media.size.height * 0.23,
        width: media.size.width * 0.93,
        fit: BoxFit.fill,
        image: NetworkImage(imagen),

        //placeholder: AssetImage('assets/img/loader.gif')),
      )),

      Positioned(
        bottom: 10,
        left: 3,
        right: 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0), 
          child: Container(
            color: Colors.black26,
            child: Column(
              children:<Widget>[ 
                Row(
                  mainAxisAlignment: MainAxisAlignment.end ,
                  children: <Widget>[
                    Text(
                    title, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.white,
                      fontSize: 21.0, fontWeight: FontWeight.normal,
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


class ProductosArguments {
  final String categoriaId;
  final String mercadoId;
  final String productoBuscado;
  final String userId;
  final String nombreUser;
  final String fotoUser; 
  final String categoriaNombre;


  ProductosArguments(this.categoriaId, this.mercadoId,this.productoBuscado,this.userId,this.nombreUser,this.fotoUser,this.categoriaNombre);
}