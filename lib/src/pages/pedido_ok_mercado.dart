import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/categorias_serv.dart';
import 'package:flutter_login_ui/src/widgets/listado_pedidos_comprador.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';

class PedidoOkMercado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () async => false,
          child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(    
        //padding: EdgeInsets.all(150.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 100.0,),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                  
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  color: Color.fromRGBO(29, 233, 182, 1),
                  
                  child: Center(
                    child: Icon(
                      Icons.thumb_up,
                      color: Colors.white,
                      size: 50.0,),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,),
            Text('Tu pedido ha sido', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                  fontSize: 24.0, fontWeight: FontWeight.bold,))),
            Text('creado con éxito', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                  fontSize: 24.0, fontWeight: FontWeight.bold,))),
            SizedBox(height: 20.0,),
            Text('Entra en "Mis pedidos"', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(209, 209, 209, 1),
                  fontSize: 16.0, fontWeight: FontWeight.normal,))),
            Text('para visualizar ', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(209, 209, 209, 1),
                  fontSize: 16.0, fontWeight: FontWeight.normal,))),
            Text('todos tus pedidos', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(209, 209, 209, 1),
                  fontSize: 16.0, fontWeight: FontWeight.normal,))),
            SizedBox(height: 50.0,),
            GestureDetector(
             onTap: () {
               Navigator.pushNamed(context, 'pedidosMercado' );},
            
             child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0) ,
                child:Container(
                  height: 50.0,
                  width: 200.0,
                  color: Color.fromRGBO(29, 233, 182, 1),
                  child: Center(child: 
                  Text('Ir a Mis pedidos', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                  fontSize: 14.0, fontWeight: FontWeight.w700,))),
                  )
                  )
             )
            )
          ],
        ),
        
      )
      ),
    );
  }
}


/* 
class DatosPuesto {
  final String userId;
  final String nombre;
  final String foto;
  final String mercadoId;


  DatosPuesto(this.userId, this.nombre,this.foto,this.mercadoId);
} */


