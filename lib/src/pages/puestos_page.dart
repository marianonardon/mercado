import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';

import 'mercados_serv.dart';

class PuestosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){Navigator.pushNamed(context, 'altaVendedor');},
        backgroundColor: Color.fromRGBO(29, 233, 182, 1),
        child: Icon(Icons.add, color: Colors.black, size: 40.0,),
        ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Seleccionar Puesto', style: TextStyle(color: Colors.blueGrey, fontSize: 20.0, fontWeight: FontWeight.bold),),

      ),
      backgroundColor: Colors.white,
      body:  _puestoLista(args));
          
  }


  Widget _puestoLista(args) {
    return Container(
      
      child: PuestosListView(args),);
  }

}

