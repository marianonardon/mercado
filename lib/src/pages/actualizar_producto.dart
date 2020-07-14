
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/comboMercado.dart';
import 'package:flutter_login_ui/src/pages/comboMercado2.dart';
import 'package:flutter_login_ui/src/pages/combo_unidad.dart';
import 'package:flutter_login_ui/src/pages/alta_producto_serv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_login_ui/src/pages/actualizar_producto_serv.dart';
import 'package:flutter_login_ui/src/pages/vendedor_prod_serv.dart';

import 'combo_categoria.dart';

class ActualizarProducto extends StatefulWidget {
  @override
  _ActualizarProductoState createState() => _ActualizarProductoState();
}

class _ActualizarProductoState extends State<ActualizarProducto> {
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
  String fotoUrl;
  String urlFoto;
  File foto;

  bool isNumeric(String s) {
    final n = num.tryParse(s);
    return (n == null) ? false : true;
  }


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

  int calidad;


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

    
    final ProductoDetalleArg args = ModalRoute.of(context).settings.arguments;
    MediaQueryData media = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar producto',style: GoogleFonts.rubik(textStyle: TextStyle(color:Color.fromRGBO(55, 71, 79, 1), fontWeight: FontWeight.w600,fontSize: 18))),
        backgroundColor: Color.fromRGBO(29, 233, 182, 1),
        iconTheme: IconThemeData(color: Colors.black),

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
              _inputNombreProducto(args.nombre),
               SizedBox(height: 10.0),
              _inputFotoProducto(args.foto),
              SizedBox(height: 10.0),
              _inputDescripcionProducto(args.descripcion),
              SizedBox(height: 10.0),
              ComboCategoria(args.categoria),
              SizedBox(height: 10.0),
              ComboUnidad(args.unidadId),
              SizedBox(height: 10.0),
              _inputCalidad(context,args.calidad),
              SizedBox(height: 10.0),
              _inputStock(args.stock),
               SizedBox(height: 10.0),
              _inputPrecioCantidad1(args.precio1,args.cantidad1),
              SizedBox(height: 10.0),
              _inputPrecioCantidad2(args.precio2,args.cantidad2),
              SizedBox(height: 10.0),
              _inputPrecioCantidad3(args.precio3,args.cantidad3),

              
              SizedBox(height: 25.0),
                
              _botonConfirmar(context,args.comercioId,args.mercadoId,args.fotoUser,args.nombreUser,args.userId,args.idProducto),
              SizedBox(height: 10.0),

              ]
            ),
          )
        ),
      ),
      
    );
  }




  Widget _inputNombreProducto(nombreProd) {
    MediaQueryData media = MediaQuery.of(context);
    nombre = nombreController.text;
    if (nombreProd != nombre) {
      if (nombre == ''){
        nombreController.text = nombreProd;
      } else {
        nombreController.text = nombre;}
      }else {
        nombreController.text = nombreProd;
    }

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


    Widget _inputDescripcionProducto(descripcionProd) {
    MediaQueryData media = MediaQuery.of(context);
    descripcion = descripcionController.text;
    if (descripcionProd != descripcion) {
       if (descripcion == ''){
         descripcionController.text = descripcionProd;
       }else {
        descripcionController.text = descripcion;}
      }else {
        descripcionController.text = descripcionProd;
    }
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

    Widget _inputCalidad(context,calidadRating) {
    MediaQueryData media = MediaQuery.of(context);
    int ratingInicial = calidadRating.round();
    if (calidad == null) {
      calidad = calidadRating.round();
    }

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
              initialRating: ratingInicial.toDouble(),
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
                setState(() {
                  calidad = rating.round();
                });
              },
            )
          ),
      ],
    );
  }


    Widget _inputStock(stockProd) {
    MediaQueryData media = MediaQuery.of(context);
    stock = stockController.text;

    if (stockProd != stock) {
      if (stock == '') {
        stockController.text = stockProd;
      } else {
        stockController.text = stock;}
      }else {
        stockController.text = stockProd;
    }
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
                  if (isNumeric(stock)) {
                    return null;
                  } else {
                    return 'El campo Stock debe ser numérico';
                  }
                }
                
                
                },
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


  Widget _inputPrecioCantidad1(precio1Prod,cantidad1Prod) { 
    MediaQueryData media = MediaQuery.of(context);
    precio = precio1Controller.text;
    if (precio1Prod != precio) {
      if (precio == '') {
        precio1Controller.text = precio1Prod;
      } else {
        precio1Controller.text = precio;}
      }else {
        precio1Controller.text = precio1Prod;
    }
    cantidad = cantidad1Controller.text;
    if (cantidad1Prod != cantidad) {
      if (cantidad == '') {
        cantidad1Controller.text = cantidad1Prod;
      } else {
        cantidad1Controller.text = cantidad;}
      }else {
        cantidad1Controller.text = cantidad1Prod;
    }
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
                  if (isNumeric(precio)) {
                    return null;
                  } else {
                    return 'El campo Precio debe ser numérico';
                  }}},
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
                  if (isNumeric(cantidad)) {
                    return null;
                  } else {
                    return 'El campo Cantidad debe ser numérico';
                  }
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

    Widget _inputPrecioCantidad2(precio2Prod,cantidad2Prod) { 
    MediaQueryData media = MediaQuery.of(context);
    precio2 = precio2Controller.text;

   if (precio2Prod != precio2) {
     if (precio2 == '') {
        precio2Controller.text = precio2Prod;
      } else {
        precio2Controller.text = precio2;}
      }else {
        precio2Controller.text = precio2Prod;
    }
    cantidad2 = cantidad2Controller.text;
    if (cantidad2Prod != cantidad2) {
      if (cantidad2 == '') {
        cantidad2Controller.text = cantidad2Prod;
      } else {
        cantidad2Controller.text = cantidad2;}
      }else {
        cantidad2Controller.text = cantidad2Prod;
    }
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
                  return null;
                }else {
                  if (isNumeric(precio2)) {
                    return null;
                  } else {
                    return 'El campo Precio2 debe ser numérico';
                  }
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
                  return null;
                }else {
                  if (isNumeric(cantidad2)) {
                    return null;
                  } else {
                    return 'El campo Cantidad2 debe ser numérico';
                  }
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

    Widget _inputPrecioCantidad3(precio3Prod,cantidad3Prod) { 
    MediaQueryData media = MediaQuery.of(context);
    precio3 = precio3Controller.text;
    if (precio3Prod != precio3) {
      if (precio3 == '') {
        precio3Controller.text = precio3Prod;
      } else {
        precio3Controller.text = precio3;}
      }else {
        precio3Controller.text = precio3Prod;
    }
    cantidad3 = cantidad3Controller.text;
    if (cantidad3Prod != cantidad3) {
      if (cantidad3 == '') {
        cantidad3Controller.text = cantidad3Prod;
      } else {
        cantidad3Controller.text = cantidad3;}
      }else {
        cantidad3Controller.text = cantidad3Prod;
    }
    
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
                  return null;
                }else {
                  if (isNumeric(precio3)) {
                    return null;
                  } else {
                    return 'El campo Precio3 debe ser numérico';
                  }
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
                  return null;
                }else {
                  if (isNumeric(cantidad3)) {
                    return null;
                  } else {
                    return 'El campo Cantidad3 debe ser numérico';
                  }
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



  Widget _botonConfirmar(context,comercioId,mercado,fotoUser,nombreUser,user,productoId) {
    MediaQueryData media = MediaQuery.of(context);
    return GestureDetector(
      onTap: () async {
        

        SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
       String categoriaId = prefs.getString('idCategoria');
       
       String tipoUnidadId = prefs.getString('idTipoUnidad');
      
       



       if (formKey.currentState.validate()) {

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(child: Text('Actualizando producto')),
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

        if (foto != null) {
         
         fotoUrl = await subirImagen(foto);
         urlFoto = fotoUrl;
       }

        
         ProductoActualizar().producto(nombreController.text, descripcionController.text, categoriaId, stockController.text,
                                  calidad, urlFoto , tipoUnidadId, comercioId, precio1Controller.text, cantidad1Controller.text,
                                  precio2Controller.text,cantidad2Controller.text,precio3Controller.text,cantidad3Controller.text,mercado,
                                  fotoUser,nombreUser,user,productoId,context);
       }
      },
        
        // Navigator.pushNamed(context, 'vendedorProd');                                         
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
                Text('Actualizar producto', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                            fontSize: 14.0, fontWeight: FontWeight.w500,
                                      ))),
              )
            ],
          ),
        ),
      )
      
    );
    
  }

  Widget _inputFotoProducto(fotoAnt) {
  MediaQueryData media = MediaQuery.of(context);

    if (foto != null) {
      imageCache.clear();
      return  Stack(
         alignment: Alignment.topRight,
        children:<Widget>[Container(
          width: media.size.width * 0.90,
          height: media.size.height * 0.17,
          color: Colors.grey[100],
          child: Image.file(
            foto,
            fit: BoxFit.contain
          )
        ),
        GestureDetector(
          onTap: () { _cargarFoto();},
          child: Icon(Icons.edit, color: Colors.black, size: 30.0)
        )
        ]
      );

    } else {
      imageCache.clear();
      urlFoto = fotoAnt;
      return  Stack(
         alignment: Alignment.topRight,
        children:<Widget>[Container(
          width: media.size.width * 0.90,
          height: media.size.height * 0.17,
          color: Colors.grey[100],
          child: Image(
            image: NetworkImage(fotoAnt),
          )
        ),
        GestureDetector(
          onTap: () { _cargarFoto();},
          child: Icon(Icons.edit, color: Colors.black, size: 30.0)
        )
        ]
      );

    }



  }

  _cargarFoto(){
    showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Cargar foto:'),
            content: Text('¿De dónde desea cargar la foto?'),
            actions: [
              FlatButton(
                onPressed: () {_tomarFoto();
                Navigator.of(context).pop();},
                child: Text('Cámara'),
              
              ),
              FlatButton(
                onPressed: () {_seleccionarFoto();
                Navigator.of(context).pop();
                },
                child: Text('Galería'),
              
              ),
            ],
            backgroundColor: Colors.white

        ),
        barrierDismissible: true,
          ).then((_) => setState((){}));

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

  _tomarFoto() async {
    foto = await ImagePicker.pickImage(
      source: ImageSource.camera
      
      
      );

      if (foto != null) {

      }

      setState(() {
      });

  }

  Future<String> subirImagen(File foto) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/agilemarket/image/upload?upload_preset=derqlox3');
    final mimeType = mime(foto.path).split('/');

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      foto.path,
      contentType: MediaType(mimeType[0],mimeType[1])
      );

      imageUploadRequest.files.add(file);

      final streamResponse = await imageUploadRequest.send();

      final resp = await http.Response.fromStream(streamResponse);

      if (resp.statusCode != 200 && resp.statusCode != 201) {
        print('algo salio mal');
        return null;
      }

      final respData = json.decode(resp.body);
      return respData['secure_url'];
  }
}
