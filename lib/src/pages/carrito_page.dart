import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/carrito_serv.dart';
import 'package:flutter_login_ui/src/pages/categorias_serv.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mercados_serv.dart';

class CarritoPage extends StatefulWidget {
  
  @override
  _CarritoPageState createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    final ProductosArguments args = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
      onWillPop: () async { Navigator.pushNamed(context, 'categorias', arguments: ScreenArguments(args.userId, args.nombreUser, args.fotoUser,args.mercadoId));
      return true;},
      child: Scaffold(
        appBar: AppBar(
          title: Text('Carrito', style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600))),
          backgroundColor: Color.fromRGBO(29, 233, 182, 1),
           leading: new IconButton(
            icon: new Icon(Icons.chevron_left, size:35),
            onPressed: () => Navigator.pushNamed(context, 'categorias', arguments: ScreenArguments(args.userId, args.nombreUser, args.fotoUser,args.mercadoId))),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.white),
              onPressed: () {}
            )
          ],),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
           child: Column(
            children: <Widget>[
              Container(
                  color: Colors.white,
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(height: 30.0,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0,0.0,0.0,0.0,),
                          child: Text('Lista de productos', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                                fontSize: 20.0, fontWeight: FontWeight.w500,
                                          ))),
                        ),
                        SizedBox(height: 10.0,),
                        Container(
                          padding: EdgeInsets.only(left:15.0),
                          child: CarritosListView(args.categoriaId, args.mercadoId,args.userId,args.nombreUser,args.fotoUser,args.categoriaNombre),),
                      ],
                    ),
              ),
             
                  SizedBox(height: 15.0)
            ],
          ),
        ),
        bottomNavigationBar: _bottomNavigationBar(context)
      ),
    );
  }

    Widget _bottomNavigationBar(BuildContext context) {

      final ProductosArguments args = ModalRoute.of(context).settings.arguments;
      
    return new Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white,
        primaryColor: Colors.black,
        textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.grey))
      ),
      child: BottomNavigationBar(
        
        currentIndex: _index,
        onTap: (newIndex) { setState(() => _index = newIndex);
            if(_index == 2) {
              Navigator.pushNamed(context, 'pedidosComprador',arguments: ProductosArguments(args.categoriaId, args.mercadoId,'',args.userId,args.nombreUser,args.fotoUser,args.categoriaNombre));
            }
            if(_index == 0) {
              Navigator.pushNamed(context, 'productos',arguments: ProductosArguments(args.categoriaId, args.mercadoId,'',args.userId,args.nombreUser,args.fotoUser,args.categoriaNombre));
            }},
                items: [
                    BottomNavigationBarItem(
                    icon: Icon(Icons.store, size: 25.0),
                    title: Container(),
                    ),
                    BottomNavigationBarItem(
                    icon: Icon(Icons.local_grocery_store, size: 25.0),
                    title: Container()
                    ),
                    BottomNavigationBarItem(
                    icon: Icon(Icons.receipt, size: 25.0),
                    title: Container()
                    ),
                ])
              );
        
              
          }
}