import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';





class Mercados{

  List<Mercado> items = new List();

  Mercados();

  Mercados.fromJsonList(List<dynamic> jsonList) {

    if (jsonList == null) return;

    for (var item in jsonList) {
      final mercado = new Mercado.fromJsonMap(item);
      items.add(mercado);
      
    }

  }



}



class Mercado {
  final String mercadoId;
  final String mercadoNombre;
  final String mercadoDireccion;
  final String mercadoTelefono;
  final String mercadoFechaAlta;
  final bool mercadoHabilitado;
  final String mercadoImagen;


  Mercado({this.mercadoId, this.mercadoNombre, this.mercadoDireccion, this.mercadoTelefono, this.mercadoFechaAlta,
          this.mercadoHabilitado, this.mercadoImagen});

  factory Mercado.fromJsonMap(Map<String, dynamic> parsedJson) {
    return Mercado(
      mercadoId: parsedJson['mercadoID'],
      mercadoNombre: parsedJson['mercadoNombre'],
      mercadoDireccion: parsedJson['mercadoDireccion'],
      mercadoTelefono: parsedJson['mercadoTelefono'],
      mercadoFechaAlta: parsedJson['mercadoFechaAlta'],
      mercadoHabilitado: parsedJson['mercadoHabilitado'],
      mercadoImagen: parsedJson['mercadoImagen'],
    );
  }
}

class MercadosListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Mercado>>(
      future: _fetchMercados(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Mercado> data = snapshot.data;
/*           _obtenerToken();
          _obtenerRubro(); */
          return _mercadosListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<Mercado>> _fetchMercados() async {

    final mercadosListAPIUrl = 'https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/rest/consultarMercado/';
    final mercadosHabilitados = '?habilitado=1';
    final response = await http.get('$mercadosListAPIUrl$mercadosHabilitados');

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final mercados = new Mercados.fromJsonList(decodedData['mercados']);
      return mercados.items;
      //List jsonResponse = json.decode(response.body);
      //return jsonResponse.map<dynamic>((mercado) => new Mercados.fromJsonList(mercado));
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _mercadosListView(data) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _crearLista(data[index].mercadoNombre, data[index].mercadoDireccion, Icons.location_on,
                        data[index].mercadoImagen,context);
        });
  }


  Widget _crearLista(String title, String subtitle, IconData icon, String imagen,context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        
          width: 400.0,
      //   height: 500.0, */
        child: Column(
          children: <Widget>[
          //  _crearTitulo(),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {Navigator.pushNamed(context, 'categorias', arguments: title);},
            child:_crearTarjetas(title, subtitle, icon, imagen))
          ],
        ),
      ),
    );
  }


  _crearTarjetas(title, subtitle, icon, imagen) {
  return Stack(
    fit: StackFit.loose,
    children: <Widget> [
      ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: FadeInImage(
        height: 200,
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
                  children: <Widget>[
                    SizedBox(width: 20.0),
                    Text(
                    title, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.white,
                      fontSize: 25.0, fontWeight: FontWeight.w600,
                      ))
                    
              ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(width: 20.0),
                    Icon(icon, color: Colors.white,),
                    Text(
                    subtitle, style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.white,
                      fontSize: 20.0, fontWeight: FontWeight.w600)),
              ),
                  ],
                )
              ]
            ),
          ),
        ),
      ),
      SizedBox(height: 20.0),
      ]
  );

  }

  _obtenerToken() async {

    String url = "https://apps5.genexus.com/Id416f02b853b108b62b0d308b80154b1b/oauth/access_token";

    Map<String, String> bodyToken = {
      "client_id": "cfc1090c9e114f57a5b0fbc3aaa5be0b",
      "client_secret": "715369e92c824c9fad89f0ae4fef4a4c",
      "scope": "FullControl",
      "username": "admin",
      "password": "admin123",
    };

    Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded"
    };

    http.post(url, body: bodyToken, headers: headers).then((response){
        print(response.body.toString());
    });

  }

      _obtenerRubro() async {

    String url = "https://apps5.genexus.com/Id416f02b853b108b62b0d308b80154b1b/rest/rubro/2";

    Map<String, String> bodyToken = {
      "client_id": "cfc1090c9e114f57a5b0fbc3aaa5be0b",
      "client_secret": "715369e92c824c9fad89f0ae4fef4a4c",
      "scope": "FullControl",
      "username": "admin",
      "password": "admin123",
    };

    Map<String, String> headers2 = {
        "Authorization": "OAuth e77a867d-1086-4fa3-b55f-add2ac05595e!a6a51538e020329c54be086958e4e66bbe5ea63ace150eb9a8995802b5c9414e4e7b2a04de10d3"
    };

    http.get(url, headers: headers2).then((response){
        print(response.body.toString());
    });
      }

}