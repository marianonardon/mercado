

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:google_fonts/google_fonts.dart';

import 'categorias_serv.dart';





class ProductosResultadoPage extends StatefulWidget {
  @override
  _ProductosResultadoPageState createState() => _ProductosResultadoPageState();
}

class _ProductosResultadoPageState extends State<ProductosResultadoPage> {
  @override
  Widget build(BuildContext context) {


    final ProductosArguments args = ModalRoute.of(context).settings.arguments;
    String productoBuscado = args.productoBuscado;
    

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(29, 233, 182, 1),
        leading: new IconButton(
          icon: new Icon(Icons.backspace, size:35),
          onPressed: () => Navigator.pushNamed(context, 'productos', arguments: ProductosArguments(args.categoriaId,args.mercadoId,'',args.userId,args.nombreUser,args.fotoUser,args.categoriaNombre))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () { Navigator.pushNamed(context, 'buscarProducto', arguments: ProductosArguments(args.categoriaId,args.mercadoId,'',args.userId,args.nombreUser,args.fotoUser,args.categoriaNombre));


            }
          )
        ],
        ),
      backgroundColor: Colors.white,
      body: Container(
          child: SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[  
                SizedBox(height: 20.0),
                Text('  Resultados para: "$productoBuscado"',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(29, 233, 182, 1),
                fontSize: 16.0, fontWeight: FontWeight.bold,
                ))),     
                SizedBox(height: 20.0),      

                Container(child: ProductosListView(args.categoriaId,args.mercadoId,args.productoBuscado))
              ],
            ),
          ),
      ),
     // bottomNavigationBar: _bottomNavigationBar(context)
    ),
    );
  }

    Widget _bottomNavigationBar(BuildContext context) {
    return new Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white,
        primaryColor: Colors.black,
        textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.grey))
      ),
      child: BottomNavigationBar(
        items: [
            BottomNavigationBarItem(
            icon: Icon(Icons.store, size: 30.0),
            title: Container()
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store, size: 30.0),
            title: Container()
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.my_location, size: 30.0),
            title: Container()
            ),
        ])
      );

      
  }
}