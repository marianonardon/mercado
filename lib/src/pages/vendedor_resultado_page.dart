

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/productos_busqueda_vendedor.dart';
import 'package:flutter_login_ui/src/pages/vendedor_prod_serv.dart';
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';
import 'package:flutter_login_ui/src/pages/vendedor_producto_resultado.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_login_ui/src/pages/mercados_serv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../login_state.dart';


class VendedorProductosResultadoPage extends StatefulWidget {
  
  @override
  _VendedorProductosResultadoPageState createState() => _VendedorProductosResultadoPageState();
}

class _VendedorProductosResultadoPageState extends State<VendedorProductosResultadoPage> {
  
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    final PuestoBusquedaArguments args = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
      onWillPop: () async {Navigator.pushNamed(context, 'vendedorProd', arguments: PuestoArguments(args.userId,args.nombre,args.foto,args.mercadoId,args.idComercio,args.numNave,
          args.comercioPuesto,args.comercioCuit,args.comercioTelefono,args.comercioMail,args.comercioNombre));
      return true;},
          child: Scaffold(
        
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text('Mi Puesto',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                          fontSize: 18.0, fontWeight: FontWeight.w600,
                          )),),
          backgroundColor: Color.fromRGBO(29, 233, 182, 1),
           leading: new IconButton(
          icon: new Icon(Icons.backspace, size:35),
          onPressed: () => Navigator.pushNamed(context, 'vendedorProd', arguments: PuestoArguments(args.userId,args.nombre,args.foto,args.mercadoId,args.idComercio,args.numNave,
          args.comercioPuesto,args.comercioCuit,args.comercioTelefono,args.comercioMail,args.comercioNombre))),
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
                  Container(child: VendedorProductosResultadoListView(args.idComercio,args.mercadoId,args.userId,args.foto,args.nombre,args.numNave,args.comercioPuesto,args.comercioCuit,
                  args.comercioTelefono,args.comercioMail,args.comercioNombre,args.productoBuscado)),
                ],
              ),
            ),
        ),
        //bottomNavigationBar: _bottomNavigationBar(context),
      ),
    );
  }

}