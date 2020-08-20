import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/vendedor_prod_serv.dart';
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';
import 'package:google_fonts/google_fonts.dart';

class DetalleProductoComprador extends StatefulWidget {
  @override
  _DetalleProductoCompradorState createState() => _DetalleProductoCompradorState();
}

class _DetalleProductoCompradorState extends State<DetalleProductoComprador> {
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
      onWillPop: () async { Navigator.pop(context);
      return true;},
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
                                                  width: media.size.width * 0.6,
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
                                                  width: media.size.width * 0.60,
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
           ]
               )
              )
          ),
        
      ),
    );
  }

}


