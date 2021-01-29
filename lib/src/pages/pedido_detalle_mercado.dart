

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:flutter_login_ui/src/providers/pedido_detalle_provider.dart';
import 'package:flutter_login_ui/src/providers/pedidos_comprador_provider.dart';
import 'package:flutter_login_ui/src/providers/productos_provider.dart';
import 'package:flutter_login_ui/src/widgets/listado_pedido_detalle_mercado.dart';
import 'package:flutter_login_ui/src/widgets/listado_pedido_mercado.dart';

import 'package:flutter_login_ui/src/widgets/listado_pedidos_detalle.dart';
import 'package:flutter_login_ui/src/widgets/listado_productos.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'categorias_serv.dart';
import 'combo_puestos.dart';
import 'mercados_serv.dart';





class PedidosDetalleMercadoPage extends StatefulWidget {
  @override
  _PedidosDetallePageState createState() => _PedidosDetallePageState();
}

class _PedidosDetallePageState extends State<PedidosDetalleMercadoPage> {


  final pedidosDetalleProvider = new PedidosDetalleProvider();

  final _scrollController = new ScrollController(
          initialScrollOffset: 200.0,
          keepScrollOffset:true
        );

  int _index = 0;
  bool yaPaso = false;
  @override
  Widget build(BuildContext context) {

    //final PedidoArguments args = ModalRoute.of(context).settings.arguments;


    return WillPopScope(
      onWillPop: () async { Navigator.of(context);
      return true;},
      child: Scaffold(
        appBar: AppBar(
          title: Text('Reserva Detalle',style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600))),
          backgroundColor: Color.fromRGBO(29, 233, 182, 1),
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
                  _listaPedidosDetalle(),
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

        currentIndex: _index,
        onTap: (newIndex) { setState(() => _index = newIndex);
            if(_index == 0) {
              yaPaso = true;
              Navigator.pushNamed(context, 'Mercado');
            }
            if(_index == 1) {
              yaPaso = true;
              //Navigator.pushNamed(context, 'carrito',arguments: ProductosArguments(args.categoriaId, args.mercadoId,'',args.userId,args.nombreUser,args.fotoUser,args.categoriaNombre,''));
            }
            },
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

  _listaPedidosDetalle() {
    final PedidoArguments args = ModalRoute.of(context).settings.arguments;
    return Container(
      child: FutureBuilder<PedidoDetalle>(
      future: pedidosDetalleProvider.fetchPedidosDetalle(args.pedidoComercioID,args.pedidoID),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          
          PedidoDetalle data = snapshot.data;
          
          return ListadoPedidosDetalleMercado(
            pedidos: data,
            //siguientePagina: productosProvider.fetchProductos,
          );
          /* return ListadoProductosVendedor(
            productos: data,
            //siguientePagina: productosProvider.fetchProductos,
          ); */
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

class PedidoDetalleArguments {
  final String pedidoId;
  final String pedidoComercioId;



  PedidoDetalleArguments(this.pedidoId, this.pedidoComercioId);
}