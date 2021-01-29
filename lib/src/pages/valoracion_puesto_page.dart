import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/valoracion_puesto_serv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'actualizar_puesto_serv.dart';

class ValoracionPuesto extends StatefulWidget {
  @override
  _ValoracionPuestoState createState() => _ValoracionPuestoState();
}

class _ValoracionPuestoState extends State<ValoracionPuesto> {
   int calidad;

  @override
  Widget build(BuildContext context) {
    final ValoracionArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Valoración de puesto',style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600))),
        backgroundColor: Color.fromRGBO(29, 233, 182, 1),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(child: Text('Valorá el puesto que realizaste el pedido',style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600, fontSize: 16.0)))),
              ]
            ),
            SizedBox(height: 30.0),
            _valorarPuesto(),
            SizedBox(height: 45.0),
            _botonConfirmar(context, args.mercadoId, args.comercioId)


          ]
          
        ),
      ),
      
    );

    
  }
  Widget _valorarPuesto(){
    MediaQueryData media = MediaQuery.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.center,
          height: media.size.height * 0.06,
          width: media.size.width * 0.90,
          child: RatingBar(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  calidad = rating.round();
                });
              },
            )
          ),
      ],
    );

    }

    Widget _botonConfirmar(context,mercadoId,idComercio) {
    MediaQueryData media = MediaQuery.of(context);
    return GestureDetector(
      onTap: () async {
        

        

          showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(child: Text('Valorando puesto')),
            content:  SizedBox(
                      width: media.size.width * 0.005,
                      height: media.size.height * 0.05,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3.0,
                          valueColor : AlwaysStoppedAnimation(Color.fromRGBO(29, 233, 182, 1),),
                        ),
                      ),
                  ),
            backgroundColor: Colors.white

        ),
        barrierDismissible: false,
          ).then((_) => setState((){})); 

        await PuestoValoracion().valoracion(idComercio,mercadoId,calidad,context); 
        //Navigator.pushNamed(context, 'mercado');

        
                  },
                                          
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: Color.fromRGBO(29, 233, 182, 1),
          height: media.size.height * 0.07,
          width: media.size.width * 0.90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: 
                Text('Confirmar valoración', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                            fontSize: 14.0, fontWeight: FontWeight.w500,
                                      ))),
              )
            ],
          ),
        ),
      ),
    );
    
  }
}