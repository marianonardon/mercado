

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:flutter_login_ui/src/providers/productos_provider.dart';
import 'package:flutter_login_ui/src/widgets/listado_productos.dart';
import 'package:google_fonts/google_fonts.dart';

import 'categorias_serv.dart';
import 'mercados_serv.dart';





class ProductosResultadoPage extends StatefulWidget {
  @override
  _ProductosResultadoPageState createState() => _ProductosResultadoPageState();
}

class _ProductosResultadoPageState extends State<ProductosResultadoPage> {
  Function siguientePagina;
  final productosProvider = new ProductosProvider();

  final _scrollController = new ScrollController(
          initialScrollOffset: 200.0,
          keepScrollOffset:true
        );
  final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {


    final ProductosArguments args = ModalRoute.of(context).settings.arguments;
    String productoBuscado = args.productoBuscado;

    productosProvider.fetchProductos(args.categoriaId,args.mercadoId,productoBuscado,args.comercioId);

    _scrollController.addListener(() {
            if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 20) {
              siguientePagina = productosProvider.fetchProductos;
              siguientePagina(args.categoriaId,args.mercadoId,productoBuscado,args.comercioId);
              //ProductosListView(args.categoriaId,args.mercadoId,'').siguientePagina();
            }
          });
    

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: globalKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(29, 233, 182, 1),
        leading: new IconButton(
          icon: new Icon(Icons.backspace, size:35),
          onPressed: () {
            if(args.categoriaId == ''){
               Navigator.pushNamed(context, 'categorias', arguments: ScreenArguments(args.userId, args.nombreUser, args.fotoUser,args.mercadoId));
             } else {
               Navigator.pushNamed(context, 'productos', arguments: ProductosArguments(args.categoriaId,args.mercadoId,'',args.userId,args.nombreUser,args.fotoUser,args.categoriaNombre,''));
             }
             }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () { Navigator.pushNamed(context, 'buscarProducto', arguments: ProductosArguments(args.categoriaId,args.mercadoId,'',args.userId,args.nombreUser,args.fotoUser,args.categoriaNombre,''));


            }
          )
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
                SizedBox(height: 20.0),
                Text('  Resultados para: "$productoBuscado"',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(29, 233, 182, 1),
                fontSize: 16.0, fontWeight: FontWeight.bold,
                ))),     
                SizedBox(height: 20.0),      

                _listaProductos(),
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

  _listaProductos() {
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