import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_login_ui/src/pages/productos_serv.dart';






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



/* class Producto {
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
  final List<Precio> precios; */


/*   Producto({this.productoID, this.productoNombre, this.productoDescripcion, this.productoStock,
          this.productoCalidad, this.productoFoto,this.categoriaID, this.categoriaNombre, this.tipoUnidadID,
          this.tipoUnidadNombre, this.comercioID, this.comercioNombre, this.mercadoID,
          this.mercadoNombre, this.productoDestacado, this.precios});

  factory Producto.fromJsonMap(Map<String, dynamic> parsedJson) {

    var list = parsedJson['precio'] != null ? parsedJson['precio'] as List : List<Precio>();
    List<Precio> preciosList;

    preciosList = parsedJson['precio'] != null ? list.map((i) => Precio.fromJson(i)).toList() : List<Precio>();

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
      comercioNombre: parsedJson['comercioNombre'],
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


} */

class VendedorProductosListView extends StatefulWidget {
  VendedorProductosListView(this.comercioId,this.mercadoId,this.userId,this.fotoUser,this.nombreUser,this.numNave,this.comercioPuesto,
  this.comercioCuit,this.comercioTelefono,this.comercioMail,this.comercioNombre);
  final String comercioId;
  final String mercadoId;
  final String userId;
  final String fotoUser;
  final String nombreUser;
  final String numNave;
  final String comercioPuesto;
  final String comercioCuit;
  final String comercioTelefono;
  final String comercioMail;
  final String comercioNombre;

  @override
  _ProductosListViewState createState() => _ProductosListViewState(comercioId,mercadoId,userId,fotoUser,nombreUser,numNave,comercioPuesto,comercioCuit,comercioTelefono,
  comercioMail,comercioNombre);
}

class _ProductosListViewState extends State<VendedorProductosListView> {
   _ProductosListViewState(this.comercioId,this.mercadoId,this.userId,this.fotoUser,this.nombreUser,this.numNave,this.comercioPuesto,this.comercioCuit,
   this.comercioTelefono,this.comercioMail,this.comercioNombre);
  final String comercioId;
  final String mercadoId;
  final String userId;
  final String fotoUser;
  final String nombreUser;
  final String numNave;
  final String comercioPuesto;
  final String comercioCuit;
  final String comercioTelefono;
  final String comercioMail;
  final String comercioNombre;
  @override
  Widget build(BuildContext context){
    return FutureBuilder<List<Producto>>(
      future: fetchProductos(comercioId),
      builder: (context, snapshot) {
        MediaQueryData media = MediaQuery.of(context);
        if (snapshot.hasData) {
          if(snapshot.requireData.isEmpty){
/*             if (productoValidacion == true) {
              return Container();
            } else { */
            return Center(
              child: Container(
                child: Column(
                   children: <Widget>[
                     Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                    Stack(
                      fit: StackFit.loose,
                      alignment: Alignment.topRight,
                      children: <Widget> [
                        Image(
                          //height: media.size.height * 0.23,
                          //width: media.size.width * 0.93,
                          fit: BoxFit.fill,
                          image: AssetImage('assets/img/PuestoImg.png'),

                          //placeholder: AssetImage('assets/img/loader.gif')),
                        ),
                        
                        GestureDetector(
                          onTap: () {Navigator.pushNamed(context, 'actPues', arguments: PuestoArguments(userId, nombreUser, fotoUser, mercadoId, comercioId,numNave,comercioPuesto,
              comercioCuit,comercioTelefono,comercioMail,comercioNombre)); },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.0),
                            child: Container(
                              color: Colors.black38,
                              child: Icon(Icons.mode_edit, color: Colors.white, size: 30.0)))
                        ),

                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child:  Container(
                              color: Colors.black26,
                              child: Column(
                                children:<Widget>[ 
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start ,
                                    children: <Widget>[
                                      SizedBox(width:10.0),
                                      Flexible(
                                      child: Text(
                                        comercioNombre, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.white,
                                          fontSize: 24.0, fontWeight: FontWeight.w600,
                                          )),
                                        ),
                                      ),
                                      SizedBox(width: 30.0),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start ,
                                    children: <Widget>[
                                      SizedBox(width:10.0),
                                      Icon(Icons.location_on,color:Colors.white),
                                      SizedBox(width: 5.0),
                                      Flexible(
                                        child: Text(
                                        'Puesto / Nombre $comercioPuesto Nave / Sector $numNave', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.white,
                                          fontSize: 14.0, fontWeight: FontWeight.normal,
                                          )),
                                        ),
                                      ),
                                      SizedBox(width: 13.0),
                                      Icon(Icons.phone,color:Colors.white),
                                      SizedBox(width: 5.0),
                                      Text(
                                      comercioTelefono, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.white,
                                        fontSize: 14.0, fontWeight: FontWeight.normal,
                                        )),
                                      ),
                                      SizedBox(width: 30.0),
                                    ],
                                  ),
                                  SizedBox(height: 15.0),
                                ]
                              ),
                            ),
                        ),
                        
                        ]
                    ),
                    ])),
                     Image(
                       height: media.size.height * 0.45,
                       image: AssetImage('assets/img/SinProductos.gif'),
                     ),
                    Text(
                    'Cree un producto', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(98, 114, 123, 1),
                      fontSize: 24.0, fontWeight: FontWeight.w600,
                      ))                 
                    ),
                    Text(
                    'para su puesto', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(98, 114, 123, 1),
                      fontSize: 24.0, fontWeight: FontWeight.w600,
                      ))                 
                    ),
                    SizedBox(height: 15.0),
                     

                  ]
                )
                
                ),
            );
            //}
          } else {
          List<Producto> data = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

               Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                    Stack(
                      fit: StackFit.loose,
                      alignment: Alignment.topRight,
                      children: <Widget> [
                        Image(
                          //height: media.size.height * 0.23,
                          //width: media.size.width * 0.93,
                          fit: BoxFit.fill,
                          image: AssetImage('assets/img/PuestoImg.png'),

                          //placeholder: AssetImage('assets/img/loader.gif')),
                        ),
                        
                        GestureDetector(
                          onTap: () {Navigator.pushNamed(context, 'actPues', arguments: PuestoArguments(userId, nombreUser, fotoUser, mercadoId, comercioId,numNave,comercioPuesto,
              comercioCuit,comercioTelefono,comercioMail,comercioNombre)); },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.0),
                            child: Container(
                              color: Colors.black38,
                              child: Icon(Icons.mode_edit, color: Colors.white, size: 30.0)))
                        ),

                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child:  Container(
                              color: Colors.black26,
                              child: Column(
                                children:<Widget>[ 
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start ,
                                    children: <Widget>[
                                      SizedBox(width:10.0),
                                      Flexible(
                                        child: Text(
                                        comercioNombre, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.white,
                                          fontSize: 24.0, fontWeight: FontWeight.w600,
                                          )),
                                        ),
                                      ),
                                      SizedBox(width: 30.0),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start ,
                                    children: <Widget>[
                                      SizedBox(width:10.0),
                                      Icon(Icons.location_on,color:Colors.white),
                                      SizedBox(width: 5.0),
                                      Flexible(
                                       child: Text(
                                        'Puesto / Nombre $comercioPuesto Nave / Sector $numNave', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.white,
                                          fontSize: 14.0, fontWeight: FontWeight.normal,
                                          )),
                                        ),
                                      ),
                                      SizedBox(width: 13.0),
                                      Icon(Icons.phone,color:Colors.white),
                                      SizedBox(width: 5.0),
                                      Text(
                                      comercioTelefono, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.white,
                                        fontSize: 14.0, fontWeight: FontWeight.normal,
                                        )),
                                      ),
                                      SizedBox(width: 30.0),
                                    ],
                                  ),
                                  SizedBox(height: 15.0),
                                ]
                              ),
                            ),
                        ),
                        
                        ]
                    ),
                    ])),

                    SizedBox(height: 20.0),
              
              Text('  Catálogo de productos',style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                fontSize: 16.0, fontWeight: FontWeight.w600,
                ))),
           _productosListView(data,comercioId)
            ]
          );
          }
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

     ListView _productosListView(data,comercioId) {
      MediaQueryData media = MediaQuery.of(context);
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          String preciox1;
          String preciox2;
          String preciox3;
          String cantidad1;
          String cantidad2;
          String cantidad3;
          String foto;
          if((data[index].precios.length - 1) >= 2) {
             preciox1 = data[index].precios[0].precioProducto;
             preciox2 = data[index].precios[1].precioProducto;
             preciox3 = data[index].precios[2].precioProducto;
             cantidad1 = data[index].precios[0].precioCantidad;
             cantidad2 = data[index].precios[1].precioCantidad;
             cantidad3 = data[index].precios[2].precioCantidad;
          }else{
            if ((data[index].precios.length - 1) == 1) {
             preciox1 = data[index].precios[0].precioProducto;
             preciox2 = data[index].precios[1].precioProducto;
             preciox3 = '';
             cantidad1 = data[index].precios[0].precioCantidad;
             cantidad2 = data[index].precios[1].precioCantidad;
             cantidad3 = '';
           } else{
              if ((data[index].precios.length - 1) == 0) {
                preciox1 = data[index].precios[0].precioProducto;
                preciox2 = '';
                preciox3 = '';
                cantidad1 = data[index].precios[0].precioCantidad;
                cantidad2 = '';
                cantidad3 = '';}
                else{
                preciox1 = '';
                preciox2 = '';
                preciox3 = '';
                cantidad1 = '';
                cantidad2 = '';
                cantidad3 = '';

              }
          }
          }
          if(data[index].productoFoto == '') {
            foto = 'https://uy.emedemujer.com/wp-content/uploads/sites/4/2015/10/674262.jpg';
          }else{
            foto = data[index].productoFoto;}
          return _crearLista(data[index].productoNombre, data[index].productoDescripcion,
                        foto,preciox1,preciox2,preciox3,cantidad1,cantidad2,cantidad3,
                        data[index].comercioNombre,
                        data[index].tipoUnidadNombre, data[index].productoCalidad,comercioId, data[index].productoStock,
                        data[index].productoID,data[index].categoriaID,data[index].tipoUnidadID,numNave,comercioPuesto,comercioCuit,
                        comercioTelefono,comercioMail,comercioNombre,context);
        });
  }

    Widget _crearLista(String title,String prodDesc, String imagen,String precio1,String precio2,String precio3,String cantidad1,String cantidad2,String cantidad3, String comercio, String unidad,double ratingProd,comercioId,String stock,String productoID, String categoriaId,String unidadId,
    numNave,comercioPuesto,comercioCuit,comercioTelefono,comercioMail,comercioNombre, context) {
    MediaQueryData media = MediaQuery.of(context);
    return  ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        
          width: media.size.height * 95.0,
      //   height: 500.0, */
        child: Column(
          children: <Widget>[
          //  _crearTitulo(),
            SizedBox(height: 15.0),
           _crearTarjetas(title,prodDesc, imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioId,stock,productoID,categoriaId,unidadId,
           numNave,comercioPuesto,comercioCuit,comercioTelefono,comercioMail,comercioNombre,context)
          ],
        ),
      ),
    );
  }

  Widget _crearTarjetas(title,prodDesc,imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioId,stock,productoID,categoriaId,unidadId,
  numNave,comercioPuesto,comercioCuit,comercioTelefono,comercioMail,comercioNombre,context) {
 MediaQueryData media = MediaQuery.of(context); 
  String unidad1;
  String unidad2;
  String unidad3;
  String speso1;
  String speso2;
  String speso3;

  if(precio1 == ''){
    unidad1 = '';
    speso1 = '';
  } else{
    unidad1 = unidad;
    speso1 = '\$';
  }
  if(precio2 == ''){
    unidad2 = '';
    speso2 = '';
  } else{
    unidad2 = unidad;
    speso2 = '\$';
  }
  if(precio3 == ''){
    unidad3 = '';
    speso3 = '';
  }else {
    unidad3 = unidad;
    speso3 = '\$';
  }
  return Container(
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'detalleProd', arguments: ProductoDetalleArg(productoID, title,prodDesc,imagen,precio1,cantidad1,precio2,cantidad2,
                                  precio3,cantidad3,stock,unidad1,unidad2,unidad3,comercioId,mercadoId,userId,ratingProd,categoriaId,unidadId,fotoUser,nombreUser,
                                  numNave,comercioPuesto,comercioCuit,comercioTelefono,comercioMail,comercioNombre));

              },
              child: Container(
              padding: EdgeInsets.only(left:12.0),
               child: Column(
                 children: <Widget>[
                   Divider(
                     color: Colors.black,
                     endIndent: 15.0,
                     height: 1.0,
                     thickness: 0.5,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image(
                              height: 55  ,
                              width: 55,
                              fit: BoxFit.fill,
                              image: NetworkImage(imagen),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 15.0),
                        Container(
                          width: media.size.width * 0.70 ,
                          alignment: AlignmentDirectional.bottomStart,
                          padding: EdgeInsets.all(6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children:<Widget>[ 
                              SizedBox(height: 10.0),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Flexible(
                                      child: Text(
                                      title, style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                        fontSize: 16.0, fontWeight: FontWeight.bold,
                                        ))
                                      ),
                                    ),
                                  ),
                                SizedBox(width: 10.0),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                                            child: Container(
                                        color: Color.fromRGBO(29, 233, 182, 1),
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(width: 4.0),
                                            Text(
                                              ratingProd.toString(), style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.white,
                                                fontSize: 12.0, fontWeight: FontWeight.w500
                                  ))),
                                  SizedBox(width: 5.0),
                                  Icon(Icons.star, color:Colors.white, size: 15.0 ),
                                  SizedBox(width: 4.0),
                                          ],
                                        ),
                                      ),
                                    ),
                                  
                                ],
                              ),
                              SizedBox(height:6.0),
                              Row(
                                children: <Widget>[
                                  Text(
                                      comercio, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                        fontSize: 12.0, fontWeight: FontWeight.w400,
                                  ))),
                                  
                                ],
                              ),
                              SizedBox(height:6.0),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 80.00,
                                    child: Text(
                                        '$speso1$precio1', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                          fontSize: 14.0, fontWeight: FontWeight.w600,
                                    ))),
                                  ),
                                  Text(
                                      '$cantidad1 $unidad1 ', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                        fontSize: 12.0, fontWeight: FontWeight.w400,
                                  ))),
                                  

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 80.00,
                                    child: Text(
                                        '$speso2$precio2', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                          fontSize: 14.0, fontWeight: FontWeight.w600,
                                    ))),
                                  ),
                                  Text(
                                      '$cantidad2 $unidad2 ', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                        fontSize: 12.0, fontWeight: FontWeight.w400,
                                  ))),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 80.00,
                                    child: Text(
                                        '$speso3$precio3', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                          fontSize: 14.0, fontWeight: FontWeight.w600,
                                    ))),
                                  ),
                                  Text(
                                      '$cantidad3 $unidad3 ', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                        fontSize: 12.0, fontWeight: FontWeight.w400,
                                  ))),
                                ],
                              )
                            ]
                          ),
                        ),
                        ],
                    ),
                 ],
               ),
            ),
          ),
        );
  }

  

  Future<List<Producto>> fetchProductos(comercioId) async { 

    String url = "https://agilemarket.com.ar/oauth/access_token";
    String urlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/oauth/access_token';

    Map<String, String> bodyToken = {
      "client_id": "da0d4cd9919d4d80afecf1c56d954633",
      "client_secret": "be70f816716f402b8c02e53daec3e067",
      "scope": "FullControl",
      "username": "admin",
      "password": "wetiteam123",
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


    final responseToken = await http.post(url, body: bodyToken, headers: headers);
    final decodedData = json.decode(responseToken.body);
    final token = new Token.fromJsonMap(decodedData);
    String token2 = token.accessToken.toString();


    Map<String, String> headers2 = {
      "Authorization": "OAuth $token2"
      };



    final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/consultaProducto?comercioID=$comercioId';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultaProducto?comercioID=$comercioId';
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

class ProductoDetalleArg {
  final String idProducto;
  final String nombre;
  final String descripcion;
  final String foto;
  final String precio1;
  final String cantidad1;
  final String precio2;
  final String cantidad2;
  final String precio3;
  final String cantidad3;
  final String stock;
  final String unidad;
  final String unidad2;
  final String unidad3;
  final String comercioId;
  final String mercadoId;
  final String userId;
  final double calidad;
  final String categoria;
  final String unidadId;
  final String fotoUser;
  final String nombreUser;
  final String numNave;
  final String comercioPuesto;
  final String comercioCuit;
  final String comercioTelefono;
  final String comercioMail;
  final String comercioNombre;
  


  ProductoDetalleArg(this.idProducto, this.nombre,this.descripcion,this.foto,this.precio1,this.cantidad1,this.precio2,this.cantidad2,this.precio3,this.cantidad3,
  this.stock,this.unidad,this.unidad2,this.unidad3,this.comercioId,this.mercadoId,this.userId,this.calidad,this.categoria,this.unidadId,this.fotoUser,this.nombreUser,
  this.numNave,this.comercioPuesto,this.comercioCuit,this.comercioTelefono,this.comercioMail,this.comercioNombre);
}