import 'package:flutter/material.dart'; 
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
    
    final String userId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio',style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600))),
        backgroundColor: Color.fromRGBO(29, 233, 182, 1),

      ),
      backgroundColor: Colors.white,
      body: Container(
        
      
         child: CategoriasListView()
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
              child: Text('Fernando' , style: TextStyle(color:Colors.white,)),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            ListTile(
              title: Row(
                children: [
                Icon(Icons.home),
                Text('Home'),]),

              onTap: () {Navigator.pushNamed(context, 'mercado');},
            ),
            ListTile(
              title: Row(
                children: [
                Icon(Icons.search),
                Text('Buscar productos'),]),

              onTap: () {Navigator.pushNamed(context, 'categorias');},
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
                Text('Ir perfil vendedor'),]),

              onTap: () {Navigator.pushNamed(context, 'puestos',arguments: userId);},
            ),
             ListTile(
              title: Row(
                children: [
                Icon(Icons.exit_to_app),
                Text('Logout'),]),

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