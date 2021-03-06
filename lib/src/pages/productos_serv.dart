import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_login_ui/src/pages/carrito_db.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_login_ui/src/pages/vendedor_prod_serv.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:optimized_cached_image/optimized_cached_image.dart';
//import 'package:optimized_cached_image/widgets.dart';



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
  final String comercioPuesto;
  final String comercioNumNave;
  final String comercioCalificacion;
  final String mercadoID;
  final String mercadoNombre;
  final bool   productoDestacado;
  final List<Precio> precios;


  Producto({this.productoID, this.productoNombre, this.productoDescripcion, this.productoStock,
          this.productoCalidad, this.productoFoto,this.categoriaID, this.categoriaNombre, this.tipoUnidadID,
          this.tipoUnidadNombre, this.comercioID, this.comercioNombre,this.comercioPuesto,this.comercioNumNave,this.comercioCalificacion, this.mercadoID,
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
      comercioPuesto: parsedJson['comercioPuesto'],
      comercioNumNave: parsedJson['comercioNumNave'],
      comercioCalificacion: parsedJson['comercioCalificacion'],
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
 bool productoValidacion = true;
 String puestoNave;
 String puestoPuesto;

class ProductosListView extends StatefulWidget {
  ProductosListView(this.categoriaId, this.mercadoId,this.productoBuscado);
  final String categoriaId;
  final String mercadoId;
  final String productoBuscado;
  Function siguientePagina;

  @override
  _ProductosListViewState createState() => _ProductosListViewState();
}

class _ProductosListViewState extends State<ProductosListView> {

  final _scrollController = new ScrollController(
          initialScrollOffset: 200.0,
          keepScrollOffset:false
        );

  

  @override
  Widget build(BuildContext context){
    final _screenSize = MediaQuery.of(context).size;

    /* _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 ) {
        print('cargar mas productos');
        widget.siguientePagina();
      }
    }); */
    fetchProductos(widget.categoriaId, widget.mercadoId, widget.productoBuscado);
    


    
    
    return StreamBuilder<List<Producto>>(
      stream: productosStream,
      // fetchProductos(widget.categoriaId,widget.mercadoId,widget.productoBuscado),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if(snapshot.requireData.isEmpty){
/*             if (productoValidacion == true) {
              return Container();
            } else { */
            return Center(
              child: Container(
                child: Column(
                   children: <Widget>[
                     Image(
                       image: AssetImage('assets/img/SinProductos.gif'),
                     ),
                    Text(
                    'No existen productos', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(98, 114, 123, 1),
                      fontSize: 24.0, fontWeight: FontWeight.w600,
                      ))                 
                    ),
                    Text(
                    'para estos filtros', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(98, 114, 123, 1),
                      fontSize: 24.0, fontWeight: FontWeight.w600,
                      ))                 
                    ),
                     

                  ]
                )
                
                ),
            );
            //}
          } else {
          List<Producto> data = snapshot.data;
          siguientePagina: fetchProductos;
          return Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              Text('  Lista de productos',style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                fontSize: 16.0, fontWeight: FontWeight.w600,
                ))),
              _productosListView(data,context),
            ],
          );}
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        MediaQueryData media = MediaQuery.of(context,);
        return Center(
          heightFactor: media.size.height * 0.025,
          child: CircularProgressIndicator());
      },
    );
  }

     ListView _productosListView(data,context)  {
       MediaQueryData media = MediaQuery.of(context,);
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: data.length,
        controller: _scrollController,
        itemBuilder: (context, index)   {
          

         
          
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
            foto = 'https://res.cloudinary.com/agilemarket/image/upload/v1594599858/m3wh5dxmlwmyjbpit3cr.png';
          }else{
            
            foto = data[index].productoFoto;}
          return _crearLista(data[index].productoNombre,
                        foto,preciox1,preciox2,preciox3,cantidad1,cantidad2,cantidad3,
                        data[index].comercioNombre,
                        data[index].tipoUnidadNombre, data[index].productoCalidad,data[index].comercioID,data[index].comercioPuesto,data[index].productoDescripcion,
                        data[index].productoStock,data[index].comercioNumNave,context);
        });
  }

    Widget _crearLista(String title, String imagen,String precio1,String precio2,String precio3,String cantidad1,String cantidad2,String cantidad3, String comercio, String unidad,double ratingProd,String comercioId, String comercioPuesto,descripcion,stock,comercioNave, context) {
    MediaQueryData media = MediaQuery.of(context);
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Container(
            
              width: media.size.height * 95.0,
          //   height: 500.0, */
            child: Column(
              children: <Widget>[
                
              //  _crearTitulo(),
                SizedBox(height: 8.0),
               _crearTarjetas(title, imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioId,comercioPuesto,descripcion,stock,comercioNave,context)
              ],
            ),
          ),
        ),
      ],
    );
  }

   _crearTarjetas(title,imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioId,comercioPuesto,descripcion,stock,comercioNave,context) {

/*     String puestos;
    List<Puesto> data;
    Widget obtenerPuesto(){
   // puestos = await _fetchPuestos(comercioId);
    FutureBuilder<List<Puesto>>(
       future: _fetchPuestos(comercioId),
       builder: (context, snapshot){
         if(snapshot.hasData) {
          List<Puesto> data = snapshot.data;
           return Container();
           }
       }
      );}

      obtenerPuesto(); */

/*    puestos = data[0].comercioPuesto;    */
   MediaQueryData media = MediaQuery.of(context); 
  
  String unidad1;
  String speso1;
  String unidad2;
  String unidad3;
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
    padding: EdgeInsets.only(left:15.0),
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
              GestureDetector(
                onTap: () {
                Navigator.pushNamed(context, 'detalleProdComp', arguments: ProductoDetalleArg('', title,descripcion,imagen,precio1,cantidad1,precio2,cantidad2,
                                  precio3,cantidad3,stock,unidad1,unidad2,unidad3,comercioId,widget.mercadoId,'',ratingProd,widget.categoriaId,'','','',
                                  '',comercioPuesto,'','','','',false,''));

              },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: 
                      /* Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CachedNetworkImage('https://pbs.twimg.com/profile_images/945853318273761280/0U40alJG_400x400.jpg'),
          ) */
                      
                      
                      
                      /* FadeInImage(
                      height: 55  ,
                      width: 55,
                      fit: BoxFit.fill,
                      image: NetworkImage(imagen,scale: 0.1),
                      

                     placeholder: AssetImage('assets/img/original.gif'), */
                     /* MeetNetworkImage(
                        height: 55,
                        width: 55,
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.low,
                        
                        imageUrl:
                            imagen,
                        loadingBuilder: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                        errorBuilder: (context, e) => Center(
                              child: Text('Error appear!'),
                            ),
                      
                    ) */
                    Image.network(imagen,fit: BoxFit.fill,
                    height: 55,
                        width: 55,
                      loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null ? 
                                loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),

                   /*  OptimizedCacheImage(
                         height: 55,
                        fit: BoxFit.fill,
                        width: 55,
                        imageUrl: imagen,
                        placeholder: (context, imagen) => CircularProgressIndicator(),
                        errorWidget: (context, imagen, error) => Icon(Icons.error),
                    ), */
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15.0),
              GestureDetector(
                onTap: () {
                Navigator.pushNamed(context, 'detalleProdComp', arguments: ProductoDetalleArg('', title,descripcion,imagen,precio1,cantidad1,precio2,cantidad2,
                                  precio3,cantidad3,stock,unidad,unidad2,unidad3,comercioId,widget.mercadoId,'',ratingProd,widget.categoriaId,'','','',
                                  '',comercioPuesto,'','','','',false,''));

              },
                child: Container(
                  width: media.size.width * 0.63 ,
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
                           Flexible(
                                child: Text(
                                '$comercio   Puesto:$comercioPuesto', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                  fontSize: 12.0, fontWeight: FontWeight.w400,
                          ))),
                           ),
                          
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
              ),
              /* GestureDetector(
                onTap: () {_showModalSheet(title,imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioPuesto,comercioNave,context);},
                child: Icon(Icons.add_box,size: 35.0, color:Color.fromRGBO(0, 255, 208, 1))) */
            ],
          ),
       ],
     ),
  );
  }

  Future<void> _showModalSheet(title,imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioPuesto,comercioNave,context) async {

      int cantidadProd = 1;
      MediaQueryData media = MediaQuery.of(context);
      String precioProducto;

      var producto = Carrito(
        nombreProducto: title,
        fotoProducto: imagen,
        comercioProducto: comercio,
        cantidadProducto: cantidadProd,
        unidadProducto: unidad,
        precioProducto: precioProducto,
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
                              child: 
                              /* Container(
                                width: 100.0,
                                height: 110.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: CachedNetworkImage(imageUrl: imagen,),
                              ) */
                              
                              
                              
                              FadeInImage(
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
                                      '\$$precio1 x $cantidad1$unidad', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(2, 127, 100, 1),
                                        fontSize: 16.0, fontWeight: FontWeight.w600,
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
                    height: media.size.height * 0.11,
                    width: double.infinity,
                    padding: EdgeInsets.all(13.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(width: 15.0),
                            Text(
                                      comercio, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                        fontSize: 16.0, fontWeight: FontWeight.w600,
                                  ))),

                          ],
                        ),
                        SizedBox(
                          height: media.size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 15.0),
                            Flexible(
                                    child: Text(
                                    'Puesto: $comercioPuesto Nave: $comercioNave', style: GoogleFonts.lato(textStyle:TextStyle(color:Colors.black,
                                      fontSize: 12.0, fontWeight: FontWeight.w400,
                              ))),
                               ),
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
                          height: media.size.height * 0.06,
                          width: media.size.width * 0.18,
                          //padding: EdgeInsets.all(13.0),
                          child: Center(
                            child: Icon(Icons.remove)
                          ),

                        ),
                      ),
                    ),
                    SizedBox(width:20.0),
                    Text( '$cantidad $unidad', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(43, 47, 58, 1),
                                fontSize: 16.0, fontWeight: FontWeight.w600,
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
                          height: media.size.height * 0.06,
                          width: media.size.width * 0.18,
                          //padding: EdgeInsets.all(13.0),
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


                        if (cantidad3 != '') {
                          int cantidadx3 = int.parse(cantidad3);
                          double preciox3   = double.parse(precio3);
                          if (cantidad >= cantidadx3) {
                            setState(() {
                              precioProducto = (preciox3 * cantidadx3).toString();
                            });
                          }else{
                            int cantidadx2 = int.parse(cantidad2);
                            double preciox2   = double.parse(precio2);
                            if (cantidad >= cantidadx2) {
                              setState(() {
                                precioProducto = (preciox2 * cantidadx2).toString();
                              });
                            }else {
                              int cantidadx1 = int.parse(cantidad1);
                              double preciox1   = double.parse(precio1);
                              setState(() {
                                precioProducto = (preciox1 * cantidadx1).toString();
                              });
                            }
                          }
                        }else{
                          if (cantidad2 != '') {
                            int cantidadx2 = int.parse(cantidad2);
                            double preciox2   = double.parse(precio2);
                            if (cantidad >= cantidadx2) {
                              setState(() {
                                precioProducto = (preciox2 * cantidadx2).toString();
                              });
                            }else {
                              int cantidadx1 = int.parse(cantidad1);
                              double preciox1   = double.parse(precio1);
                              setState(() {
                                precioProducto = (preciox1 * cantidadx1).toString();
                              });
                            }
                        }else{
                          int cantidadx1 = int.parse(cantidad1);
                          double preciox1   = double.parse(precio1);
                          setState(() {
                            precioProducto = (preciox1 * cantidadx1).toString();
                          });
                        }
                        }
                        setState(() {
                        producto.cantidadProducto = cantidad;
                        producto.precioProducto   = precioProducto;
                        });
                        //DBProvider().deleteCarrito(1);
                        //DBProvider().insertCarrito(producto);
                        Navigator.pushNamed(context, 'carrito', arguments: title);
                        },
                      child: Container(
                      color: Color.fromRGBO(29, 233, 182, 1),
                      height: media.size.height * 0.07,
                      width: media.size.width * 0.9,
                      //padding: EdgeInsets.all(13.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(width: 15.0),
                                  Text('Agregar producto', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                              fontSize: 14.0, fontWeight: FontWeight.w500,
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
                ),
                    ],
                  ),
              );
              }
            );
          });
  }
  
  List<Producto> _productos = new List();
  
  final _productosStreamController = StreamController<List<Producto>>.broadcast();

  Function(List<Producto>) get productosSink => _productosStreamController.sink.add; 

  Stream<List<Producto>> get productosStream => _productosStreamController.stream;


  void disposeStreams() {
    _productosStreamController?.close();
  }

  Future<List<Producto>> fetchProductos(categoriaId,mercadoId,productoBuscado) async { 

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


    int categoria = int.parse(categoriaId);
    int mercado   = int.parse(mercadoId);
    final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/consultaProducto?categoriaID=$categoria&destacado=0&mercadoID=$mercado&productoNombre=$productoBuscado';
    //final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultaProducto?categoriaID=$categoria&destacado=0&mercadoID=$mercado&productoNombre=$productoBuscado';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultaProducto?pageNumber=1&pageSize=6';

    final response = await http.get('$mercadosListAPIUrl', headers: headers2);

    print('servicio');

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final productos = new Productos.fromJsonList(decodedData);
      final productosLista = productos.items;
      _productos.addAll(productosLista);
      productosSink(_productos);
      return productos.items;
      //List jsonResponse = json.decode(response.body);
      //return jsonResponse.map<dynamic>((mercado) => new Mercados.fromJsonList(mercado));
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}

class ProductosListViewHorizontal extends StatefulWidget {
  ProductosListViewHorizontal(this.categoriaId,this.mercadoId,this.globalKey);
  final String categoriaId;
  final String mercadoId;
  final globalKey;

  @override
  _ProductosListViewHorizontalState createState() => _ProductosListViewHorizontalState();
}

class _ProductosListViewHorizontalState extends State<ProductosListViewHorizontal> {
  @override
  Widget build(BuildContext context) {
  //  Widget productosHorizontal(){
    MediaQueryData media = MediaQuery.of(context);
    return FutureBuilder<List<Producto>>(
      future: fetchProductos(widget.categoriaId,widget.mercadoId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if(snapshot.requireData.isEmpty){
            
              productoValidacion = false;
            
            return Text('');
            
            
          } else {
              productoValidacion = true;
          List<Producto> data = snapshot.data;
          return _crearProductoPageView(data,context);
          }
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Container();
      },
    );
   // };
  }

  Future<List<Producto>> fetchProductos(categoriaId,mercadoId) async {

    String url = "https://agilemarket.com.ar/oauth/access_token";
    String urlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/oauth/access_token';

    Map<String, String> bodyToken = {
      "client_id": "da0d4cd9919d4d80afecf1c56d954633",
      "client_secret": "be70f816716f402b8c02e53daec3e067",
      "scope": "FullControl",
      "username": "admin",
      "password": "wetiteam123",
    };

    Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded"
    };

      Map<String, String> bodyTokenQA = {
      "client_id": "32936ed0b05f48859057b6a2dd5aee6f",
      "client_secret": "915b06d26cdf44f7b832c66fe6e58743",
      "scope": "FullControl",
      "username": "admin",
      "password": "admin123",
    };



    final responseToken = await http.post(url, body: bodyToken, headers: headers);
    final decodedData = json.decode(responseToken.body);
    final token = new Token.fromJsonMap(decodedData);
    String token2 = token.accessToken.toString();


    Map<String, String> headers2 = {
      "Authorization": "OAuth $token2"
      };



    int categoria = int.parse(categoriaId);
    int mercado = int.parse(mercadoId);
    final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/consultaProducto?categoriaID=$categoria&destacado=1&mercadoID=$mercado';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultaProducto?categoriaID=$categoria&destacado=1&mercadoID=$mercado';
    
    final response = await http.get('$mercadosListAPIUrl', headers: headers2);
    print('servicio');

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

  Widget _crearProductoPageView(List<Producto> productos,context) {
    
    MediaQueryData media = MediaQuery.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Text('  Recomendados',style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                fontSize: 16.0, fontWeight: FontWeight.w600,
                ))),
        SizedBox(height: 10.0),
        SizedBox(
          height: media.size.height * 0.28,
          child: PageView.builder(
            pageSnapping: true,
            dragStartBehavior: DragStartBehavior.down,
            controller: PageController(
              viewportFraction: 0.3,
              initialPage: 1
            ),
            itemCount: productos.length,
            itemBuilder: (context, i) => _productoTarjeta(productos[i],context
            )
          ),
          ),

      ],
    );
  }

  Widget _productoTarjeta(Producto producto,context) {

    String foto;
    String preciox1;
    String preciox2;
    String preciox3;
    String cantidad1;
    String cantidad2;
    String cantidad3;
    String unidad1;
    String unidad2;
    String unidad3;
    String speso1;
    String x;
    if((producto.precios.length - 1) >= 2) {
        preciox1 = producto.precios[0].precioProducto;
        preciox2 = producto.precios[1].precioProducto;
        preciox3 = producto.precios[2].precioProducto;
        cantidad1 = producto.precios[0].precioCantidad;
        cantidad2 = producto.precios[1].precioCantidad;
        cantidad3 = producto.precios[2].precioCantidad;
        unidad1 = producto.tipoUnidadNombre;
        unidad2 = producto.tipoUnidadNombre;
        unidad3 = producto.tipoUnidadNombre;
        speso1 = '\$';
        x = 'x';
    }else{
      if ((producto.precios.length - 1) == 1) {
        preciox1 = producto.precios[0].precioProducto;
        preciox2 = producto.precios[1].precioProducto;
        preciox3 = '';
        cantidad1 = producto.precios[0].precioCantidad;
        cantidad2 = producto.precios[1].precioCantidad;
        cantidad3 = '';
        unidad1 = producto.tipoUnidadNombre;
        unidad2 = producto.tipoUnidadNombre;
        unidad3 = '';
        speso1 = '\$';
        x = 'x';
      } else{
        if ((producto.precios.length - 1) == 0) {
          preciox1 = producto.precios[0].precioProducto;
          preciox2 = '';
          preciox3 = '';
          cantidad1 = producto.precios[0].precioCantidad;
          cantidad2 = '';
          cantidad3 = '';
          unidad1 = producto.tipoUnidadNombre;
          unidad2 = '';
          unidad3 = '';
          speso1 = '\$';
          x = 'x';}
          else{
          preciox1 = '';
          preciox2 = '';
          preciox3 = '';
          cantidad1 = '';
          cantidad2 = '';
          cantidad3 = '';
          unidad1 = '';
          unidad2 = '';
          unidad3 = '';
          speso1 = '';
          x = '';

        }
    }
    }

    if (producto.productoFoto == '') {
      foto = 'https://res.cloudinary.com/agilemarket/image/upload/v1594599858/m3wh5dxmlwmyjbpit3cr.png';
    }else{
       foto = producto.productoFoto;}

    String nombrePuesto = producto.comercioNombre;


    return GestureDetector(
        onTap: () {
                  Navigator.pushNamed(context, 'detalleProdComp', arguments: ProductoDetalleArg('', producto.productoNombre,producto.productoDescripcion,
                  producto.productoFoto,preciox1,cantidad1,preciox2,cantidad2,
                                    preciox3,cantidad3,producto.productoStock,unidad1,unidad2,unidad3,'',widget.mercadoId,'',0.0,widget.categoriaId,'','','',
                                    producto.comercioNumNave,producto.comercioPuesto,'','','',producto.comercioNombre,false,''));

                },
          child: Container(
        padding: EdgeInsets.all(7.0),
        child: Column
        (crossAxisAlignment: CrossAxisAlignment.start,
          
          children: <Widget>[

          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(foto),
              height: 88.0,
              width: 100.0,
              fit: BoxFit.cover,
              ),
          ),
          SizedBox(height: 8.0),
          Text(
            producto.productoNombre, style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
              fontSize: 12.0, fontWeight: FontWeight.normal,
              )),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height:3.0),
            Flexible(
              child: Text(
                  '$speso1$preciox1 $x $unidad1 ', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(2, 127, 100, 1),
                    fontSize: 12.0, fontWeight: FontWeight.w600,
              )),
              overflow: TextOverflow.ellipsis,),
            ),
            SizedBox(height:3.0),
            Flexible(
              child: Text(
                  '$nombrePuesto ', textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                    fontSize: 12.0, fontWeight: FontWeight.w600,
              )),
              overflow: TextOverflow.ellipsis,),
            ),
            GestureDetector(
                
                onTap: () async {
                  MediaQueryData media = MediaQuery.of(context);
                  DateTime now = DateTime.now();
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String mercadoHora = prefs.getString('horaMercado');
                  String mercadoHoraFin = prefs.getString('horaMercadoFin');
                  
                  if (mercadoHora != 'Cerrado'){
                    DateTime horaInicio = DateTime.parse(mercadoHora);
                    DateTime horaFin = DateTime.parse(mercadoHoraFin);
                    if(now.hour >= horaInicio.hour){
                        if(now.hour < horaFin.hour){
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              title:  Center(child: Text('DISCULPA!!!')),
                              content:  SizedBox(
                                        width: media.size.width * 0.005,
                                        height: media.size.height * 0.1,
                                        child:  Center(child:  Text('Los pedidos se realizan luego del cierre del Mercado',
                                        textAlign: TextAlign.center,)),
                                    ),
                              backgroundColor: Colors.white

                        ),
                        barrierDismissible: true
                          ).then((_) => setState((){}));
                          } else {
                             _showModalSheet(producto.productoNombre,producto.productoFoto,preciox1,preciox2,preciox3,cantidad1,cantidad2,cantidad3,producto.comercioNombre,unidad1,producto.productoCalidad,producto.comercioPuesto,producto.comercioNumNave,producto.comercioID,producto.mercadoID,producto.productoID,producto.productoStock,context);
                          }
                      } else {
                        
                          _showModalSheet(producto.productoNombre,producto.productoFoto,preciox1,preciox2,preciox3,cantidad1,cantidad2,cantidad3,producto.comercioNombre,unidad1,producto.productoCalidad,producto.comercioPuesto,producto.comercioNumNave,producto.comercioID,producto.mercadoID,producto.productoID,producto.productoStock,context);
              
                      }

                  }else {
                      _showModalSheet(producto.productoNombre,producto.productoFoto,preciox1,preciox2,preciox3,cantidad1,cantidad2,cantidad3,producto.comercioNombre,unidad1,producto.productoCalidad,producto.comercioPuesto,producto.comercioNumNave,producto.comercioID,producto.mercadoID,producto.productoID,producto.productoStock,context);

                  
                  }},
                child: Center(child: Icon(Icons.add_box,size: 30.0, color:Color.fromRGBO(0, 255, 208, 1))))
        ],
        )
      ),
    );
  }

  Future<void> _showModalSheet(title,imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioPuesto,comercioNave,comercioId,mercadoId,productoId,stock,context) async {

      int cantidadProd = 1;
      MediaQueryData media = MediaQuery.of(context);
      String precioProducto;
      double precioUnitario;

      var producto = Carrito(
        nombreProducto: title.toString(),
        fotoProducto: imagen.toString(),
        comercioProducto: comercio.toString(),
        cantidadProducto: cantidadProd,
        unidadProducto: unidad.toString(),
        precioProducto: precioProducto.toString(),
        precioUnitario: 0.0,
        productoId: int.parse(productoId),
        comercioId:int.parse(comercioId),
        mercadoId:int.parse(mercadoId),
        );



      showModalBottomSheet(
          elevation: 300.0,
          context: context,
          builder: (builder) {
            int cantidad = 1;

            cantidadProd = cantidad;
            
            
            return StatefulBuilder(
              builder: (BuildContext context2, StateSetter setState) {
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
                              child: 
                              /* Container(
                                width: 100.0,
                                height: 110.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: CachedNetworkImage(imageUrl: imagen,),
                              ) */
                              
                              
                              
                              FadeInImage(
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
                                      '\$$precio1 x $cantidad1$unidad', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(2, 127, 100, 1),
                                        fontSize: 16.0, fontWeight: FontWeight.w600,
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
                    height: media.size.height * 0.11,
                    width: double.infinity,
                    padding: EdgeInsets.all(13.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(width: 15.0),
                            Text(
                                      comercio, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                        fontSize: 16.0, fontWeight: FontWeight.w600,
                                  ))),

                          ],
                        ),
                        SizedBox(
                          height: media.size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 15.0),
                            Flexible(
                                    child: Text(
                                    'Puesto: $comercioPuesto Nave: $comercioNave', style: GoogleFonts.lato(textStyle:TextStyle(color:Colors.black,
                                      fontSize: 12.0, fontWeight: FontWeight.w400,
                              ))),
                               ),
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
                          height: media.size.height * 0.06,
                          width: media.size.width * 0.18,
                          //padding: EdgeInsets.all(13.0),
                          child: Center(
                            child: Icon(Icons.remove)
                          ),

                        ),
                      ),
                    ),
                    SizedBox(width:20.0),
                    Text( '$cantidad $unidad', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(43, 47, 58, 1),
                                fontSize: 16.0, fontWeight: FontWeight.w600,
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
                          height: media.size.height * 0.06,
                          width: media.size.width * 0.18,
                          //padding: EdgeInsets.all(13.0),
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
                        
                      onTap: () async {


                        if (cantidad3 != '') {
                          int cantidadx3 = int.parse(cantidad3);
                          double preciox3   = double.parse(precio3);
                          if (cantidad >= cantidadx3) {
                            setState(() {
                              precioProducto = (preciox3 * cantidad).toString();
                              precioUnitario = preciox3;
                            });
                          }else{
                            int cantidadx2 = int.parse(cantidad2);
                            double preciox2   = double.parse(precio2);
                            if (cantidad >= cantidadx2) {
                              setState(() {
                                precioProducto = (preciox2 * cantidad).toString();
                                precioUnitario = preciox2;
                              });
                            }else {
                              int cantidadx1 = int.parse(cantidad1);
                              double preciox1   = double.parse(precio1);
                              setState(() {
                                precioProducto = (preciox1 * cantidad).toString();
                                precioUnitario = preciox1;
                              });
                            }
                          }
                        }else{
                          if (cantidad2 != '') {
                            int cantidadx2 = int.parse(cantidad2);
                            double preciox2   = double.parse(precio2);
                            if (cantidad >= cantidadx2) {
                              setState(() {
                                precioProducto = (preciox2 * cantidad).toString();
                                precioUnitario = preciox2;
                              });
                            }else {
                              int cantidadx1 = int.parse(cantidad1);
                              double preciox1   = double.parse(precio1);
                              setState(() {
                                precioProducto = (preciox1 * cantidad).toString();
                                precioUnitario = preciox1;
                              });
                            }
                        }else{
                          if (cantidad1 != '') {
                          int cantidadx1 = int.parse(cantidad1);
                          double preciox1   = double.parse(precio1);
                          setState(() {
                            precioProducto = (preciox1 * cantidad).toString();
                            precioUnitario = preciox1;
                          });
                          
                        } else{
                          setState(() {
                            precioProducto = '';
                            precioUnitario = 0.0;
                          });
                        }
                        }
                        }
                        setState(() {
                        producto.cantidadProducto = cantidad;
                        producto.precioProducto   = precioProducto.toString();
                        producto.precioUnitario = precioUnitario;
                        
                        });
                        
                        //DBProvider().deleteCarrito(1);



                        int stockProducto = int.parse(stock);

                        if(stockProducto < cantidad ){
                            final snackBarError = SnackBar(
                          backgroundColor: Colors.red,
                          content:  Text('Este producto no posee stock para dicha cantidad'),
                          action: SnackBarAction(
                            textColor: Colors.white,
                            label: 'Cerrar',
                            onPressed: () {
                              // Some code to undo the change.
                              },
                            ),
                          );

                        // Find the Scaffold in the widget tree and use
                        // it to show a SnackBar.
                          Navigator.pop(context);
                          widget.globalKey.currentState.showSnackBar(snackBarError);

                        } else {
                          await DBProvider().insertCarrito(producto,stockProducto);
                          final snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Se ha añadido al carrito!'),
                            action: SnackBarAction(
                              textColor: Colors.white,
                              label: 'Cerrar',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          // Find the Scaffold in the widget tree and use
                          // it to show a SnackBar.
                          Navigator.pop(context);
                          widget.globalKey.currentState.showSnackBar(snackBar);

                        }
                        
                        //Navigator.pushNamed(context, 'carrito', arguments: title);
                        },
                      child: Container(
                      color: Color.fromRGBO(29, 233, 182, 1),
                      height: media.size.height * 0.07,
                      width: media.size.width * 0.9,
                      //padding: EdgeInsets.all(13.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(width: 15.0),
                                  Text('Agregar producto', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                              fontSize: 14.0, fontWeight: FontWeight.w500,
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
                ),
                    ],
                  ),
              );
              }
            );
          });
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