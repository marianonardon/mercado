

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:flutter_login_ui/src/providers/productos_provider.dart';
import 'package:flutter_login_ui/src/widgets/listado_pedidos_comprador.dart';
import 'package:flutter_login_ui/src/widgets/listado_productos.dart';
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
  Function siguientePagina;
  final productosProvider = new ProductosProvider();

  final _scrollController = new ScrollController(
          initialScrollOffset: 200.0,
          keepScrollOffset:true
        );
  int _index = 0;
  final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    final ProductosArguments args = ModalRoute.of(context).settings.arguments;

    productosProvider.fetchProductos(args.categoriaId,args.mercadoId,'');

    _scrollController.addListener(() {
            if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 20) {
              siguientePagina = productosProvider.fetchProductos;
              siguientePagina(args.categoriaId,args.mercadoId,'');
              //ProductosListView(args.categoriaId,args.mercadoId,'').siguientePagina();
            }
          });


    

    

    return WillPopScope(
      onWillPop: () async { Navigator.pushNamed(context, 'categorias', arguments: ScreenArguments(args.userId, args.nombreUser, args.fotoUser,args.mercadoId));
      return true;},
      child: Scaffold(
        key: globalKey,
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
                controller:_scrollController ,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  
                  ProductosListViewHorizontal(args.categoriaId,args.mercadoId,globalKey),
                  

                  //Container(child: ProductosListView(args.categoriaId,args.mercadoId,''))
                  _listaProductos(context),
                ],
              ),
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
            if(_index == 1) {
              Navigator.pushNamed(context, 'carrito',arguments: ProductosArguments(args.categoriaId, args.mercadoId,'',args.userId,args.nombreUser,args.fotoUser,args.categoriaNombre));
            }
            },
            
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

  _listaProductos(context) {
    return Container(
      child: StreamBuilder<List<Producto>>(
      stream: productosProvider.productosStream,
      // fetchProductos(widget.categoriaId,widget.mercadoId,widget.productoBuscado),
      builder: (context, AsyncSnapshot<List> snapshot) {
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
          
          return ListadoProductos(
            productos: data,
            globalKey: globalKey,
            //siguientePagina: productosProvider.fetchProductos,
          );
          /* return ListadoProductosVendedor(
            productos: data,
            //siguientePagina: productosProvider.fetchProductos,
          ); */
            }
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        MediaQueryData media = MediaQuery.of(context,);
        return Center(
          heightFactor: media.size.height * 0.025,
          child: CircularProgressIndicator());
      },
    ),
    );
  }


}

class ProductosPuestoArguments {
  final String categoriaIdProd;
  final String mercadoIdProd;
  final String puestoId;



  ProductosPuestoArguments(this.categoriaIdProd, this.mercadoIdProd,this.puestoId);
}