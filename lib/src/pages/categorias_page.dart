import 'package:flutter/material.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_login_ui/src/pages/categorias_serv.dart';
import 'package:provider/provider.dart';

import '../../login_state.dart';


class CategoriasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String nombre;
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
                Icon(Icons.search),
                Text('Buscar productos'),]),

              onTap: () {Navigator.pushNamed(context, 'productos');},
            ),
            ListTile(
              title: Row(
                children: [
                Icon(Icons.local_grocery_store),
                Text('Carrito'),]),

              onTap: () {Navigator.pushNamed(context, 'carrito');},
            ),
            ListTile(
              title: Row(
                children: [
                Icon(Icons.local_grocery_store),
                Text('Logout'),]),

              onTap: () {Provider.of<LoginState>(context).logout();
                         Navigator.pushNamed(context, 'login');},
            ),
          ],
        ),
      ),
      
    );
  }
  
}