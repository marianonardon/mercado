import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_login_ui/src/pages/carrito_db.dart';
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
  final List<Precio> precios;


  Producto({this.productoID, this.productoNombre, this.productoDescripcion, this.productoStock,
          this.productoCalidad, this.productoFoto,this.categoriaID, this.categoriaNombre, this.tipoUnidadID,
          this.tipoUnidadNombre, this.comercioID, this.comercioNombre, this.mercadoID,
          this.mercadoNombre, this.productoDestacado, this.precios});

  factory Producto.fromJsonMap(Map<String, dynamic> parsedJson) {

    var list = parsedJson['precio'] as List;
    print(list.runtimeType);
    List<Precio> preciosList = list.map((i) => Precio.fromJson(i)).toList();

    return Producto(
      productoID: parsedJson['productoID'],
      productoNombre: parsedJson['productoNombre'],
      productoDescripcion: parsedJson['productoDescripcion'],
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
      precios: preciosList

    );
  }
}

class Precio {
  final String precioCantidad;
  final String precioProducto;

  Precio({this.precioCantidad, this.precioProducto});

  factory Precio.fromJson(Map<String, dynamic> parsedJson) {
    return Precio(
      precioCantidad: parsedJson['precioCantidad'],
      precioProducto: parsedJson['precioProducto']
    );
  }


}

class ProductosListView extends StatefulWidget {
  @override
  _ProductosListViewState createState() => _ProductosListViewState();
}

class _ProductosListViewState extends State<ProductosListView> {
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
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          String preciox1;
          String preciox2;
          String foto;
          if((data[index].precios.length - 1) >= 2) {
             preciox1 = data[index].precios[1].precioProducto;
             preciox2 = data[index].precios[2].precioProducto;
          }else{
            if ((data[index].precios.length - 1) == 1) {
             preciox1 = data[index].precios[1].precioProducto;
             preciox2 = '0';
          } else{
            preciox1 = '0';
            preciox2 = '0';
          }
          }
          if(data[index].productoFoto == '') {
            foto = 'https://uy.emedemujer.com/wp-content/uploads/sites/4/2015/10/674262.jpg';
          }else{
            foto = data[index].productoFoto;}
          return _crearLista(data[index].productoNombre,
                        foto,data[index].precios[0].precioProducto, preciox1,
                        data[index].comercioNombre,
                        data[index].tipoUnidadNombre, data[index].productoCalidad,
                        context);
        });
  }

    Widget _crearLista(String title, String imagen,String precio1,String precio2, String comercio, String unidad,double ratingProd, context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        
          width: 600.0,
      //   height: 500.0, */
        child: Column(
          children: <Widget>[
          //  _crearTitulo(),
            SizedBox(height: 15.0),
           _crearTarjetas(title, imagen,precio1,precio2,comercio,unidad,ratingProd,context)
          ],
        ),
      ),
    );
  }

  Widget _crearTarjetas(title,imagen,precio1,precio2,comercio,unidad,ratingProd,context) {
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
                        '\$$precio1 $unidad ', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(2, 127, 100, 1),
                          fontSize: 20.0, fontWeight: FontWeight.w600,
                    ))),
                    SizedBox(width: 20.0),
                    Text(
                        ratingProd.toString(), style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                          fontSize: 20.0, fontWeight: FontWeight.w600,
                    ))),
                    SizedBox(width: 5.0),
                    Icon(Icons.star, color:Colors.amber)
/*                     RatingBar(
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
                      ) */
                  ],
                )
              ]
            ),
          ),
          Expanded(child: GestureDetector(
            onTap: () {_showModalSheet(title,imagen,precio1,precio2,comercio,unidad,ratingProd,context);},
            child: Icon(Icons.add_box,size: 45.0, color:Color.fromRGBO(0, 255, 208, 1))))
        ],
      ),
  );
  }

  Future<void> _showModalSheet(title,imagen,precio1,precio2,comercio,unidad,ratingProd,context) async {

      int cantidadProd = 1;

      var producto = Carrito(
        nombreProducto: title,
        fotoProducto: imagen,
        comercioProducto: comercio,
        cantidadProducto: cantidadProd,
        unidadProducto: unidad,
        precioProducto: precio1,
        );



      showModalBottomSheet(
          elevation: 300.0,
          context: context,
          builder: (builder) {
            int cantidad = 1;
            cantidadProd = cantidad;
            
            
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
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
                    GestureDetector(
                        onTap: () {
                        setState(() {
                          if (cantidad > 1) {
                            cantidad = cantidad - 1 ; 
                            cantidadProd = cantidad;}
                        });},
                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                          color: Color.fromRGBO(255, 81, 0, 1),
                          height: 50.0,
                          width: 100.0,
                          padding: EdgeInsets.all(13.0),
                          child: Center(
                            child: Icon(Icons.remove)
                          ),

                        ),
                      ),
                    ),
                    SizedBox(width:20.0),
                    Text( '$cantidad $unidad', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                fontSize: 20.0, fontWeight: FontWeight.w300,
                          ))),
                    SizedBox(width:20.0),
                    GestureDetector(

                        onTap: () {
                          setState(() {
                            cantidad = cantidad + 1 ;
                            cantidadProd = cantidad;
                        });
                        },                  
                        child: ClipRRect(
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
                    ),

                  ],),
                SizedBox(height:15.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                    child: GestureDetector(
                        
                      onTap: () {
                        producto.cantidadProducto = cantidad;
                        DBProvider().insertCarrito(producto);
                        Navigator.pushNamed(context, 'carrito', arguments: title);},
                      child: Container(
                      color: Color.fromRGBO(29, 233, 182, 1),
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
                ),
                    ],
                  ),
              );
              }
            );
          });
  }

  Future<List<Producto>> fetchProductos() async { 

    String url = "https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/oauth/access_token";

    Map<String, String> bodyToken = {
      "client_id": "d6471aff30e64770bd9da53caccc4cc4",
      "client_secret": "7dae40626f4f45378b22bb47aa750024",
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



    final mercadosListAPIUrl = 'https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/rest/consultaProducto';
    final response = await http.get('$mercadosListAPIUrl', headers: headers2);

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

    String url = "https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/oauth/access_token";

    Map<String, String> bodyToken = {
      "client_id": "d6471aff30e64770bd9da53caccc4cc4",
      "client_secret": "7dae40626f4f45378b22bb47aa750024",
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



    final mercadosListAPIUrl = 'https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/rest/consultaProducto';
    final response = await http.get('$mercadosListAPIUrl', headers: headers2);

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

    String precio = producto.precios[0].precioProducto;
    String unidad = producto.tipoUnidadNombre;
    String foto;

    if (producto.productoFoto == '') {
      foto = 'https://uy.emedemujer.com/wp-content/uploads/sites/4/2015/10/674262.jpg';
    }else{
       foto = producto.productoFoto;}


    return Container(
      padding: EdgeInsets.all(7.0),
      child: Column
      (crossAxisAlignment: CrossAxisAlignment.start,
        
        children: <Widget>[

        ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
            placeholder: AssetImage('assets/img/no-image.jpg'),
            image: NetworkImage(foto),
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
              '\$$precio $unidad ', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(2, 127, 100, 1),
                fontSize: 18.0, fontWeight: FontWeight.w600,
          )),
          overflow: TextOverflow.ellipsis,)
      ],
      )
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