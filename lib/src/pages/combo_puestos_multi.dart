import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';



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
  Map<String, dynamic> toJson() => {
        "mercadoID": mercadoId,
        "mercadoNombre": mercadoNombre,
        "comercioID": comercioId,
        "comercioNombre": comercioNombre,
        "comercioTelefono": comercioTelefono,
        "comercioCuit": comercioCuit,
        "comercioPuesto": comercioPuesto,
        "comercioNumNave": comercioNumNave,
        "comercioFechaAlta": comercioFechaAlta,
        "comercioExternalID": comercioExternalId,
        "comercioEmail": comercioEmail,
      };
}




class ComboPuesto2 extends StatefulWidget {
  ComboPuesto2(this.mercadoId);
  final String mercadoId;
  @override
  _ComboPuesto2 createState() => _ComboPuesto2(mercadoId);
}

class _ComboPuesto2 extends State<ComboPuesto2> {
  _ComboPuesto2(this.mercadoId);
  final String mercadoId;
  String _mySelection;
  List _myActivities;
  String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();
  String puesto2;
  List<dynamic> puestoLista;
  List<dynamic> value2;


  List<Puesto> data = List(); 
  //edited line
  List data2 = List(); 

  Future<String> _fetchPuestos() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String puestosId = prefs.getString('idPuesto');
    if (puestosId == null){
      puestosId = '';
    }
     puesto2 = '[$puestosId]';
     puestoLista = json.decode(puesto2);



     String url = "https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/oauth/access_token";

    Map<String, String> bodyToken = {
      "client_id": "32936ed0b05f48859057b6a2dd5aee6f",
      "client_secret": "915b06d26cdf44f7b832c66fe6e58743",
      "scope": "FullControl",
      "username": "admin",
      "password": "admin123",
    };

    Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded"
    };

        String urlProd = "https://agilemarket.com.ar/oauth/access_token";

    Map<String, String> bodyTokenProd = {
      "client_id": "da0d4cd9919d4d80afecf1c56d954633",
      "client_secret": "be70f816716f402b8c02e53daec3e067",
      "scope": "FullControl",
      "username": "admin",
      "password": "wetiteam123",
    };


    final responseToken = await http.post(urlProd, body: bodyTokenProd, headers: headers);
    final decodedData = json.decode(responseToken.body);
    final token = new Token.fromJsonMap(decodedData);
    String token2 = token.accessToken.toString();


    Map<String, String> headers2 = {
      "Authorization": "OAuth $token2"
      };

    final mercadosListAPIUrl = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultarComercio?mercadoID=$mercadoId';
    final mercadosListAPIUrlProd = 'https://agilemarket.com.ar/rest/consultarComercio?mercadoID=$mercadoId';
    final response = await http.get('$mercadosListAPIUrlProd', headers: headers2);

    if (response.statusCode == 200) {
      var resBody = json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //prefs.setString('idPuesto', '' );
       final decodedData = json.decode(response.body);
      final comercios = new Puestos.fromJsonList(decodedData['comercios']);

      setState(() {
        data = comercios.items;
      });
     
    } else {
      throw Exception('Failed to load jobs from API');
    }


  }

  @override
  Future<void> initState() {
    super.initState();
    this._fetchPuestos();
    
    
    _myActivities = puestoLista;
    _myActivitiesResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    var data3 = data.map((data) => data.toJson()).toList();
    if(data != null) {
      if(data.isNotEmpty){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
         Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                child: MultiSelectFormField(
                  autovalidate: false,
                  
                  title: Text('Puestos'),
                  
                  dataSource: data3,
                  //data.map((data){}).toList(),
                  textField: 'comercioNombre',
                  valueField: 'comercioID'.toString(), 
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCELAR',
                  // required: true,
                  hintWidget: Text('Puede seleccionar uno o más puestos'),
                  initialValue: puestoLista,
                  onSaved: (value) async {
                    value2 = value;
                    String valor = jsonEncode(value);
                    valor = valor.replaceAll('[', '').replaceAll(']', '');
                    if (value == null){
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString('idPuesto', '' );
                      return;
                    } 
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    
                    prefs.setString('idPuesto', valor );
                    setState(() {
                      _myActivities = value;
                    });
                  },
                  
                ),
              ),
              
            ],
          ),
        ),
      ),

      ]
      );}else {
        return Container();
      }
      
      } else{
        return Container();
      }
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