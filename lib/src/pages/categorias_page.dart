import 'package:flutter/material.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_login_ui/src/pages/categorias_serv.dart';


class CategoriasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio',style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600))),
        backgroundColor: Color.fromRGBO(0, 255, 208, 1),

      ),
      backgroundColor: Colors.white,
      body: Container(
        
      
         child: CategoriasListView()
      )
      
    );
  }
}