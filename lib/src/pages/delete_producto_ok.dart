import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';

class DeleteProductoOk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PuestoArguments args = ModalRoute.of(context).settings.arguments;
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
            Text('Tu producto ha sido', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                  fontSize: 24.0, fontWeight: FontWeight.bold,))),
            Text('eliminado con éxito', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                  fontSize: 24.0, fontWeight: FontWeight.bold,))),
            SizedBox(height: 20.0,),
            
            SizedBox(height: 50.0,),
            GestureDetector(
             onTap: () {Navigator.pushNamed(context, 'vendedorProd', arguments: PuestoArguments(args.userId,args.nombre,args.foto,args.mercadoId,args.idComercio,
             args.numNave,args.comercioPuesto,args.comercioCuit,args.comercioTelefono,args.comercioMail,args.comercioNombre,args.comercioFoto));},
             child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0) ,
                child:Container(
                  height: 50.0,
                  width: 200.0,
                  color: Color.fromRGBO(29, 233, 182, 1),
                  child: Center(child: 
                  Text('Ir a Mis productos', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
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


