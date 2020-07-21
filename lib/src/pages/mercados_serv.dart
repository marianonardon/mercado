import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';





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
  final String mercadoHoraInicio;
  final String mercadoHoraFin;


  Mercado({this.mercadoId, this.mercadoNombre, this.mercadoDireccion, this.mercadoTelefono, this.mercadoFechaAlta,
          this.mercadoHabilitado, this.mercadoImagen, this.mercadoHoraInicio,this.mercadoHoraFin});

  factory Mercado.fromJsonMap(Map<String, dynamic> parsedJson) {
    return Mercado(
      mercadoId: parsedJson['mercadoID'],
      mercadoNombre: parsedJson['mercadoNombre'],
      mercadoDireccion: parsedJson['mercadoDireccion'],
      mercadoTelefono: parsedJson['mercadoTelefono'],
      mercadoFechaAlta: parsedJson['mercadoFechaAlta'],
      mercadoHabilitado: parsedJson['mercadoHabilitado'],
      mercadoImagen: parsedJson['mercadoImagen'],
      mercadoHoraInicio: parsedJson['mercadoHoraInicio'],
      mercadoHoraFin: parsedJson['mercadoHoraFin'],
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

class MercadosListView extends StatefulWidget {
  @override
  _MercadosListViewState createState() => _MercadosListViewState();
}

class _MercadosListViewState extends State<MercadosListView> {
  @override
  String idUser,nombreUsuario,fotoUsuario;
  Widget build(BuildContext context) {
    return FutureBuilder<List<Mercado>>(
      future: _fetchMercados(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Mercado> data = snapshot.data;
/*           _obtenerToken();
          _obtenerRubro(); */
          return _mercadosListView(data,idUser);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator(
          backgroundColor:  Color.fromRGBO(29, 233, 182, 1),
        ));
      },
    );
  }

  Future<List<Mercado>> _fetchMercados() async {

    if (idUser == null) {    
      SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
      String externalId2 = prefs.getString('usuarioId');
      String nombreUser = prefs.getString('nombre');
      String fotoUser = prefs.getString('fotoUser'); 
      setState(() {
        idUser = externalId2;
        nombreUsuario = nombreUser;
        fotoUsuario = fotoUser;
      }); 
    }




    String url = "https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/oauth/access_token";
    String urlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/oauth/access_token';

    Map<String, String> bodyToken = {
      "client_id": "d6471aff30e64770bd9da53caccc4cc4",
      "client_secret": "7dae40626f4f45378b22bb47aa750024",
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


    final responseToken = await http.post(urlQA, body: bodyTokenQA, headers: headers);
    final decodedData = json.decode(responseToken.body);
    final token = new Token.fromJsonMap(decodedData);
    String token2 = token.accessToken.toString();


    Map<String, String> headers2 = {
      "Authorization": "OAuth $token2"
      };

    final mercadosListAPIUrl = 'https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/rest/consultarMercado/';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultarMercado/';

    final mercadosHabilitados = '?habilitado=1';
    final response = await http.get('$mercadosListAPIUrlQA', headers: headers2);

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

  ListView _mercadosListView(data,idUser) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _crearLista(data[index].mercadoNombre, data[index].mercadoDireccion, Icons.location_on,
                        data[index].mercadoImagen,idUser,data[index].mercadoId,data[index].mercadoHoraInicio, data[index].mercadoHoraFin,context);
        });
  }

  Widget _crearLista(String title, String subtitle, IconData icon, String imagen,String idUser, String mercadoId,String mercadoHoraInicio,String mercadoHoraFin, context) {
    
    MediaQueryData media = MediaQuery.of(context);
    return  ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        
          width: media.size.width * 0.95,
      //   height: 500.0, */
        child: Column(
          children: <Widget>[
          //  _crearTitulo(),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {Navigator.pushNamed(context, 'categorias', arguments: ScreenArguments(idUser, nombreUsuario, fotoUsuario,mercadoId));},
            child:_crearTarjetas(title, subtitle, icon, imagen, mercadoHoraInicio,mercadoHoraFin,context))
          ],
        ),
      ),
    );
  }

  _crearTarjetas(title, subtitle, icon, imagen, horaInicio,horaFin,context) {
    MediaQueryData media = MediaQuery.of(context);
    DateTime horarioFin = DateTime.parse(horaFin);
    String hourFin = horarioFin.hour.toString();
    String minFin  = horarioFin.minute.toString();
    if (int.parse(minFin) < 10) {
      minFin = '0$minFin';
    }

    DateTime horarioInicio = DateTime.parse(horaInicio);
    String hourIni = horarioInicio.hour.toString();
    String minIni  = horarioInicio.minute.toString();
    if (int.parse(minIni) < 10) {
      minIni = '0$minIni';
    }
    
  return Stack(
    fit: StackFit.loose,
    children: <Widget> [
      ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image(
        height: media.size.height * 0.23 ,
        width: media.size.width * 0.93,
        fit: BoxFit.fill,
        image: NetworkImage(imagen),

       // placeholder: AssetImage('assets/img/loader.gif')),
      )),

      Positioned(
        bottom: 10,
        left: 0,
        right: 0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0), 
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.black45, Colors.black26],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)
            ),
            child: Column(
              children:<Widget>[ 
                Row(
                  children: <Widget>[
                    SizedBox(width: 20.0),
                    Text(
                    title, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.white,
                      fontSize: 21.0, fontWeight: FontWeight.w600,
                      ))
                    
              ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(width: 20.0),
                    Icon(icon, color: Colors.white,),

                    SizedBox(width: 5.0),
                    Text(
                    subtitle, style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.white,
                      fontSize: 15.0, fontWeight: FontWeight.w600)),
              ),
                  ]
                ),
              Row(
                  children: <Widget>[
                    SizedBox(width: 20.0),
                    Icon(Icons.access_time, color: Colors.white,size: 20.0,),
                    SizedBox(width: 5.0),
                    Text(
                    'De $hourIni:$minIni a $hourFin:$minFin', style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.white,
                      fontSize: 15.0, fontWeight: FontWeight.w600)),
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

  Future<String> _obtenerRubro() async {

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

class ScreenArguments {
  final String userId;
  final String nombre;
  final String foto;
  final String mercadoId;


  ScreenArguments(this.userId, this.nombre,this.foto,this.mercadoId);
}