import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mercados_serv.dart';





class Puestos{

  List<Puesto> items = new List();

  Puestos();

  Puestos.fromJsonList(List<dynamic> jsonList) {

    if (jsonList == null) return;

    for (var item in jsonList) {
      final puesto = new Puesto.fromJson(item);
      items.add(puesto);
      
    }

  }



}



class Puesto {
  final String mercadoId;
  final String mercadoNombre;
  final String comercioId;
  final String comercioNombre;
  final String comercioTelefono;
  final String comercioCuit;
  final String comercioPuesto;
  final String comercioNumNave;
  final String comercioFechaAlta;
  final String comercioExternalId;
  final String comercioEmail;


  Puesto({this.mercadoId, this.mercadoNombre,this.comercioId, this.comercioNombre,this.comercioTelefono, this.comercioCuit,
          this.comercioPuesto,this.comercioNumNave,this.comercioFechaAlta,this.comercioExternalId,this.comercioEmail});

  factory Puesto.fromJson(Map<String, dynamic> json) {
    return Puesto(
      mercadoId: json['mercadoID'], 
      mercadoNombre: json['mercadoNombre'],
      comercioId: json['comercioID'], 
      comercioNombre: json['comercioNombre'], 
      comercioTelefono: json['comercioTelefono'], 
      comercioCuit: json['comercioCuit'], 
      comercioPuesto: json['comercioPuesto'], 
      comercioNumNave: json['comercioNumNave'], 
      comercioFechaAlta: json['comercioFechaAlta'], 
      comercioExternalId: json['comercioExternalID'], 
      comercioEmail: json['comercioEmail'], 

      
      
      
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

class PuestosListView extends StatelessWidget {
  PuestosListView(this.args);
  final ScreenArguments args;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Puesto>>(
      future: _fetchPuestos(args.userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if(snapshot.requireData.isEmpty){
            return Center(
              child: Container(
                child: Column(
                   children: <Widget>[
                     Image(
                       image: AssetImage('assets/img/Puesto.gif'),
                     ),
                    Text(
                    'Debes crear un puesto', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(98, 114, 123, 1),
                      fontSize: 24.0, fontWeight: FontWeight.w600,
                      ))                 
                    ),
                    Text(
                    'para comenzar!', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(98, 114, 123, 1),
                      fontSize: 24.0, fontWeight: FontWeight.w600,
                      ))                 
                    ),
                     

                  ]
                )
                
                ),
            );
          } else {
          List<Puesto> data = snapshot.data;
/*           _obtenerToken();
          _obtenerRubro(); */
          return _puestosListView(data,args.userId);
          }
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator(
          backgroundColor:  Color.fromRGBO(29, 233, 182, 1),
        ));
      },
    );
  }

  Future<List<Puesto>> _fetchPuestos(userId) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
    String externalId2 = prefs.getString('usuarioId');
    String userId2      = prefs.getString('usuarioId2');

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


    final responseToken = await http.post(urlQA, body: bodyTokenQA, headers: headers);
    final decodedData = json.decode(responseToken.body);
    final token = new Token.fromJsonMap(decodedData);
    String token2 = token.accessToken.toString();


    Map<String, String> headers2 = {
      "Authorization": "OAuth $token2"
      };

    final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/consultarComercio';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultarComercio';
    final userPuesto = '?comercioExternalID=$externalId2&comercioUserID=$userId2';
    final response = await http.get('$mercadosListAPIUrlQA$userPuesto', headers: headers2);

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final comercios = new Puestos.fromJsonList(decodedData['comercios']);
      return comercios.items;
      //List jsonResponse = json.decode(response.body);
      //return jsonResponse.map<dynamic>((mercado) => new Mercados.fromJsonList(mercado));
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _puestosListView(data,userId) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _crearLista(data[index].comercioNombre, data[index].mercadoNombre, data[index].comercioPuesto,
                        data[index].comercioNumNave,data[index].comercioId,data[index].mercadoId,
                        data[index].comercioCuit,data[index].comercioTelefono, data[index].comercioEmail,data[index].comercioPuesto,context);
        });
  }



  Widget _crearLista(String title, String subtitle, String numPuesto, String numNave,comercioId,mercadoId,comercioCuit,comercioTelefono,comercioMail,comercioPuesto,context) {
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
              onTap: () {Navigator.pushNamed(context, 'vendedorProd', arguments: PuestoArguments(args.userId, args.nombre, args.foto, mercadoId, comercioId,numNave,comercioPuesto,
              comercioCuit,comercioTelefono,comercioMail,title));},
            child:_crearTarjetas(title, subtitle, numPuesto, numNave,context))
          ],
        ),
      ),
    );
  }
  _crearTarjetas(title, subtitle, numPuesto, numNave,context) {
    MediaQueryData media = MediaQuery.of(context);
  return Stack(
    fit: StackFit.loose,
    children: <Widget> [
      ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image(
        height: media.size.height * 0.22 ,
        width: media.size.width * 0.93,
        fit: BoxFit.fill,
        image: AssetImage('assets/img/PuestoImg.png'),

       // placeholder: AssetImage('assets/img/loader.gif')),
      )),

      Positioned(
        bottom: 10,
        left: 0,
        right: 0,
        child: Container(
          color: Colors.black12,
          //borderRadius: BorderRadius.circular(15.0), 
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
                    Icon(Icons.location_on, color: Colors.white,),
                    Text(
                    subtitle, style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.white,
                      fontSize: 15.0, fontWeight: FontWeight.w600)),
              ),
                  ],
                ),
              Row(
                children: <Widget>[
                  SizedBox(width: 20.0),
                  Icon(Icons.location_on, color: Colors.white,),
                  Flexible(
                    child: Text(
                    'Puesto / Nombre: $numPuesto   Nave / Sector: $numNave', style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.white,
                      fontSize: 15.0, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              )
              ]
            ),
          
        ),
      ),
      SizedBox(height: 20.0),
      ]
  );

  }

}

class PuestoArguments {
  final String userId;
  final String nombre;
  final String foto;
  final String mercadoId;
  final String idComercio;
  final String numNave;
  final String comercioPuesto;
  final String comercioCuit;
  final String comercioTelefono;
  final String comercioMail;
  final String comercioNombre;


  PuestoArguments(this.userId, this.nombre,this.foto,this.mercadoId,this.idComercio,this.numNave,this.comercioPuesto,this.comercioCuit,this.comercioTelefono,this.comercioMail,this.comercioNombre);
}
