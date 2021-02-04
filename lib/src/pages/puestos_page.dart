import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../login_state.dart';
import 'mercados_serv.dart';

class PuestosPage extends StatefulWidget {
  @override
  _PuestosPageState createState() => _PuestosPageState();
}

class _PuestosPageState extends State<PuestosPage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
      onWillPop: () async { SystemNavigator.pop();
      return true;},
          child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title:  Center(child: Text('Alta de comercio')),
                  content:  SizedBox(
                            width: media.size.width * 0.005,
                            height: media.size.height * 0.1,
                            child:  Center(child:  Text('Para generar un comercio escríbanos al 3517194176',
                            textAlign: TextAlign.center,)),
                        ),
                  backgroundColor: Colors.white

            ),
            barrierDismissible: true
              ).then((_) => setState((){}));
            
            
            
            
            //Navigator.pushNamed(context, 'altaVendedor', arguments: ScreenArguments(args.userId,args.nombre,args.foto,args.mercadoId));
            },
          backgroundColor: Color.fromRGBO(29, 233, 182, 1),
          child: Icon(Icons.add, color: Colors.black, size: 40.0,),
          ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Seleccionar Puesto', style: TextStyle(color: Colors.blueGrey, fontSize: 20.0, fontWeight: FontWeight.bold),),
          iconTheme: IconThemeData(color: Colors.black),
          
          

        ),
        backgroundColor: Colors.white,
        body:  _puestoLista(args),
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
                  color: Colors.black,
                ),
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
        )
    );
          
  }

  Widget _puestoLista(args) {
    return Container(
      
      child: PuestosListView(args),);
  }
}