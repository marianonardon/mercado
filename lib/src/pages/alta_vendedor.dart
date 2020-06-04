import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/comboMercado.dart';
import 'package:flutter_login_ui/src/pages/registrar_serv_serv.dart';
import 'package:google_fonts/google_fonts.dart';

class AltaVendedor extends StatefulWidget {
  @override
  _AltaVendedorState createState() => _AltaVendedorState();
}

class _AltaVendedorState extends State<AltaVendedor> {


  String comercio;
  String cuit;

  final comercioController = TextEditingController();
  final cuitController = TextEditingController();
  final naveController = TextEditingController();
  final puestoController = TextEditingController();
  final telefonoController = TextEditingController();
  final emailController = TextEditingController();

  String externalId;


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


    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de puesto',style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600))),
        backgroundColor: Color.fromRGBO(29, 233, 182, 1),

      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 1.0),
          child: Column(
          children: <Widget>[
            SizedBox(
            height: 30.0),
            _inputNombreComercio(),
             SizedBox(height: 10.0),
            _inputCuit(),
            SizedBox(height: 10.0),
            _inputNavePuesto(),
            SizedBox(height: 10.0),
            _inputTelefono(),
            SizedBox(height: 10.0),
            _inputEmail(),
            SizedBox(height: 10.0),
            ComboMercado(),
            SizedBox(height: 25.0),
              
            _botonConfirmar(),
            SizedBox(height: 10.0),

            ]
          )
        ),
      ),
      
    );
  }




  Widget _inputNombreComercio() {
    comercio = comercioController.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Nombre de tu puesto',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                fontWeight: FontWeight.normal, fontSize: 18.0))),
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
          height: 60.0,
          width: 370.0,
          child: TextField(
            controller: comercioController,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.store,
                size: 35.0,
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
      ],
    );
  }

    Widget _inputCuit() {
    cuit = cuitController.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Número de CUIT',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                fontWeight: FontWeight.normal, fontSize: 18.0))),
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
          height: 60.0,
          width: 370.0,
          child: TextField(
            controller: cuitController,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.perm_identity,
                size: 35.0,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Teléfono',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                fontWeight: FontWeight.normal, fontSize: 18.0))),
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
          height: 60.0,
          width: 370.0,
          child: TextField(
            controller: telefonoController,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                size: 35.0,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('E-mail',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                fontWeight: FontWeight.normal, fontSize: 18.0))),
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
          height: 60.0,
          width: 370.0,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.mail,
                size: 35.0,
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
    return Row(
      children: <Widget>[
        SizedBox(width:20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nave',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                    fontWeight: FontWeight.normal, fontSize: 18.0))),
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
              height: 60.0,
              width: 170.0,
              child: TextField(
                controller: naveController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.location_on,
                    size: 35.0,
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
            Text('Puesto',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                    fontWeight: FontWeight.normal, fontSize: 18.0))),
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
              height: 60.0,
              width: 170.0,
              child: TextField(
                controller: puestoController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.location_on,
                    size: 35.0,
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



  Widget _botonConfirmar() {
    return GestureDetector(
      onTap: (){
         PuestoCrear().puesto(comercioController.text, cuitController.text, comercioController.text, telefonoController.text,
                                            emailController.text ,puestoController.text, naveController.text, externalId);
         Navigator.pushNamed(context, 'vendedorProd');
                  },
                                          
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: Color.fromRGBO(29, 233, 182, 1),
          width: 380.0,
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: 
                Text('Registrar mi puesto', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                            fontSize: 20.0, fontWeight: FontWeight.w500,
                                      ))),
              )
            ],
          ),
        ),
      ),
    );
    
  }
}