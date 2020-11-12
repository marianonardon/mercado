import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';
import 'package:flutter_login_ui/src/pages/vendedor_prod_serv.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'carrito_db.dart';






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




class PuestoProductosListView extends StatefulWidget {
  PuestoProductosListView(this.categoriaId,this.mercadoId,this.comercioId,this.globalKey);
  
  final String categoriaId;
  final String mercadoId;
  final String comercioId;
  final globalKey;

  @override
  _PuestoProductosListViewState createState() => _PuestoProductosListViewState(categoriaId,mercadoId,comercioId,globalKey);
}

class _PuestoProductosListViewState extends State<PuestoProductosListView> {
   _PuestoProductosListViewState(this.categoriaId,this.mercadoId,this.comercioId,this.globalKey);

  final String categoriaId;
  final String mercadoId;
  final String comercioId;
  final globalKey;
  @override
  Widget build(BuildContext context){
    return FutureBuilder<List<Producto>>(
      future: fetchProductos(comercioId,categoriaId,mercadoId),
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
                     SizedBox(height:media.size.height * 0.13),
                     Image(
                       height: media.size.height * 0.45,
                       image: AssetImage('assets/img/SinProductos.gif'),
                     ),
                    Text(
                    'No existen productos', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(98, 114, 123, 1),
                      fontSize: 24.0, fontWeight: FontWeight.w600,
                      ))                 
                    ),
                    Text(
                    'para este puesto', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(98, 114, 123, 1),
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
                        data[index].productoID,data[index].categoriaID,data[index].tipoUnidadID,data[index].comercioPuesto,data[index].comercioNumNave,
                        globalKey,context);
        });
  }

    Widget _crearLista(String title,String prodDesc, String imagen,String precio1,String precio2,String precio3,String cantidad1,String cantidad2,String cantidad3, String comercio, String unidad,double ratingProd,comercioId,String stock,String productoID, String categoriaId,String unidadId,
    comercioPuesto,comecioNumNave,globalKey,context) {
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
           comercioPuesto,comecioNumNave,globalKey,context)
          ],
        ),
      ),
    );
  }

  Widget _crearTarjetas(title,prodDesc,imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioId,stock,productoID,categoriaId,unidadId,
  comercioPuesto,comecioNumNave,globalKey,context) {
 MediaQueryData media = MediaQuery.of(context);
  String speso1;
  String unidad1;
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
                        GestureDetector(
                          onTap: () {
                                 Navigator.pushNamed(context, 'detalleProdComp', arguments: ProductoDetalleArg('', title,prodDesc,imagen,precio1,cantidad1,precio2,cantidad2,
                                  precio3,cantidad3,stock,unidad1,unidad2,unidad3,comercioId,mercadoId,'',ratingProd,categoriaId,'','','',
                                  '','','','','','',false));

                         },

                            child: Column(
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
                        ),
                        SizedBox(width: 15.0),
                        GestureDetector(
                          onTap: () {
                                 Navigator.pushNamed(context, 'detalleProdComp', arguments: ProductoDetalleArg('', title,prodDesc,imagen,precio1,cantidad1,precio2,cantidad2,
                                  precio3,cantidad3,'',unidad1,unidad2,unidad3,comercioId,mercadoId,'',ratingProd,categoriaId,'','','',
                                  '','','','','','',false));

                         },

                            child: Container(
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
                        ),
                        GestureDetector(
                onTap: () async {
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
                             _showModalSheet(title,imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioPuesto,comecioNumNave,comercioId,mercadoId,productoID,stock,globalKey,context);
                          }
                      } else {
                        
                          _showModalSheet(title,imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioPuesto,comecioNumNave,comercioId,mercadoId,productoID,stock,globalKey,context);
              
                      }

                  }else {
                      _showModalSheet(title,imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioPuesto,comecioNumNave,comercioId,mercadoId,productoID,stock,globalKey,context);

                  
                  }},


                child: Icon(Icons.add_box,size: 35.0, color:Color.fromRGBO(0, 255, 208, 1))) 
                        ],
                    ),
                 ],
               ),
            ),
        );
  }

  Future<void> _showModalSheet(title,imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioPuesto,comercioNave,comercioId,mercadoId,productoId,stock,globalKey,context) async {

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
                          content: Text('Este producto no posee stock para dicha cantidad'),
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
                          globalKey.currentState.showSnackBar(snackBarError);

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
                          globalKey.currentState.showSnackBar(snackBar);

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

  

  Future<List<Producto>> fetchProductos(comercioId,categoriaId,mercadoId) async { 

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



    final mercadosListAPIUrl = 'https://agilemarket.com.ar/rest/consultaProducto?comercioID=$comercioId&categoriaID=$categoriaId&mercadoID=$mercadoId';
    final mercadosListAPIUrlQA = 'https://apps5.genexus.com/Id6a4d916c1bc10ddd02cdffe8222d0eac/rest/consultaProducto?comercioID=$comercioId&categoriaID=$categoriaId&mercadoID=$mercadoId';
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

  