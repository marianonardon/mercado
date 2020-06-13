/* import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';



class DatosUsuario extends StatefulWidget {
  @override
  _DatosUsuarioState createState() => _DatosUsuarioState();
}

class _DatosUsuarioState extends State<DatosUsuario> {
  @override
  String idUser;
  Widget build(BuildContext context) {

    return FutureBuilder<String>(
      future: _obtenerDatosUsuario(),
      builder: (context, idUser) {
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

  Future<String> _obtenerDatosUsuario() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
    String externalId2 = prefs.getString('usuarioId');
    setState(() {
      idUser = externalId2;
    }); 
    return externalId2;
  }


  } */