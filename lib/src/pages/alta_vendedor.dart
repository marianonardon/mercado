import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/comboMercado.dart';
import 'package:flutter_login_ui/src/pages/comboMercado2.dart';
import 'package:flutter_login_ui/src/pages/registrar_serv_serv.dart';
import 'package:flutter_login_ui/src/pages/mercados_serv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../login_state.dart';


String mercadoId;




class AltaVendedor extends StatefulWidget {
  @override
  _AltaVendedorState createState() => _AltaVendedorState();
}

class _AltaVendedorState extends State<AltaVendedor> {


  String comercio;
  String cuit;
  String telefono;
  String mail;
  String nave;
  String puesto;

  final comercioController = TextEditingController();
  final cuitController = TextEditingController();
  final naveController = TextEditingController();
  final puestoController = TextEditingController();
  final telefonoController = TextEditingController();
  final emailController = TextEditingController();

  String externalId;
  String mercadoId;
  final formKey = GlobalKey<FormState>();



  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    comercioController.dispose();
    cuitController.dispose();
    naveController.dispose();
    puestoController.dispose();
    telefonoController.dispose();
    emailController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de puesto',style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600))),
        backgroundColor: Color.fromRGBO(29, 233, 182, 1),
        iconTheme: IconThemeData(color: Colors.black),

      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 15.0),
          child: Form(
            key: formKey,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
              height: 30.0),
              Text('Mi puesto',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                fontWeight: FontWeight.bold, fontSize: 18.0))), 
              SizedBox(
              height: 10.0),
              _inputNombreComercio(),
               SizedBox(height: 10.0),
              _inputCuit(context),
              SizedBox(height: 10.0),
              _inputNavePuesto(),
              SizedBox(height: 10.0),
              ComboMercado3(),
              SizedBox(height: 15.0),
              Text('Datos de contacto',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                fontWeight: FontWeight.bold, fontSize: 18.0))), 
              SizedBox(
              height: 10.0),
              _inputTelefono(),
              SizedBox(height: 10.0),
              _inputEmail(),
              SizedBox(height: 25.0),
                
              _botonConfirmar(context,mercadoId,args.nombre,args.userId,args.foto),
              SizedBox(height: 10.0),

              ]
            ),
          )
        ),
      ),

      /* drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Fernando' , style: TextStyle(color:Colors.white,)),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            ListTile(
              title: Row(
                children: [
                Icon(Icons.home),
                Text('Home'),]),

              onTap: () {Navigator.pushNamed(context, 'mercado');},
            ),
            ListTile(
              title: Row(
                children: [
                Icon(Icons.search),
                Text('Buscar productos'),]),

              onTap: () {Navigator.pushNamed(context, 'productos');},
            ),
            /* ListTile(
              title: Row(
                children: [
                Icon(Icons.local_grocery_store),
                Text('Carrito'),]),

              onTap: () {Navigator.pushNamed(context, 'carrito');},
            ), */

            ListTile(
              title: Row(
                children: [
                Icon(Icons.store),
                Text('Ir perfil vendedor'),]),

              onTap: () {Navigator.pushNamed(context, 'altaVendedor');},
            ),
             ListTile(
              title: Row(
                children: [
                Icon(Icons.exit_to_app),
                Text('Logout'),]),

              onTap: () {Provider.of<LoginState>(context).logout();
                         Navigator.pushNamed(context, '/');},
            ),
          ],
        ),
      ), */
      
    );
  }




  Widget _inputNombreComercio() {
    MediaQueryData media = MediaQuery.of(context);
    comercio = comercioController.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
/*         Text('Nombre de tu puesto',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                fontWeight: FontWeight.normal, fontSize: 12.0))), */
        SizedBox(height: 10.0),
/*         Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
                color: Color.fromRGBO(240, 241, 246, 1),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
          height: media.size.height * 0.06,
          width: media.size.width * 0.90,
          child:  */
          Container(
            alignment: Alignment.centerLeft,
            width: media.size.width * 0.90,
            child: TextFormField(
              validator: (comercio) {if (comercio.isEmpty) {
                return 'El campo Puesto no puede estar vacío!';
                }else {
                  return null;
                }},
              controller: comercioController,
              keyboardType: TextInputType.text,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(240, 241, 246, 1),
                filled: true,
                border: 
                
                new OutlineInputBorder(

                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none),
           /*       borderSide: new BorderSide(
                    color: Colors.greenAccent,
                    width: 1.0,
                  ), */
                labelText: 'Nombre de tu puesto',
                labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                  fontWeight: FontWeight.bold, fontSize: 14.0),
                contentPadding: EdgeInsets.only(top: 5.0),
                prefixIcon: Icon(
                  Icons.store,
                  size: 25.0,
                  //color: Colors.black,
                ),
                hintText: 'ej: Lo de Juan',
                hintStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                          ),
              ),
            ),
          ),
/*         ), */
      ],
    );
  }

    Widget _inputCuit(context) {
    MediaQueryData media = MediaQuery.of(context);
    cuit = cuitController.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          width: media.size.width * 0.90,
          child: TextFormField(
            validator: (cuit) {if (cuit.isEmpty) {
              return 'El campo Cuit no puede estar vacío!';
              }else {
                return null;
              }},
            controller: cuitController,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            maxLengthEnforced: true,
            maxLength: 11,
            decoration: InputDecoration(
              fillColor: Color.fromRGBO(240, 241, 246, 1),
                filled: true,
                border: 
                
                new OutlineInputBorder(

                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none),
              contentPadding: EdgeInsets.only(top: 5.0),
              labelText: 'Número de CUIT',
              labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                  fontWeight: FontWeight.bold, fontSize: 14.0),
              prefixIcon: Icon(
                Icons.perm_identity,
                size: 25.0,
                //color: Colors.black,
              ),
              hintText: 'ej: 20386325462',
              hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                        ),
            ),
          ),
        ),
      ],
    );
  }


    Widget _inputTelefono() {
    MediaQueryData media = MediaQuery.of(context);
    telefono = telefonoController.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          width: media.size.width * 0.90,
          child: TextFormField(
            validator: (telefono) {if (telefono.isEmpty) {
                return 'El campo Teléfono no puede estar vacío!';
                }else {
                  return null;
                }},
            controller: telefonoController,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            maxLength: 10,
            maxLengthEnforced: true,
            decoration: InputDecoration(
              fillColor: Color.fromRGBO(240, 241, 246, 1),
                filled: true,
                border: 
                
                new OutlineInputBorder(

                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none),
           /*       borderSide: new BorderSide(
                    color: Colors.greenAccent,
                    width: 1.0,
                  ), */
                labelText: 'Teléfono (sin 0 y sin 15)',
                labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                  fontWeight: FontWeight.bold, fontSize: 14.0),
              contentPadding: EdgeInsets.only(top: 5.0),
              prefixIcon: Icon(
                Icons.phone,
                size: 25.0,
                //color: Colors.black,
              ),
              hintText: 'ej: 3512654599',
              hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                        ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _inputEmail() {
    MediaQueryData media = MediaQuery.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          width: media.size.width * 0.90,
          child: TextFormField(
            validator: (mail) {if (mail.isEmpty) {
                return 'El campo E-mail no puede estar vacío!';
                }else {
                  return null;
                }},
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              fillColor: Color.fromRGBO(240, 241, 246, 1),
                filled: true,
                border: 
                
                new OutlineInputBorder(

                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none),
           /*       borderSide: new BorderSide(
                    color: Colors.greenAccent,
                    width: 1.0,
                  ), */
                labelText: 'E-mail',
                labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                  fontWeight: FontWeight.bold, fontSize: 14.0),
              contentPadding: EdgeInsets.only(top: 5.0),
              prefixIcon: Icon(
                Icons.mail,
                size: 25.0,
                //color: Colors.black,
              ),
              hintText: 'ej: mercado@mercado.com',
              hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                        ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _inputNavePuesto() { 
    MediaQueryData media = MediaQuery.of(context);
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              width: media.size.width * 0.43,
              child: TextFormField(
                validator: (nave) {if (nave.isEmpty) {
                return 'Nave no puede estar vacío!';
                }else {
                  return null;
                }},
                controller: naveController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(240, 241, 246, 1),
                filled: true,
                border: 
                
                new OutlineInputBorder(

                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none),
           /*       borderSide: new BorderSide(
                    color: Colors.greenAccent,
                    width: 1.0,
                  ), */
                labelText: 'Nave',
                labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6),
                fontWeight: FontWeight.bold, fontSize: 14.0),
                  contentPadding: EdgeInsets.only(top: 5.0),
                  prefixIcon: Icon(
                    Icons.location_on,
                    size: 25.0,
                    //color: Colors.black,
                  ),
                  hintText: 'ej: 109',
                  hintStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                            ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width:20.0),
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              width: media.size.width * 0.43,
              child: TextFormField(
                validator: (puesto) {if (puesto.isEmpty) {
                return 'Puesto no puede estar vacío!';
                }else {
                  return null;
                }},
                controller: puestoController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(240, 241, 246, 1),
                filled: true,
                border: 
                
                new OutlineInputBorder(

                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none),
           /*       borderSide: new BorderSide(
                    color: Colors.greenAccent,
                    width: 1.0,
                  ), */
                labelText: 'Puesto',
                labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                  fontWeight: FontWeight.bold, fontSize: 14.0),
                  contentPadding: EdgeInsets.only(top: 5.0),
                  prefixIcon: Icon(
                    Icons.location_on,
                    size: 25.0,
                    //color: Colors.black,
                  ),
                  hintText: 'ej: 45',
                  hintStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                            ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }



  Widget _botonConfirmar(context,mercadoId,nombreUser,userId,fotoUser) {
    MediaQueryData media = MediaQuery.of(context);
    return GestureDetector(
      onTap: () async {

        SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
       String mercadoId = prefs.getString('idMercado');
        

        if (formKey.currentState.validate()) {

          showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(child: Text('Cargando puesto')),
            content:  SizedBox(
                      width: media.size.width * 0.005,
                      height: media.size.height * 0.05,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3.0,
                          valueColor : AlwaysStoppedAnimation(Color.fromRGBO(29, 233, 182, 1),),
                        ),
                      ),
                  ),
            backgroundColor: Colors.white

        ),
        barrierDismissible: false,
          ).then((_) => setState((){})); 

            PuestoCrear().puesto(comercioController.text, cuitController.text, comercioController.text, telefonoController.text,
                                            emailController.text ,puestoController.text, naveController.text, externalId,mercadoId,userId,nombreUser,fotoUser,context); 

        }
/*         Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: media.size.width * 0.05,
                        height: media.size.height * 0.03,
                        margin: EdgeInsets.all(5),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor : AlwaysStoppedAnimation(Color.fromRGBO(29, 233, 182, 1),),
                        ),
                      ),
                    ),
                  ],
              );
         PuestoCrear().puesto(comercioController.text, cuitController.text, comercioController.text, telefonoController.text,
                                            emailController.text ,puestoController.text, naveController.text, externalId,context); */
        // Navigator.pushNamed(context, 'vendedorProd');
                  },
                                          
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: Color.fromRGBO(29, 233, 182, 1),
          height: media.size.height * 0.07,
          width: media.size.width * 0.90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: 
                Text('Registrar mi puesto', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                            fontSize: 14.0, fontWeight: FontWeight.w500,
                                      ))),
              )
            ],
          ),
        ),
      ),
    );
    
  }
}

class ComboMercado3 extends StatefulWidget {
  @override
  _ComboMercado3 createState() => _ComboMercado3();
}

class _ComboMercado3 extends State<ComboMercado3> {
  String _mySelection;


  List data = List(); //edited line

  Future<String> _fetchMercados() async {

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
    final response = await http.get('$mercadosListAPIUrlQA$mercadosHabilitados', headers: headers2);


    if (response.statusCode == 200) {
      var resBody = json.decode(response.body);

      setState(() {
        data = resBody['mercados'];
      });
      return 'Success';
      //List jsonResponse = json.decode(response.body);
      //return jsonResponse.map<dynamic>((mercado) => new Mercados.fromJsonList(mercado));
    } else {
      throw Exception('Failed to load jobs from API');
    }

  }

  @override
  void initState() {
    super.initState();
    this._fetchMercados();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    mercadoId = _mySelection;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 18.0,),
            Text('Mercado',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
            fontWeight: FontWeight.normal, fontSize: 12.0))),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color.fromRGBO(240, 241, 246, 1),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: media.size.height * 0.06,
          width: media.size.width * 0.90,
          child:  DropdownButton(
            hint: Text('Seleccione mercado'),
            isExpanded: true,
            items: data.map((item) {
            return new DropdownMenuItem(
              child: new Text(item['mercadoNombre']),
              value: item['mercadoID'].toString(),
            );
            }).toList(),
           onChanged: (newVal) async {
               SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('idMercado', newVal );
            setState(()  {
              _mySelection = newVal;


            });
          },
          value: _mySelection,
        ),
        )
      ]
      );
  }

  retornarMercado(){
    mercadoId = _mySelection;
    return mercadoId;
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

