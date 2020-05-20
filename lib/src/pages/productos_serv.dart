import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';






class Productos{

  List<Producto> items = new List();

  Productos();

  Productos.fromJsonList(List<dynamic> jsonList) {

    if (jsonList == null) return;

    for (var item in jsonList) {
      final producto = new Producto.fromJsonMap(item);
      items.add(producto);
      
    }

  }



}



class Producto {
  final String productoID;
  final String productoNombre;
  final String productoDescripcion;
  final String productoPrecio;
  final String productoStock;
  final double productoCalidad;
  final String productoFoto;
  final String categoriaID;
  final String categoriaNombre;
  final String tipoUnidadID;
  final String tipoUnidadNombre;
  final String comercioID;
  final String comercioNombre;
  final String mercadoID;
  final String mercadoNombre;
  final bool   productoDestacado;


  Producto({this.productoID, this.productoNombre, this.productoDescripcion, this.productoPrecio, this.productoStock,
          this.productoCalidad, this.productoFoto,this.categoriaID, this.categoriaNombre, this.tipoUnidadID,
          this.tipoUnidadNombre, this.comercioID, this.comercioNombre, this.mercadoID,
          this.mercadoNombre, this.productoDestacado});

  factory Producto.fromJsonMap(Map<String, dynamic> parsedJson) {
    return Producto(
      productoID: parsedJson['productoID'],
      productoNombre: parsedJson['productoNombre'],
      productoDescripcion: parsedJson['productoDescripcion'],
      productoPrecio: parsedJson['productoPrecio'],
      productoStock: parsedJson['productoStock'],
      productoCalidad: parsedJson['productoCalidad'].toDouble(),
      productoFoto: parsedJson['productoFoto'],
      categoriaID: parsedJson['categoriaID'],
      categoriaNombre: parsedJson['categoriaNombre'],
      tipoUnidadID: parsedJson['tipoUnidadID'],
      tipoUnidadNombre: parsedJson['tipoUnidadNombre'],
      comercioID: parsedJson['comercioID'],
      comercioNombre: parsedJson['ComercioNombre'],
      mercadoID: parsedJson['mercadoID'],
      mercadoNombre: parsedJson['mercadoNombre'],
      productoDestacado: parsedJson['productoDestacado'],

    );
  }
}

class ProductosListView extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return FutureBuilder<List<Producto>>(
      future: fetchProductos(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Producto> data = snapshot.data;
          return _productosListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

     ListView _productosListView(data) {
      return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _crearLista(data[index].productoNombre,
                        data[index].productoFoto, data[index].productoPrecio, data[index].comercioNombre,
                        data[index].tipoUnidadNombre, data[index].productoCalidad,
                        context);
        });
  }
    Widget _crearLista(String title, String imagen,String precio, String comercio, String unidad,double ratingProd, context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        
          width: 600.0,
      //   height: 500.0, */
        child: Column(
          children: <Widget>[
          //  _crearTitulo(),
            SizedBox(height: 15.0),
           _crearTarjetas(title, imagen,precio,comercio,unidad,ratingProd,context)
          ],
        ),
      ),
    );
  }


  Widget _crearTarjetas(title,imagen,precio,comercio,unidad,ratingProd,context) {
  return Container(
    padding: EdgeInsets.only(left:5.0),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage(
            height: 90,
            width: 90,
            fit: BoxFit.fill,
            image: NetworkImage(imagen),

            placeholder: AssetImage('assets/img/original.gif')),
          ),
          SizedBox(width: 15.0),
          Container(
            width: 240.0,
            alignment: AlignmentDirectional.bottomStart,
            padding: EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children:<Widget>[ 
                Text(
                title, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                  fontSize: 20.0, fontWeight: FontWeight.bold,
                  ))
                ),
                SizedBox(height:6.0),
                Text(
                    comercio, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                      fontSize: 15.0, fontWeight: FontWeight.w400,
                ))),
                SizedBox(height:6.0),
                Row(
                  children: <Widget>[
                    Text(
                        '\$$precio $unidad ', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(0, 203, 159, 1),
                          fontSize: 20.0, fontWeight: FontWeight.w600,
                    ))),
                    RatingBar(
                        itemSize: 14.0,
                        initialRating: ratingProd,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (ratingProd) {
                          print(ratingProd);
                        },
                      )
                  ],
                )
              ]
            ),
          ),
          Expanded(child: GestureDetector(
            onTap: () {_showModalSheet(title,imagen,precio,comercio,unidad,ratingProd,context);},
            child: Icon(Icons.add_box,size: 45.0, color:Color.fromRGBO(0, 255, 208, 1))))
        ],
      ),
  );
  }

  void _showModalSheet(title,imagen,precio,comercio,unidad,ratingProd,context) {
      showModalBottomSheet(
          elevation: 300.0,
          context: context,
          builder: (builder) {
            
            return Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.topLeft,
               height: 900.0,
               width: double.infinity,
                child: Column(
                  children: <Widget>[
                    SizedBox(height:20.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: FadeInImage(
                            height: 100,
                            width: 110,
                            fit: BoxFit.fill,
                            image: NetworkImage(imagen),

                            placeholder: AssetImage('assets/img/original.gif')),
                          ),
                          SizedBox(width: 20.0,),
                          Container(
                            width: 200.0,
                            alignment: AlignmentDirectional.bottomStart,
                            padding: EdgeInsets.all(2.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children:<Widget>[ 
                                Text(
                                title, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                  fontSize: 20.0, fontWeight: FontWeight.bold,
                                  ))
                                ),
                                SizedBox(height:6.0),
                                Text(
                                    comercio, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                      fontSize: 15.0, fontWeight: FontWeight.w400,
                                )))
                              ]
                            )
                          )
                        ]
              ),
              SizedBox(height:15.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                  color: Color.fromRGBO(0, 255, 208,0.2 ),
                  height: 80.0,
                  width: double.infinity,
                  padding: EdgeInsets.all(13.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(width: 15.0),
                          Text(
                                    comercio, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                      fontSize: 20.0, fontWeight: FontWeight.bold,
                                ))),
                          SizedBox(width: 5.0),
                          RatingBar(
                            itemSize: 16.0,
                            initialRating: ratingProd,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.black,
                            ),
                            onRatingUpdate: (ratingProd) {
                              print(ratingProd);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
                SizedBox(height:20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                      color: Colors.red,
                      height: 50.0,
                      width: 100.0,
                      padding: EdgeInsets.all(13.0),
                      child: Center(
                        child: Icon(Icons.indeterminate_check_box)
                      ),

                    ),
                  ),
                  SizedBox(width:20.0),
                  Text( precio, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                              fontSize: 20.0, fontWeight: FontWeight.w300,
                        ))),
                  SizedBox(width:20.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                      color: Color.fromRGBO(0, 255, 208, 1),
                      height: 50.0,
                      width: 100.0,
                      padding: EdgeInsets.all(13.0),
                      child: Center(
                        child: Icon(Icons.add)
                      ),

                    ),
                  ),

                ],),
              SizedBox(height:15.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                  color: Color.fromRGBO(0, 255, 208, 1),
                  height: 50.0,
                  width: double.infinity,
                  padding: EdgeInsets.all(13.0),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: 15.0),
                            Text('Agregar al Carro', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                        fontSize: 20.0, fontWeight: FontWeight.w500,
                                  ))),
                            SizedBox(width: 5.0),
                            Icon(Icons.add_shopping_cart)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
                  ],
                ),
            );
          });
  }


  Future<List<Producto>> fetchProductos() async {

    final mercadosListAPIUrl = 'https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/rest/consultaProducto';
    final response = await http.get('$mercadosListAPIUrl');

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final productos = new Productos.fromJsonList(decodedData);
      return productos.items;
      //List jsonResponse = json.decode(response.body);
      //return jsonResponse.map<dynamic>((mercado) => new Mercados.fromJsonList(mercado));
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }






}

class ProductosListViewHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Producto>>(
      future: fetchProductos(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Producto> data = snapshot.data;
          return _crearProductoPageView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }



  Future<List<Producto>> fetchProductos() async {

    final mercadosListAPIUrl = 'https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/rest/consultaProducto';
    final response = await http.get('$mercadosListAPIUrl');

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final productos = new Productos.fromJsonList(decodedData);
      return productos.items;
      //List jsonResponse = json.decode(response.body);
      //return jsonResponse.map<dynamic>((mercado) => new Mercados.fromJsonList(mercado));
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }






  Widget _crearProductoPageView(List<Producto> productos) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 210.0,
          child: PageView.builder(
            pageSnapping: true,
            dragStartBehavior: DragStartBehavior.down,
            controller: PageController(
              viewportFraction: 0.3,
              initialPage: 1
            ),
            itemCount: productos.length,
            itemBuilder: (context, i) => _productoTarjeta(productos[i]
            )
          ),
          ),

      ],
    );
  }




  Widget _productoTarjeta(Producto producto) {

    String precio = producto.productoPrecio;
    String unidad = producto.tipoUnidadNombre;


    return Container(
      padding: EdgeInsets.all(7.0),
      child: Column
      (crossAxisAlignment: CrossAxisAlignment.start,
        
        children: <Widget>[

        ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
            placeholder: AssetImage('assets/img/no-image.jpg'),
            image: NetworkImage(producto.productoFoto),
            height: 120.0,
            fit: BoxFit.cover,
            ),
        ),
        SizedBox(height: 8.0),
        Text(
          producto.productoNombre, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
            fontSize: 16.0, fontWeight: FontWeight.w600,
            )),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height:3.0),
          Text(
              '\$$precio $unidad ', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(0, 203, 159, 1),
                fontSize: 18.0, fontWeight: FontWeight.w600,
          )),
          overflow: TextOverflow.ellipsis,)
      ],
      )
    );
  }







}