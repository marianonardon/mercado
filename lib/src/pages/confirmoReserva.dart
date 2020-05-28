import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmoReserva extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    size: 70.0,),
                ),
              ),
            ),
          ),
          SizedBox(height: 50,),
          Text('Tu pedido ha sido', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                fontSize: 30.0, fontWeight: FontWeight.bold,))),
          Text('enviado', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                fontSize: 30.0, fontWeight: FontWeight.bold,))),
          SizedBox(height: 20.0,),
          Text('Entra en "mis reservas"', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(209, 209, 209, 1),
                fontSize: 20.0, fontWeight: FontWeight.normal,))),
          Text('para conocer el estado de', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(209, 209, 209, 1),
                fontSize: 20.0, fontWeight: FontWeight.normal,))),
          Text('tu pedido', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(209, 209, 209, 1),
                fontSize: 20.0, fontWeight: FontWeight.normal,))),
          SizedBox(height: 50.0,),
          GestureDetector(
           onTap: () {Navigator.pushNamed(context, 'productos');},
           child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0) ,
              child:Container(
                height: 60.0,
                width: 220.0,
                color: Color.fromRGBO(29, 233, 182, 1),
                child: Center(child: 
                Text('Ir a Mis reservas', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                fontSize: 17.0, fontWeight: FontWeight.w700,))),
                )
                )
           )
          )
        ],
      ),
      
    )
    );
  }
}