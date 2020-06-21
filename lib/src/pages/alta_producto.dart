import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/comboMercado.dart';
import 'package:flutter_login_ui/src/pages/comboMercado2.dart';
import 'package:flutter_login_ui/src/pages/registrar_serv_serv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'combo_categoria.dart';

class AltaProducto extends StatefulWidget {
  @override
  _AltaProductoState createState() => _AltaProductoState();
}

class _AltaProductoState extends State<AltaProducto> {


  String comercio;
  String cuit;

  final nombreController = TextEditingController();
  final descripcionController = TextEditingController();
  final categoriaController = TextEditingController();
  final unidadController = TextEditingController();
  final stockController = TextEditingController();
  final precio1Controller = TextEditingController();
  final cantidad1Controller = TextEditingController();
  final precio2Controller = TextEditingController();
  final cantidad2Controller = TextEditingController();
  final precio3Controller = TextEditingController();
  final cantidad3Controller = TextEditingController();
  String externalId;
  final _formKey = GlobalKey<FormState>();



  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    nombreController.dispose();
    descripcionController.dispose();
    categoriaController.dispose();
    unidadController.dispose();
    stockController.dispose();
    precio1Controller.dispose();
    cantidad1Controller.dispose();
    precio2Controller.dispose();
    cantidad2Controller.dispose();
    precio3Controller.dispose();
    cantidad3Controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar producto',style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600))),
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
            _inputNombreProducto(),
             SizedBox(height: 10.0),
            _inputDescripcionProducto(),
            SizedBox(height: 10.0),
            ComboCategoria(),
            SizedBox(height: 10.0),
            ComboMercado(),
            SizedBox(height: 10.0),
            _inputCalidad(context),
            SizedBox(height: 10.0),
            _inputStock(),
             SizedBox(height: 10.0),
            _inputPrecioCantidad1(),
            SizedBox(height: 10.0),
            _inputPrecioCantidad2(),
            SizedBox(height: 10.0),
            _inputPrecioCantidad3(),

            
            SizedBox(height: 25.0),
              
            _botonConfirmar(context),
            SizedBox(height: 10.0),

            ]
          )
        ),
      ),
      
    );
  }




  Widget _inputNombreProducto() {
    MediaQueryData media = MediaQuery.of(context);
    comercio = nombreController.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Nombre de producto',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                fontWeight: FontWeight.normal, fontSize: 12.0))),
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
          child: TextFormField(
            validator: (nombreController) {if (nombreController.isEmpty) {
                          return 'El campo Email no puede estar vacío!';
                          }},
            controller: nombreController,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0, 5.0),
              hintText: 'ej: Frutillas',
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


    Widget _inputDescripcionProducto() {
    MediaQueryData media = MediaQuery.of(context);
    comercio = descripcionController.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Descripción',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                fontWeight: FontWeight.normal, fontSize: 12.0))),
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
          child: TextFormField(
            validator: (descripcionController) {if (descripcionController.isEmpty) {
                          return 'El campo Email no puede estar vacío!';
                          }},
            controller: descripcionController,
            keyboardType: TextInputType.multiline,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0, 5.0),
            ),
          ),
        ),
      ],
    );
  }

    Widget _inputCalidad(context) {
    MediaQueryData media = MediaQuery.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Calidad',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                fontWeight: FontWeight.normal, fontSize: 12.0))),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: media.size.height * 0.06,
          width: media.size.width * 0.90,
          child: RatingBar(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            )
          ),
      ],
    );
  }


    Widget _inputStock() {
    MediaQueryData media = MediaQuery.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Stock',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                fontWeight: FontWeight.normal, fontSize: 12.0))),
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
          child: TextField(
            controller: stockController,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0, 5.0),
              hintText: 'ej: 100',
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


  Widget _inputPrecioCantidad1() { 
    MediaQueryData media = MediaQuery.of(context);
    return Row(
      children: <Widget>[
        SizedBox(width:20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Precio',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                    fontWeight: FontWeight.normal, fontSize: 12.0))),
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
              width: media.size.width * 0.43,
              child: TextField(
                controller: precio1Controller,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 5.0),
                  prefixIcon: Icon(
                    Icons.attach_money,
                    size: 25.0,
                    //color: Colors.black,
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
            Text('Cantidad',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                    fontWeight: FontWeight.normal, fontSize: 12.0))),
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
              width: media.size.width * 0.43,
              child: TextField(
                controller: cantidad1Controller,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0, 5.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

    Widget _inputPrecioCantidad2() { 
    MediaQueryData media = MediaQuery.of(context);
    return Row(
      children: <Widget>[
        SizedBox(width:20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Precio 2',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                    fontWeight: FontWeight.normal, fontSize: 12.0))),
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
              width: media.size.width * 0.43,
              child: TextField(
                controller: precio2Controller,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 5.0),
                  prefixIcon: Icon(
                    Icons.attach_money,
                    size: 25.0,
                    //color: Colors.black,
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
            Text('Cantidad 2',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                    fontWeight: FontWeight.normal, fontSize: 12.0))),
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
              width: media.size.width * 0.43,
              child: TextField(
                controller: cantidad2Controller,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0, 5.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

    Widget _inputPrecioCantidad3() { 
    MediaQueryData media = MediaQuery.of(context);
    return Row(
      children: <Widget>[
        SizedBox(width:20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Precio 3',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                    fontWeight: FontWeight.normal, fontSize: 12.0))),
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
              width: media.size.width * 0.43,
              child: TextField(
                controller: precio3Controller,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 5.0),
                  prefixIcon: Icon(
                    Icons.attach_money,
                    size: 25.0,
                    //color: Colors.black,
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
            Text('Cantidad 3',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                    fontWeight: FontWeight.normal, fontSize: 12.0))),
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
              width: media.size.width * 0.43,
              child: TextField(
                controller: cantidad3Controller,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0, 5.0),
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
      onTap: null,
       /* (){
         PuestoCrear().puesto(comercioController.text, cuitController.text, comercioController.text, telefonoController.text,
                                            emailController.text ,puestoController.text, naveController.text, externalId,context);
        // Navigator.pushNamed(context, 'vendedorProd');
                  }, */
                                          
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
                Text('Agregar producto', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
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
