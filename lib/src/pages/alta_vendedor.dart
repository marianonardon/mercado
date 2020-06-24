import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/comboMercado.dart';
import 'package:flutter_login_ui/src/pages/comboMercado2.dart';
import 'package:flutter_login_ui/src/pages/registrar_serv_serv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../login_state.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de puesto',style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600))),
        backgroundColor: Color.fromRGBO(29, 233, 182, 1),

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
              SizedBox(height: 15.0),
              Text('Datos de contacto',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                fontWeight: FontWeight.bold, fontSize: 18.0))), 
              SizedBox(
              height: 10.0),
              _inputTelefono(),
              SizedBox(height: 10.0),
              _inputEmail(),
              SizedBox(height: 10.0),
              ComboMercado2(),
              SizedBox(height: 25.0),
                
              _botonConfirmar(context),
              SizedBox(height: 10.0),

              ]
            ),
          )
        ),
      ),

      drawer: Drawer(
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
      ),
      
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



  Widget _botonConfirmar(context) {
    MediaQueryData media = MediaQuery.of(context);
    return GestureDetector(
      onTap: (){

        if (formKey.currentState.validate()) {
            PuestoCrear().puesto(comercioController.text, cuitController.text, comercioController.text, telefonoController.text,
                                            emailController.text ,puestoController.text, naveController.text, externalId,context); 

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
