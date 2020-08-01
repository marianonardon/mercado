

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'categorias_serv.dart';
import 'combo_puestos.dart';
import 'mercados_serv.dart';





class ProductosPage extends StatefulWidget {
  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  @override
  Widget build(BuildContext context) {


    final ProductosArguments args = ModalRoute.of(context).settings.arguments;

    

    return WillPopScope(
      onWillPop: () async { Navigator.pushNamed(context, 'categorias', arguments: ScreenArguments(args.userId, args.nombreUser, args.fotoUser,args.mercadoId));
      return true;},
      child: Scaffold(
        appBar: AppBar(
          title: Text(args.categoriaNombre,style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600))),
          backgroundColor: Color.fromRGBO(29, 233, 182, 1),
          leading: new IconButton(
          icon: new Icon(Icons.chevron_left, size:35),
          onPressed: () => Navigator.pushNamed(context, 'categorias', arguments: ScreenArguments(args.userId, args.nombreUser, args.fotoUser,args.mercadoId))),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () { Navigator.pushNamed(context, 'buscarProducto', arguments: ProductosArguments(args.categoriaId,args.mercadoId,'',args.userId,args.nombreUser,args.fotoUser,args.categoriaNombre));


              }
            ),
            IconButton(
              icon: Icon(Icons.filter_list, color: Colors.white),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Center(child: Text('Filtro por puesto',
                    textAlign: TextAlign.center,)),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right:0.0),
                        child: Column(
                          children: <Widget>[
                            ComboPuesto(args.mercadoId),
                            SizedBox(height: 10.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //SizedBox(width: media.size.width * 0.2,),
                                FlatButton(
                                  color: Color.fromRGBO(29, 233, 182, 1),
                                  onPressed: () async {
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    String puestoId = prefs.getString('idPuesto');
                                    if (puestoId != '') {
                                    Navigator.pushNamed(context, 'puestoProd', arguments: ProductosPuestoArguments(args.categoriaId,args.mercadoId,puestoId));
                                    //Navigator.pop(context);
                                    setState((){});}
                                    
                                    //String productoId2;
                                    //productoId2 = await deleteProducto(args.idProducto,args);
                                  },
                                  child: Text('Buscar'),
                                  textColor: Colors.black,
                                
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                    ],
                    backgroundColor: Colors.white

                ),
                barrierDismissible: true,
                  ).then((_) => setState((){}));

              }
            ),
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
                  
                  ProductosListViewHorizontal(args.categoriaId,args.mercadoId),
                  

                  Container(child: ProductosListView(args.categoriaId,args.mercadoId,''))
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

class ProductosPuestoArguments {
  final String categoriaIdProd;
  final String mercadoIdProd;
  final String puestoId;



  ProductosPuestoArguments(this.categoriaIdProd, this.mercadoIdProd,this.puestoId);
}