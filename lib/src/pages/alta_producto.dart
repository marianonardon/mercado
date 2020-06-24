import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/comboMercado.dart';
import 'package:flutter_login_ui/src/pages/comboMercado2.dart';
import 'package:flutter_login_ui/src/pages/combo_unidad.dart';
import 'package:flutter_login_ui/src/pages/registrar_serv_serv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'combo_categoria.dart';

class AltaProducto extends StatefulWidget {
  @override
  _AltaProductoState createState() => _AltaProductoState();
}

class _AltaProductoState extends State<AltaProducto> {


  String nombre;
  String descripcion;
  String categoria;
  String unidad;
  String stock;
  String precio;
  String cantidad;
  String precio2;
  String cantidad2;
  String precio3;
  String cantidad3;

  File foto;


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
  final formKey = GlobalKey<FormState>();



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
          child: Form(
            key: formKey,
            child: Column(
            children: <Widget>[
              SizedBox(
              height: 30.0),
              _inputNombreProducto(),
               SizedBox(height: 10.0),
              _inputFotoProducto(),
              SizedBox(height: 10.0),
              _inputDescripcionProducto(),
              SizedBox(height: 10.0),
              ComboCategoria(),
              SizedBox(height: 10.0),
              ComboUnidad(),
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
            ),
          )
        ),
      ),
      
    );
  }




  Widget _inputNombreProducto() {
    MediaQueryData media = MediaQuery.of(context);
    nombre = nombreController.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          width: media.size.width * 0.90,
          child: TextFormField(
            validator: (nombre) {if (nombre.isEmpty) {
                return 'El campo Nombre no puede estar vacío!';
                }else {
                  return null;
                }},
            controller: nombreController,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              fillColor: Color.fromRGBO(240, 241, 246, 1),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none
                ),
              labelText: 'Nombre de producto',
              labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                         fontWeight: FontWeight.bold, fontSize: 14.0),
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
    descripcion = descripcionController.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          width: media.size.width * 0.90,
          child: TextFormField(
            validator: (descripcion) {if (descripcion.isEmpty) {
                return 'El campo Descripción no puede estar vacío!';
                }else {
                  return null;
                }},
            controller: descripcionController,
            keyboardType: TextInputType.multiline,
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
                labelText: 'Descripción',
                labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                  fontWeight: FontWeight.bold, fontSize: 14.0),
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
    stock = stockController.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          width: media.size.width * 0.90,
          child: TextFormField(
            validator: (stock) {if (stock.isEmpty) {
                return 'El campo Stock no puede estar vacío!';
                }else {
                  return null;
                }},
            controller: stockController,
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
                labelText: 'Stock',
                labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                  fontWeight: FontWeight.bold, fontSize: 14.0),
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
    precio = precio1Controller.text;
    cantidad = cantidad1Controller.text;
    return Row(
      children: <Widget>[
        SizedBox(width:20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              width: media.size.width * 0.43,
              child: TextFormField(
                validator: (precio) {if (precio.isEmpty) {
                return 'El Precio no puede estar vacío!';
                }else {
                  return null;
                }},
                controller: precio1Controller,
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
                  labelText: 'Precio',
                  labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                  fontWeight: FontWeight.bold, fontSize: 14.0),
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
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              width: media.size.width * 0.43,
              child: TextFormField(
                validator: (cantidad) {if (cantidad.isEmpty) {
                return 'Cantidad no puede estar vacío!';
                }else {
                  return null;
                }},
                controller: cantidad1Controller,
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
                   labelText: 'Cantidad',
                   labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                  fontWeight: FontWeight.bold, fontSize: 14.0),
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
    precio2 = precio2Controller.text;
    cantidad2 = cantidad2Controller.text;
    return Row(
      children: <Widget>[
        SizedBox(width:20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              width: media.size.width * 0.43,
              child: TextFormField(
                validator: (precio2) {if (precio2.isEmpty) {
                return 'El Precio2 no puede estar vacío!';
                }else {
                  return null;
                }},
                controller: precio2Controller,
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
                  labelText: 'Precio 2',
                  labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                  fontWeight: FontWeight.bold, fontSize: 14.0),
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
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              width: media.size.width * 0.43,
              child: TextFormField(
                validator: (cantidad2) {if (cantidad2.isEmpty) {
                return 'Cantidad2 no puede estar vacío!';
                }else {
                  return null;
                }},
                controller: cantidad2Controller,
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
                   labelText: 'Cantidad 2',
                   labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                  fontWeight: FontWeight.bold, fontSize: 14.0),
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
    precio3 = precio3Controller.text;
    cantidad3 = cantidad3Controller.text;
    return Row(
      children: <Widget>[
        SizedBox(width:20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              width: media.size.width * 0.43,
              child: TextFormField(
                validator: (precio3) {if (precio3.isEmpty) {
                return 'El Precio3 no puede estar vacío!';
                }else {
                  return null;
                }},
                controller: precio3Controller,
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
                  labelText: 'Precio 3',
                  labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                  fontWeight: FontWeight.bold, fontSize: 14.0),
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
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.centerLeft,
              width: media.size.width * 0.43,
              child: TextFormField(
                validator: (cantidad3) {if (cantidad3.isEmpty) {
                return 'Cantidad 3 no puede estar vacío!';
                }else {
                  return null;
                }},
                controller: cantidad3Controller,
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
                   labelText: 'Cantidad 3',
                   labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                  fontWeight: FontWeight.bold, fontSize: 14.0),
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
      onTap: () {
        formKey.currentState.validate();
      },
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

  Widget _inputFotoProducto() {
  MediaQueryData media = MediaQuery.of(context);

    if (foto != null) {
      return  Stack(
         alignment: Alignment.topRight,
        children:<Widget>[Container(
          width: media.size.width * 0.90,
          height: media.size.height * 0.17,
          color: Colors.grey[100],
          child: Image(
            image: AssetImage(foto.path),
            fit: BoxFit.cover
          )
        ),
        GestureDetector(
          onTap: () { _seleccionarFoto();},
          child: Icon(Icons.edit, color: Colors.white, size: 30.0)
        )
        ]
      );

    }

    return GestureDetector(
      onTap: () {
        _seleccionarFoto();
      },
      child: Container(
        width: media.size.width * 0.90,
        height: media.size.height * 0.17,
        color: Colors.grey[100],
        child: Center(
          child: Icon(Icons.add_a_photo, size: 40,)
        ),
      )
    );



  }

   _seleccionarFoto() async {
     foto = await ImagePicker.pickImage(
      source: ImageSource.gallery
      
      
      );

      if (foto != null) {

      }

      setState(() {
      });


  }
}
