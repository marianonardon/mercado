import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';





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

    final categoriasListAPIUrl = 'https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/rest/consultarCategoria';
    final response = await http.get('$categoriasListAPIUrl');

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
                    title, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                      fontSize: 25.0, fontWeight: FontWeight.w600,
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