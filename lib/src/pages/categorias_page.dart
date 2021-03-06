import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/mercados_serv.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_login_ui/src/pages/categorias_serv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../login_state.dart';


class CategoriasPage extends StatefulWidget {
  @override
  _CategoriasPageState createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  String idUser,externalId2;
  int _index = 0;
  bool yaPaso = false;
  
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);

     final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    
   // final String userId = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      onWillPop: () async { Navigator.pushNamed(context, 'mercado');
      return true;},
          child: Scaffold(
        appBar: AppBar(
          title: Text('Inicio',style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600))),
          backgroundColor: Color.fromRGBO(29, 233, 182, 1),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.filter_list, color: Colors.white),
              onPressed: () { Navigator.pushNamed(context, 'buscarProducto', arguments: ProductosArguments('',args.mercadoId,'',args.userId,args.nombre,args.foto,'',''));


              }
            ),]

        ),
        backgroundColor: Colors.white,
        body: Container(
          
        
           child: CategoriasListView(args.mercadoId,args.userId,args.nombre,args.foto)
        ),
        bottomNavigationBar: _bottomNavigationBar(context),

        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius:BorderRadius.circular(50.0),
                      child: Container(
                        width: media.size.width * 0.22,
                        child: Image(image: NetworkImage(args.foto),
                        fit: BoxFit.cover),
                      )
                    ),
                    SizedBox(width:15.0),
                    Text(
                      args.nombre, style: GoogleFonts.roboto(textStyle:TextStyle(color:Colors.white,
                        fontSize: 16.0, fontWeight: FontWeight.w600,
                        ))                 
                      ),
                    

                  ],
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(16, 32, 39, 1),
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                  Icon(Icons.home),
                  SizedBox(width:10.0),
                  Text('Home',style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                        fontSize: 14.0, fontWeight: FontWeight.w600,
                        ))),]),

                onTap: () {Navigator.pushNamed(context, 'mercado');},
              ),
              /* ListTile(
                title: Row(
                  children: [
                  Icon(Icons.local_grocery_store),
                  Text('Carrito'),]),

                onTap: () {Navigator.pushNamed(context, 'carrito');},
              ), */

              
               ListTile(
                title: Row(
                  children: [
                  Icon(Icons.exit_to_app),
                  SizedBox(width:10.0),
                  Text('Logout',style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                        fontSize: 14.0, fontWeight: FontWeight.w600,
                        ))),]),

                onTap: () {Provider.of<LoginState>(context).logout();
                           Navigator.pushNamed(context, '/');},
              ),
            ],
          ),
        ),
        
      ),
    );


   
        
          
  
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

  

     Widget datosUsuario() {

      SharedPreferences.getInstance().then((prefs) {
       String externalId2 = prefs.getString('usuarioId');
        setState(() {
                idUser = externalId2;
              }); 
          });
       }

}

