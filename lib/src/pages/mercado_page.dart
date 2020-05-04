import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/mercados_serv.dart';

class MercadosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[100],
        title: Text('En que mercado quieres comprar?', style: TextStyle(color: Colors.black, fontSize: 23.0, fontWeight: FontWeight.bold),),

      ),
      backgroundColor: Colors.cyan[100],
      body:  _mercadoLista());
          
  }

  Widget _crearTitulo() {
    return SafeArea(
       child: Container(
         padding: EdgeInsets.all(20.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget> [
             Expanded(
               child:Padding(
                 padding: EdgeInsets.all(16.0),
                 child: Text('En que mercado quieres comprar?', style: TextStyle(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),),
               )),
             SizedBox(height: 1.0),
           ]
           )
       )
       );
  }

  Widget _mercadoLista() {
    return Container(
      
      child: MercadosListView(),);
  }

}

