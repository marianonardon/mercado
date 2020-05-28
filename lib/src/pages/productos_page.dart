import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:google_fonts/google_fonts.dart';


class ProductosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(29, 233, 182, 1),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {}
          )
        ],),
      backgroundColor: Colors.white,
      body: Container(
          child: SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 10.0),
                Text('  Recomendados',style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                        fontSize: 20.0, fontWeight: FontWeight.w600,
                        ))),
                SizedBox(height: 15.0),
                ProductosListViewHorizontal(),
                Text('  Lista de productos',style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                        fontSize: 20.0, fontWeight: FontWeight.w600,
                        ))),

                Container(child: ProductosListView()),
              ],
            ),
          ),
      ),
      bottomNavigationBar: _bottomNavigationBar(context)
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

  
}