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
  
  @override
  Widget build(BuildContext context) {

     final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    
   // final String userId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio',style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600))),
        backgroundColor: Color.fromRGBO(29, 233, 182, 1),

      ),
      backgroundColor: Colors.white,
      body: Container(
        
      
         child: CategoriasListView(args.mercadoId)
      ),

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
                      child: Image(image: NetworkImage(args.foto),),
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
                Icon(Icons.store),
                SizedBox(width:10.0),
                Text('Ir perfil vendedor',style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                      fontSize: 14.0, fontWeight: FontWeight.w600,
                      ))),]),

              onTap: () {Navigator.pushNamed(context, 'puestos',arguments: args);},
            ),
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

