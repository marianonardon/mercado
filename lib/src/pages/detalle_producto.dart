import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_login_ui/src/pages/vendedor_prod_serv.dart';
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class DetalleProducto extends StatefulWidget {
  @override
  _DetalleProductoState createState() => _DetalleProductoState();
}

class _DetalleProductoState extends State<DetalleProducto> {
  @override
  Widget build(BuildContext mainContext) {
    MediaQueryData media = MediaQuery.of(context); 
    final ProductoDetalleArg args = ModalRoute.of(context).settings.arguments;
    //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    String textoPrecio2;
    String textoPrecio3;
    String peso2;
    String peso3;
    if(args.precio2 == ''){
      textoPrecio2 = '';
      peso2 = '';
    } else{
      textoPrecio2 = 'Precio por ';
      peso2 = '\$';
    }
    if(args.precio3 == ''){
      textoPrecio3 = '';
      peso3 = '';
    } else{
      textoPrecio3 = 'Precio por ';
      peso3 = '\$';
    }
    return WillPopScope(
      onWillPop: () async => false,
          child: Scaffold(
      //  key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(29, 233, 182, 1),
          iconTheme: IconThemeData(color: Colors.black),
          leading: new IconButton(
          icon: new Icon(Icons.chevron_left, size:35),
          onPressed: () => Navigator.of(context).pop(),),
/*         actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.white),
              onPressed: () {}
            )
          ], */
          title: Text('Producto',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                          fontSize: 18.0, fontWeight: FontWeight.w600,
                          )),), 
          ),

          body: SingleChildScrollView(
              child: Container(
               width: double.infinity,
              // height: double.infinity,
               color: Colors.grey[100],
               child: Column(
                 children: <Widget>[
                   Container(
                     width: double.infinity,
                     color: Colors.white,
                     child: Column(
                       children: <Widget>[
                         ClipRRect(
                           borderRadius: BorderRadius.circular(25.0),
                           child: Column(
                             mainAxisSize: MainAxisSize.max,
                             children: <Widget>[
                               SizedBox(height: 20.0),
                               Container(
                                 decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(1),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      //offset: Offset(5,5), // changes position of shadow
                                    ),
                                  ],
                                 ),
                                 width: media.size.width * 0.95,
                                 //height: double.infinity,
                                 //width: media.size.width * 0.95,
                                 child: Column(
                                   mainAxisSize: MainAxisSize.max,
                                   children: <Widget>[
                                     Image(image: NetworkImage(args.foto),
                                     width: double.infinity,
                                     fit: BoxFit.cover,
                                     ),
                                     SizedBox(height:20.0),
                                     Container(
                                       width:  double.infinity,
                                       color: Colors.white,
                                       child: Column(
                                         children: <Widget>[
                                           Row(
                                             children: <Widget>[
                                               SizedBox(width:15.0),
                                               Text(args.nombre,style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                                   fontSize: 16.0, fontWeight: FontWeight.bold,
                                                )),),
                                             ],),
                                            SizedBox(height:15.0),
                                          Row(
                                             children: <Widget>[
                                               SizedBox(width:15.0),
                                               Text(args.descripcion,style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(0, 0, 0, 0.6),
                                                   fontSize: 12.0, fontWeight: FontWeight.normal,
                                                )),),
                                             ],),
                                             SizedBox(height:15.0),
                                             Container(
                                               color: Color.fromRGBO(0, 203, 159, 0.18),
                                               width: double.infinity,
                                               height: media.size.height * 0.07,
                                               child: Row(
                                                 children: <Widget>[
                                                   SizedBox(width: 15.0),
                                                   Text('Stock',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(0, 203, 159,1),
                                                   fontSize: 14.0, fontWeight: FontWeight.w600,
                                                )),),
                                                SizedBox(
                                                  width: media.size.width * 0.7,
                                                ),
                                                Icon(Icons.shopping_basket,
                                                color: Color.fromRGBO(0, 203, 159, 1),)
                                                 ]
                                               )
                                             ),
                                             SizedBox(height:15.0),
                                             Row(
                                                 children: <Widget>[
                                                   SizedBox(width: 15.0),
                                                   Text('Stock disponible',style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(16, 32,39,1),
                                                   fontSize: 12.0, fontWeight: FontWeight.w600,
                                                )),),
                                                SizedBox(
                                                  width: media.size.width * 0.43,
                                                ),
                                                Text(args.stock,style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(55,71,79,1),
                                                   fontSize: 16.0, fontWeight: FontWeight.bold,
                                                )),),
                                                SizedBox(width: 1.0),
                                                Text(args.unidad,style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(55,71,79,1),
                                                   fontSize: 16.0, fontWeight: FontWeight.bold,
                                                )),),

                                              ]
                                             ),
                                             SizedBox(height:15.0),
                                             Container(
                                               color: Color.fromRGBO(0, 203, 159, 0.18),
                                               width: double.infinity,
                                               height: media.size.height * 0.07,
                                               child: Row(
                                                 children: <Widget>[
                                                   SizedBox(width: 15.0),
                                                   Text('Precio',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(0, 203, 159,1),
                                                   fontSize: 14.0, fontWeight: FontWeight.w600,
                                                )),),
                                                SizedBox(
                                                  width: media.size.width * 0.7,
                                                ),
                                                Icon(Icons.monetization_on,
                                                color: Color.fromRGBO(0, 203, 159, 1),)
                                                 ]
                                               )
                                             ),
                                             SizedBox(height:15.0),
                                            Row(
                                                 children: <Widget>[
                                                   Container(
                                                     width: media.size.width * 0.5,
                                                     child: Row(children: <Widget>[
                                                       SizedBox(width: 15.0),
                                                     Text('Precio por ',style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(16, 32,39,1),
                                                     fontSize: 12.0, fontWeight: FontWeight.w600,
                                                      )),),
                                                      Text(args.cantidad1,style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(16, 32,39,1),
                                                     fontSize: 12.0, fontWeight: FontWeight.w600,
                                                      )),),
                                                      SizedBox(width: 1.0),
                                                      Text(args.unidad,style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(0,70,174,1),
                                                          fontSize: 12.0, fontWeight: FontWeight.w600,
                                                      )),),

                                                     ],),
                                                   ),
                                                   
                                                    
                                                SizedBox(
                                                  width: media.size.width * 0.18,
                                                ),
                                                Text('\$',style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(0,70,174,1),
                                                   fontSize: 16.0, fontWeight: FontWeight.w600,
                                                )),),
                                                Text(args.precio1,style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(0,70,174,1),
                                                   fontSize: 16.0, fontWeight: FontWeight.w600,
                                                )),),
                                                

                                              ]
                                             ),
                                              SizedBox(height:15.0),
                                            Row(
                                                 children: <Widget>[
                                                   Container(
                                                     width: media.size.width * 0.5,
                                                     child: Row(children: <Widget>[
                                                       SizedBox(width: 15.0),
                                                     Text(textoPrecio2,style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(16, 32,39,1),
                                                     fontSize: 12.0, fontWeight: FontWeight.w600,
                                                      )),),
                                                      Text(args.cantidad2,style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(16, 32,39,1),
                                                     fontSize: 12.0, fontWeight: FontWeight.w600,
                                                      )),),
                                                      SizedBox(width: 1.0),
                                                      Text(args.unidad2,style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(0,70,174,1),
                                                        fontSize: 12.0, fontWeight: FontWeight.w600,
                                                      )),),



                                                     ],),
                                                   ),
                                                   
                                                    
                                                SizedBox(
                                                  width: media.size.width * 0.18,
                                                ),
                                                Text(peso2,style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(0,70,174,1),
                                                   fontSize: 16.0, fontWeight: FontWeight.w600,
                                                )),),
                                                Text(args.precio2,style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(0,70,174,1),
                                                   fontSize: 16.0, fontWeight: FontWeight.w600,
                                                )),),
                                                

                                              ]
                                             ),
                                               SizedBox(height:15.0),
                                            Row(
                                                 children: <Widget>[
                                                   Container(
                                                     width: media.size.width * 0.5,
                                                     child: Row(children: <Widget>[
                                                       SizedBox(width: 15.0),
                                                     Text(textoPrecio3,style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(16, 32,39,1),
                                                     fontSize: 12.0, fontWeight: FontWeight.w600,
                                                      )),),
                                                      Text(args.cantidad3,style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(16, 32,39,1),
                                                     fontSize: 12.0, fontWeight: FontWeight.w600,
                                                      )),),
                                                      SizedBox(width: 1.0),
                                                      Text(args.unidad3,style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(0,70,174,1),
                                                        fontSize: 12.0, fontWeight: FontWeight.w600,
                                                      )),),


                                                     ],),
                                                   ),
                                                   
                                                    
                                                SizedBox(
                                                  width: media.size.width * 0.18,
                                                ),
                                                Text(peso3,style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(0,70,174,1),
                                                   fontSize: 16.0, fontWeight: FontWeight.w600,
                                                )),),
                                                Text(args.precio3,style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(0,70,174,1),
                                                   fontSize: 16.0, fontWeight: FontWeight.w600,
                                                )),),
                                                

                                              ]
                                             ),
                                             SizedBox(height: media.size.height * 0.01,)
                                         ],
                                         
                                       )
                                     )
                                     
                                   ]
                                 )
                               )
                             ]
                           )
                         ),
                         SizedBox(height: media.size.height * 0.02),
                       ],
                     ),
                   ),
                   SizedBox(height: media.size.height * 0.02),
                   GestureDetector(
                     onTap: () { Navigator.pushNamed(context, 'actProd', arguments: ProductoDetalleArg(args.idProducto, args.nombre,args.descripcion,args.foto,args.precio1
                                ,args.cantidad1,args.precio2,args.cantidad2,args.precio3,args.cantidad3,args.stock,args.unidad,args.unidad2,args.unidad3,args.comercioId,args.mercadoId,args.userId,
                                args.calidad,args.categoria,args.unidadId,args.fotoUser,args.nombreUser,args.numNave,args.comercioPuesto,args.comercioCuit,args.comercioTelefono,args.comercioMail,args.comercioNombre));

                     },
                     child: Container(
                       width: double.infinity,
                       color: Colors.white,
                       child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 182, 134, 0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            width: media.size.width * 0.90,
                            height: media.size.height * 0.06,
                            //width: media.size.width * 0.95,
                            child: Center(
                              child: Text('Actualizar producto',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(0, 182, 134, 1),
                              fontSize: 16.0, fontWeight: FontWeight.w600,
                              ))),
                            )
                          ),
                          SizedBox(height: media.size.height * 0.008,),
                          GestureDetector(
                              onTap: () {
                                 showDialog(
                                    context: mainContext,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: Center(child: Text('¿Seguro quiere eliminar el producto?',
                                      textAlign: TextAlign.center,)),
                                      actions: [
                                        Padding(
                                          padding: const EdgeInsets.only(right:50.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              FlatButton(
                                                color: Color.fromRGBO(195, 15, 0, 1),
                                                onPressed: () {
                                                Navigator.of(context).pop();},
                                                child: Text('No'),
                                                textColor: Colors.white,
                                              
                                              ),
                                              SizedBox(width: media.size.width * 0.2,),
                                              FlatButton(
                                                color: Color.fromRGBO(29, 233, 182, 1),
                                                onPressed: () async {
                                                  String productoId2;
                                                  productoId2 = await deleteProducto(args.idProducto,args);
                                                },
                                                child: Text('Si'),
                                                textColor: Colors.black,
                                              
                                              ),
                                            ],
                                          ),
                                        ),
                                        
                                      ],
                                      backgroundColor: Colors.white

                                  ),
                                  barrierDismissible: true,
                                    ).then((_) => setState((){}));



                              },
                              child: Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  SizedBox(height: 20.0),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(195, 15,0, 0.5),
                                          spreadRadius: 3,
                                          blurRadius: 5,
                                          offset: Offset(0, 2), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    width: media.size.width * 0.90,
                                    height: media.size.height * 0.06,
                                    //width: media.size.width * 0.95,
                                    child: Center(
                                      child: Text('Eliminar producto',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(195, 15,0, 1),
                                      fontSize: 16.0, fontWeight: FontWeight.w600,
                                      ))),
                                    )
                                  
                                  ),
                                  ]
                                  ),
                            ),
                          ),
                          SizedBox(height: media.size.height * 0.04,),
                 ],
               ),
            ),
                   ),
           ]
               )
              )
          ),
        
      ),
    );
  }

  Future<String> deleteProducto(productoId3,args) async {
    MediaQueryData media = MediaQuery.of(context); 

    Navigator.of(context).pop();
    showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(child: Text('Eliminado producto')),
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
    
    
      Map headers3 = <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "OAuth $token2"
        };

    final mercadosListAPIUrl = 'https://apps5.genexus.com/Idef38f58ee9b80b1400d5b7848a7e9447/rest/Producto/$productoId3';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/Producto/$productoId3';
    final response = await http.delete('$mercadosListAPIUrlQA', headers: headers2);

    final decodedData2 = json.decode(response.body);
    final producto =  Producto.fromJsonMap(decodedData2);
    Navigator.of(context).pop();
    showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(child: Text('Producto eliminado')),
            content:  SizedBox(
                      width: media.size.width * 0.005,
                      height: media.size.height * 0.05,
                      child: Center(
                        child: Icon(Icons.check_circle, color: Color.fromRGBO(29, 233, 182, 1),size: 50.0,)
                      ),
                  ),
            backgroundColor: Colors.white,
             actions: [
                Padding(
                  padding: const EdgeInsets.only(right:65.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FlatButton(
                        color: Color.fromRGBO(29, 233, 182, 1),
                        onPressed: () {
                        Navigator.pushNamed(context, 'vendedorProd', arguments: PuestoArguments(args.userId,args.nombreUser,args.fotoUser,args.mercadoId,args.comercioId,
                        args.numNave,args.comercioPuesto,args.comercioCuit,args.comercioTelefono,args.comercioMail,args.comercioNombre));},
                        child: Text('Ir a mis productos'),
                        textColor: Colors.black,
                      
                      ),
                        
                    ],
                  ),
                ),
                
              ],

        ),
        barrierDismissible: false,
          ).then((_) => setState((){}));

    //Navigator.pushNamed(context, 'altaProdOk' ,arguments: PuestoArguments(args.userId,args.nombreUser,args.fotoUser,args.mercadoId,args.comercioId));
    return producto.productoID;
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
  final String gx;


  Producto({this.productoID, this.productoNombre, this.productoDescripcion, this.productoStock,
          this.productoCalidad, this.productoFoto,this.categoriaID, this.categoriaNombre, this.tipoUnidadID,
          this.tipoUnidadNombre, this.comercioID, this.comercioNombre, this.mercadoID,
          this.mercadoNombre, this.productoDestacado, this.precios,this.gx});

  factory Producto.fromJsonMap(Map<String, dynamic> parsedJson) {

    var list = parsedJson['Precio'] as List;
    print(list.runtimeType);
    List<Precio> preciosList = list.map((i) => Precio.fromJson(i)).toList();

    return Producto(
      productoID: parsedJson['ProductoID'],
      productoNombre: parsedJson['ProductoNombre'],
      productoDescripcion: parsedJson['ProductoDescripcion'],
      productoStock: parsedJson['ProductoStock'],
      productoCalidad: parsedJson['ProductoCalidad'].toDouble(),
      productoFoto: parsedJson['ProductoFoto'],
      categoriaID: parsedJson['CategoriaID'],
      categoriaNombre: parsedJson['CategoriaNombre'],
      tipoUnidadID: parsedJson['TipoUnidadID'],
      tipoUnidadNombre: parsedJson['TipoUnidadNombre'],
      comercioID: parsedJson['ComercioID'],
      comercioNombre: parsedJson['ComercioNombre'],
      mercadoID: parsedJson['MercadoID'],
      mercadoNombre: parsedJson['MercadoNombre'],
      productoDestacado: parsedJson['ProductoDestacado'],
      precios: preciosList,
      gx: parsedJson['gx_md5_hash']

    );
  }
}

class Precio {
  final String precioCantidad;
  final String precioProducto;

  Precio({this.precioCantidad, this.precioProducto});

  factory Precio.fromJson(Map<String, dynamic> parsedJson) {
    return Precio(
      precioCantidad: parsedJson['PrecioCantidad'],
      precioProducto: parsedJson['PrecioProducto']
    );
  }


}

