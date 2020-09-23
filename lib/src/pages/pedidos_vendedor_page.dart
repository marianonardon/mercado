

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';
import 'package:flutter_login_ui/src/providers/pedido_vendedor_provider.dart';
import 'package:flutter_login_ui/src/providers/pedidos_comprador_provider.dart';
import 'package:flutter_login_ui/src/providers/productos_provider.dart';
import 'package:flutter_login_ui/src/widgets/listado_pedidods_vendedor.dart';
import 'package:flutter_login_ui/src/widgets/listado_pedidos_comprador.dart';
import 'package:flutter_login_ui/src/widgets/listado_productos.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'categorias_serv.dart';
import 'combo_puestos.dart';
import 'mercados_serv.dart';





class PedidosVendedorPage extends StatefulWidget {
  @override
  _PedidosVendedorPageState createState() => _PedidosVendedorPageState();
}

class _PedidosVendedorPageState extends State<PedidosVendedorPage> {
  Function siguientePagina;

  final pedidosProvider = new PedidosVendedorProvider();

  final _scrollController = new ScrollController(
          initialScrollOffset: 200.0,
          keepScrollOffset:true
        );
  int _index = 2;
  @override
  Widget build(BuildContext context) {

    final PuestoArguments args = ModalRoute.of(context).settings.arguments;


    return WillPopScope(
      onWillPop: () async { Navigator.of(context);
      return true;},
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mis pedidos',style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600))),
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
                  _listaProductos(args.idComercio),
                ],
              ),
            ),
        ),
        //bottomNavigationBar: _bottomNavigationBar(context)
      ),
    );
  }

 
  _listaProductos(comercioId) {
    return Container(
      child: FutureBuilder<List<PedidoComprador>>(
      future: pedidosProvider.fetchPedidosVendedor(comercioId),
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
                    'No existen pedidos', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(98, 114, 123, 1),
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
          
          return ListadoProductosVendedor(
            pedidos: data,
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