import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';

class ErrorRegistrarProducto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // final PuestoArguments args = ModalRoute.of(context).settings.arguments;
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
                  color: Colors.red,
                  
                  child: Center(
                    child: Icon(
                      Icons.thumb_down,
                      color: Colors.white,
                      size: 50.0,),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,),
            Text('Ha ocurrido', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                  fontSize: 24.0, fontWeight: FontWeight.bold,))),
            Text('un error creando producto', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                  fontSize: 24.0, fontWeight: FontWeight.bold,))),
            SizedBox(height: 20.0,),
            Text('El producto ya', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(209, 209, 209, 1),
                  fontSize: 16.0, fontWeight: FontWeight.w600,))),
            Text('existe con ese nombre', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(209, 209, 209, 1),
                  fontSize: 16.0, fontWeight: FontWeight.w600,))),
            SizedBox(height: 50.0,),
            GestureDetector(
             onTap: () {Navigator.pop(context);},
               
               //Navigator.pushNamed(context, 'altaProd', arguments: comercioId);},
             child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0) ,
                child:Container(
                  height: 50.0,
                  width: 200.0,
                  color: Color.fromRGBO(29, 233, 182, 1),
                  child: Center(child: 
                  Text('Volver a intentar', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
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