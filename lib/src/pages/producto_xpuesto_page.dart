

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/producto_xpueso_serv.dart';
import 'package:flutter_login_ui/src/pages/productos_page.dart';
import 'package:flutter_login_ui/src/pages/vendedor_prod_serv.dart';
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_login_ui/src/pages/mercados_serv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../login_state.dart';


class ProductoXPuestoPage extends StatefulWidget {
  
  @override
  _ProductoXPuestoPageState createState() => _ProductoXPuestoPageState();
}

class _ProductoXPuestoPageState extends State<ProductoXPuestoPage> {
  
  @override
  Widget build(BuildContext context) {
        final ProductosPuestoArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Productos del puesto ',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                        fontSize: 18.0, fontWeight: FontWeight.w600,
                        )),),
        backgroundColor: Color.fromRGBO(29, 233, 182, 1),
/*         actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {}
          )
        ], */
        ),
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.only(left:0.0),
          child: SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
               // SizedBox(height: 20.0),
                Container(child: PuestoProductosListView(args.categoriaIdProd,args.mercadoIdProd,args.puestoId)),
              ],
            ),
          ),
      ),
      //bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

    Future<Widget> _bottomNavigationBar(BuildContext context) async {
       
      return new Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white,
        primaryColor: Colors.black,
        textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.grey))
      ),
      child: BottomNavigationBar(
        items: [
            BottomNavigationBarItem(
            icon: Icon(Icons.list, size: 30.0),
            title: Container()
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.my_location, size: 30.0),
            title: Container()
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.store, size: 30.0),
            title: Container()
            ),
        ])
      );

      
  }


}