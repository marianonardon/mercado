import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/mercados_serv.dart';

class MercadosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Seleccionar Mercado', style: TextStyle(color: Colors.blueGrey, fontSize: 20.0, fontWeight: FontWeight.bold),),

      ),
      backgroundColor: Colors.white,
      body:  _mercadoLista());
          
  }


  Widget _mercadoLista() {
    return Container(
      
      child: MercadosListView(),);
  }

}

