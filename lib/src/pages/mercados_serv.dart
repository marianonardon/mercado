import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


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
    final response = await http.get(mercadosListAPIUrl);

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
                        data[index].mercadoImagen);
        });
  }

  ListTile _tile(String title, String subtitle, IconData icon, String imagen) => ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
      );

  Widget _crearLista(String title, String subtitle, IconData icon, String imagen) {
    return  ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    
                     width: 500.0,
                 //   height: 500.0, */
                    child: Column(
                      children: <Widget>[
                      //  _crearTitulo(),
                        SizedBox(height: 20.0),
                        Stack(
                          fit: StackFit.loose,
                        

                          children: <Widget> [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(20.0),
                              child: FadeInImage(
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.fill,
                             image: NetworkImage(imagen),

                              placeholder: AssetImage('assets/img/original.gif')),
                           ),

                            Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: ClipRRect(
                               borderRadius: BorderRadius.circular(20.0), 
                               child: Container(
                                 child: Column(
                                    children:<Widget>[ 
                                      Row(
                                        children: <Widget>[
                                          Icon(Icons.local_activity, color: Colors.white,),
                                          Text(
                                          title, style: TextStyle(color:Colors.white,
                                            fontSize: 25.0, fontWeight: FontWeight.bold),
                                    ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(icon, color: Colors.white,),
                                          Text(
                                          subtitle, style: TextStyle(color:Colors.white,
                                            fontSize: 20.0, fontWeight: FontWeight.bold),
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
                        ),
                      ],
                    ),
                  ),
                );
  }
}

