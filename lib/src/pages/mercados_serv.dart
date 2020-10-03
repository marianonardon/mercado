import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/providers/TokenDispositivo_provider.dart';
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
  final bool mercadoLunes;
  final String mercadoLunesHoraDesde;
  final String mercadoLunesHoraHasta;
  final bool mercadoMartes;
  final String mercadoMartesHoraDesde;
  final String mercadoMartesHoraHasta;
  final bool mercadoMiercoles;
  final String mercadoMiercolesHoraDesde;
  final String mercadoMiercolesHoraHasta;
  final bool mercadoJueves;
  final String mercadoJuevesHoraDesde;
  final String mercadoJuevesHoraHasta;
  final bool mercadoViernes;
  final String mercadoViernesHoraDesde;
  final String mercadoViernesHoraHasta;
  final bool mercadoSabado;
  final String mercadoSabadoHoraDesde;
  final String mercadoSabadoHoraHasta;
  final bool mercadoDomingo;
  final String mercadoDomingoHoraDesde;
  final String mercadoDomingoHoraHasta;


  Mercado({this.mercadoId, this.mercadoNombre, this.mercadoDireccion, this.mercadoTelefono, this.mercadoFechaAlta,
          this.mercadoHabilitado, this.mercadoImagen, this.mercadoLunes, this.mercadoLunesHoraDesde,this.mercadoLunesHoraHasta,
          this.mercadoMartes,this.mercadoMartesHoraDesde,this.mercadoMartesHoraHasta,this.mercadoMiercoles,this.mercadoMiercolesHoraDesde,
          this.mercadoMiercolesHoraHasta,this.mercadoJueves,this.mercadoJuevesHoraDesde,this.mercadoJuevesHoraHasta,this.mercadoViernes,
          this.mercadoViernesHoraDesde,this.mercadoViernesHoraHasta,this.mercadoSabado,this.mercadoSabadoHoraDesde,this.mercadoSabadoHoraHasta,
          this.mercadoDomingo,this.mercadoDomingoHoraDesde,this.mercadoDomingoHoraHasta});

  factory Mercado.fromJsonMap(Map<String, dynamic> parsedJson) {
    return Mercado(
      mercadoId: parsedJson['mercadoID'],
      mercadoNombre: parsedJson['mercadoNombre'],
      mercadoDireccion: parsedJson['mercadoDireccion'],
      mercadoTelefono: parsedJson['mercadoTelefono'],
      mercadoFechaAlta: parsedJson['mercadoFechaAlta'],
      mercadoHabilitado: parsedJson['mercadoHabilitado'],
      mercadoImagen: parsedJson['mercadoImagen'],
      mercadoLunes: parsedJson['mercadoLunes'],
      mercadoLunesHoraDesde: parsedJson['mercadoLunesHoraDesde'],
      mercadoLunesHoraHasta: parsedJson['mercadoLunesHoraHasta'],
      mercadoMartes: parsedJson['mercadoMartes'],
      mercadoMartesHoraDesde: parsedJson['mercadoMartesHoraDesde'],
      mercadoMartesHoraHasta: parsedJson['mercadoMartesHoraHasta'],
      mercadoMiercoles: parsedJson['mercadoMiercoles'],
      mercadoMiercolesHoraDesde: parsedJson['mercadoMiercolesHoraDesde'],
      mercadoMiercolesHoraHasta: parsedJson['mercadoMiercolesHoraHasta'],
      mercadoJueves: parsedJson['mercadoJueves'],
      mercadoJuevesHoraDesde: parsedJson['mercadoJuevesHoraDesde'],
      mercadoJuevesHoraHasta: parsedJson['mercadoJuevesHoraHasta'],
      mercadoViernes: parsedJson['mercadoViernes'],
      mercadoViernesHoraDesde: parsedJson['mercadoViernesHoraDesde'],
      mercadoViernesHoraHasta: parsedJson['mercadoViernesHoraHasta'],
      mercadoSabado: parsedJson['mercadoSabado'],
      mercadoSabadoHoraDesde: parsedJson['mercadoSabadoHoraDesde'],
      mercadoSabadoHoraHasta: parsedJson['mercadoSabadoHoraHasta'],
      mercadoDomingo: parsedJson['mercadoDomingo'],
      mercadoDomingoHoraDesde: parsedJson['mercadoDomingoHoraDesde'],
      mercadoDomingoHoraHasta: parsedJson['mercadoDomingoHoraHasta'],
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




    String url = "https://agilemarket.com.ar/oauth/access_token";
    String urlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/oauth/access_token';

    Map<String, String> bodyToken = {
      "client_id": "da0d4cd9919d4d80afecf1c56d954633",
      "client_secret": "be70f816716f402b8c02e53daec3e067",
      "scope": "FullControl",
      "username": "admin",
      "password": "wetiteam123",
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

    final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/consultarMercado/';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultarMercado/';

    final mercadosHabilitados = '?habilitado=1';
    final response = await http.get('$mercadosListAPIUrl', headers: headers2);

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final mercados = new Mercados.fromJsonList(decodedData['mercados']);
      await GuardarTokenDispositivo().guaradarTokenDispositivo();
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
          DateTime now = DateTime.now();
          int diaActual = now.weekday;
          String mercadoHoraInicio;
          String mercadoHoraFin;
          bool diaBool;
          switch(diaActual) {
            case 1:
              diaBool = data[index].mercadoLunes;
              if (diaBool == true) {
              
                mercadoHoraInicio = data[index].mercadoLunesHoraDesde;
                mercadoHoraFin = data[index].mercadoLunesHoraHasta;
              } else{
                mercadoHoraInicio = 'Cerrado';
                mercadoHoraFin = '';
              }
              break;
            case 2:

              diaBool = data[index].mercadoMartes;
              if (diaBool == true) {
              mercadoHoraInicio = data[index].mercadoMartesHoraDesde;
              mercadoHoraFin = data[index].mercadoMartesHoraHasta;
              } else{
                mercadoHoraInicio = 'Cerrado';
                mercadoHoraFin = '';
              }
              break;
            
            case 3:

              diaBool = data[index].mercadoMiercoles;
              if (diaBool == true) {
              mercadoHoraInicio = data[index].mercadoMiercolesHoraDesde;
              mercadoHoraFin = data[index].mercadoMiercolesHoraHasta;
              } else{
                mercadoHoraInicio = 'Cerrado';
                mercadoHoraFin = '';
              }
              break;

            case 4:

              diaBool = data[index].mercadoJueves;
              if (diaBool == true) {
              mercadoHoraInicio = data[index].mercadoJuevesHoraDesde;
              mercadoHoraFin = data[index].mercadoJuevesHoraHasta;
              } else{
                mercadoHoraInicio = 'Cerrado';
                mercadoHoraFin = '';
              }
              break;

            case 5:

              diaBool = data[index].mercadoViernes;
              if (diaBool == true) {
              mercadoHoraInicio = data[index].mercadoViernesHoraDesde;
              mercadoHoraFin = data[index].mercadoViernesHoraHasta;
              } else{
                mercadoHoraInicio = 'Cerrado';
                mercadoHoraFin = '';
              }
              break;

            case 6:

              diaBool = data[index].mercadoSabado;
              if (diaBool == true) {
              mercadoHoraInicio = data[index].mercadoSabadoHoraDesde;
              mercadoHoraFin = data[index].mercadoSabadoHoraHasta;
              } else{
                mercadoHoraInicio = 'Cerrado';
                mercadoHoraFin = '';
              }
              break;

            case 7:

              diaBool = data[index].mercadoDomingo;
              if (diaBool == true) {
              mercadoHoraInicio = data[index].mercadoDomingoHoraDesde;
              mercadoHoraFin = data[index].mercadoDomingoHoraHasta;
              } else{
                mercadoHoraInicio = 'Cerrado';
                mercadoHoraFin = '';
              }
              break;

          }
          
          return _crearLista(data[index].mercadoNombre, data[index].mercadoDireccion, Icons.location_on,
                        data[index].mercadoImagen,idUser,data[index].mercadoId,mercadoHoraInicio, mercadoHoraFin,context);
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
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
                prefs.setString('horaMercado', '$mercadoHoraInicio');
                prefs.setString('horaMercadoFin', '$mercadoHoraFin');
                Navigator.pushNamed(context, 'categorias', arguments: ScreenArguments(idUser, nombreUsuario, fotoUsuario,mercadoId));},
            child:_crearTarjetas(title, subtitle, icon, imagen, mercadoHoraInicio,mercadoHoraFin,context))
          ],
        ),
      ),
    );
  }

  _crearTarjetas(title, subtitle, icon, imagen, horaInicio,horaFin,context) {
    MediaQueryData media = MediaQuery.of(context);
    String hourFin;
    String minFin;
    String hourIni;
    String minIni;
    String mercadoHorario;


    if (horaFin != '') {
    
    DateTime horarioFin = DateTime.parse(horaFin);
     hourFin = horarioFin.hour.toString();
     minFin  = horarioFin.minute.toString();
    if (int.parse(minFin) < 10) {
      minFin = '0$minFin';
    }
    } else{
       hourFin = '';
       minFin  = '';
    }

    if (horaInicio != 'Cerrado') {
    DateTime horarioInicio = DateTime.parse(horaInicio);
     hourIni = horarioInicio.hour.toString();
     minIni  = horarioInicio.minute.toString();
    if (int.parse(minIni) < 10) {
      minIni = '0$minIni';
    }
    mercadoHorario = 'De $hourIni:$minIni a $hourFin:$minFin';
    } else {
       hourIni = 'Cerrado';
       minIni  = '';
       mercadoHorario = 'Cerrado';
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
                    Flexible(
                      child: Text(
                      title, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.white,
                        fontSize: 19.0, fontWeight: FontWeight.w600,
                        ))
                      
              ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(width: 20.0),
                    Icon(icon, color: Colors.white,),

                    SizedBox(width: 5.0),
                    Flexible(
                                          child: Text(
                      subtitle, style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.white,
                        fontSize: 14.0, fontWeight: FontWeight.w600)),
              ),
                    ),
                  ]
                ),
              Row(
                  children: <Widget>[
                    SizedBox(width: 20.0),
                    Icon(Icons.access_time, color: Colors.white,size: 20.0,),
                    SizedBox(width: 5.0),
                    Flexible(
                                          child: Text(
                      'Hoy: $mercadoHorario', style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.white,
                        fontSize: 14.0, fontWeight: FontWeight.w600)),
              ),
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