

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:flutter_login_ui/src/providers/pedidos_comprador_provider.dart';
import 'package:flutter_login_ui/src/providers/productos_provider.dart';
import 'package:flutter_login_ui/src/widgets/listado_pedidos_comprador.dart';
import 'package:flutter_login_ui/src/widgets/listado_productos.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'categorias_serv.dart';
import 'combo_puestos.dart';
import 'mercados_serv.dart';





class PedidosCompradorPage extends StatefulWidget {
  @override
  _PedidosCompradorPageState createState() => _PedidosCompradorPageState();
}

class _PedidosCompradorPageState extends State<PedidosCompradorPage> {
  Function siguientePagina;

  final pedidosProvider = new PedidosCompradorProvider();

  final _scrollController = new ScrollController(
          initialScrollOffset: 200.0,
          keepScrollOffset:true
        );
  int _index = 2;
  bool yaPaso = false;
  
  @override
  Widget build(BuildContext context) {

    final ProductosArguments args = ModalRoute.of(context).settings.arguments;


    return WillPopScope(
      onWillPop: () async { Navigator.pushNamed(context, 'categorias', arguments: ScreenArguments(args.userId, args.nombreUser, args.fotoUser,args.mercadoId));
      return true;},
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mis pedidos',style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600))),
          backgroundColor: Color.fromRGBO(29, 233, 182, 1),
           leading: new IconButton(
          icon: new Icon(Icons.chevron_left, size:35),
          onPressed: () => Navigator.pushNamed(context, 'categorias', arguments: ScreenArguments(args.userId, args.nombreUser, args.fotoUser,args.mercadoId))),
          
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
                  //Container(child: ProductosListView(args.categoriaId,args.mercadoId,''))
                  _listaProductos(),
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
            if(_index == 0) {
              yaPaso = true;
              Navigator.pushNamed(context, 'productos',arguments: ProductosArguments(args.categoriaId, args.mercadoId,'',args.userId,args.nombreUser,args.fotoUser,args.categoriaNombre,''));
            }
            if(_index == 1) {
              yaPaso = true;
              Navigator.pushNamed(context, 'carrito',arguments: ProductosArguments(args.categoriaId, args.mercadoId,'',args.userId,args.nombreUser,args.fotoUser,args.categoriaNombre,''));
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

  _listaProductos() {
    return Container(
      child: FutureBuilder<List<PedidoComprador>>(
      future: pedidosProvider.fetchPedidosComprador(),
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
                    'No existen pedidos generados', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(98, 114, 123, 1),
                      fontSize: 24.0, fontWeight: FontWeight.w600,
                      ))                 
                    ),
                    
                     

                  ]
                )
                
                ),
            );
            //}
          } else {
          List<PedidoComprador> data = snapshot.data;
          
          return ListadoProductosComprador(
            pedidos: data,
            yaPaso: yaPaso,
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