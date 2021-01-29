import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/carrito_serv.dart';
import 'package:flutter_login_ui/src/pages/categorias_serv.dart';
import 'package:google_fonts/google_fonts.dart';

import 'carrito_mercado_serv.dart';
import 'mercados_serv.dart';

class CarritoMercadoPage extends StatefulWidget {
  
  @override
  _CarritoMercadoPageState createState() => _CarritoMercadoPageState();
}

class _CarritoMercadoPageState extends State<CarritoMercadoPage> {
  int _index = 1;
  bool yaPaso = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async { Navigator.pushNamed(context, 'mercado');
      return true;},
      child: Scaffold(
        appBar: AppBar(
          title: Text('Carrito', style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600))),
          backgroundColor: Color.fromRGBO(29, 233, 182, 1),
           leading: new IconButton(
            icon: new Icon(Icons.chevron_left, size:35),
            onPressed: () => Navigator.pushNamed(context, 'mercado')),
          ),
        backgroundColor: Colors.white,
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
                          child: CarritosMercadoListView(),),
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
              yaPaso = true;
              Navigator.pushNamed(context, 'pedidosMercado');
            }
            if(_index == 0) {
              yaPaso = true;
              Navigator.pushNamed(context, 'mercado');
              //Navigator.pushNamed(context, 'carrito',arguments: ProductosArguments(args.categoriaId, args.mercadoId,'',args.userId,args.nombreUser,args.fotoUser,args.categoriaNombre,''));
            }
            },
            
                items: [
                    BottomNavigationBarItem(
                    icon: Icon(Icons.store_mall_directory, size: 25.0),
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