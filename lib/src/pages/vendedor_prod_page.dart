

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/vendedor_prod_serv.dart';
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_login_ui/src/pages/mercados_serv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../login_state.dart';


class VendedorProductosPage extends StatefulWidget {
  
  @override
  _VendedorProductosPageState createState() => _VendedorProductosPageState();
}

class _VendedorProductosPageState extends State<VendedorProductosPage> {
  
  @override
  Widget build(BuildContext context) {
        final PuestoArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.pushNamed(context, 'altaProd', arguments: PuestoArguments(args.userId,args.nombre,args.foto,args.mercadoId,args.idComercio,args.numNave,
        args.comercioPuesto,args.comercioCuit,args.comercioTelefono,args.comercioMail,args.comercioNombre));},

        backgroundColor: Color.fromRGBO(29, 233, 182, 1),
        child: Icon(Icons.add, color: Colors.black, size: 35.0,),
        ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Mi Puesto',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
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
                Container(child: VendedorProductosListView(args.idComercio,args.mercadoId,args.userId,args.foto,args.nombre,args.numNave,args.comercioPuesto,args.comercioCuit,
                args.comercioTelefono,args.comercioMail,args.comercioNombre)),
              ],
            ),
          ),
      ),
      //bottomNavigationBar: _bottomNavigationBar(context),
     drawer: 
      Drawer(
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
                Icon(Icons.store),
                Text('Mis puestos'),]),

              onTap: () {Navigator.pushNamed(context, 'puestos',arguments: ScreenArguments(args.userId,args.nombre,args.foto,args.mercadoId));},
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