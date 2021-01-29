import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_ui/src/pages/mercados_serv.dart';

class MercadosPage extends StatefulWidget {
  @override
  _MercadosPageState createState() => _MercadosPageState();
}

class _MercadosPageState extends State<MercadosPage> {
    int _index = 0;
  bool yaPaso = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async { SystemNavigator.pop();
      return true;},
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Seleccionar Mercado', style: TextStyle(color: Colors.blueGrey, fontSize: 20.0, fontWeight: FontWeight.bold),),

        ),
        backgroundColor: Colors.white,
        body:  _mercadoLista(),
        bottomNavigationBar: _bottomNavigationBar(context)),
    );
          
  }

  Widget _mercadoLista() {
    return Container(
      
      child: MercadosListView(),);
  }

  Widget _bottomNavigationBar(BuildContext context) {

      //final ProductosArguments args = ModalRoute.of(context).settings.arguments;
      
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
            if(_index == 1) {
              yaPaso = true;
              Navigator.pushNamed(context, 'carritoMercado');
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

