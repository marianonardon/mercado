import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginCompradorVendedor extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);  
    return WillPopScope(
      onWillPop: () async => false,
          child: Scaffold(
        backgroundColor: Color.fromRGBO(249, 249, 249, 1),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: media.size.height * 0.15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Image(image: AssetImage('assets/logos/Logo agile.png'),
                  fit: BoxFit.cover,),

                ]
              ),
              SizedBox(height: media.size.height * 0.08),
              GestureDetector(
                onTap: () {Navigator.pushNamed(context, 'login');} ,
                            child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Container(
                    color:Color.fromRGBO(29, 233, 182, 1),
                    height: media.size.height * 0.25,
                    width: media.size.width * 0.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //SizedBox(width:media.size.width * 0.008),
                        Column(
                          children: [
                            SizedBox(height:media.size.height * 0.040),
                            
                                Icon(Icons.shopping_cart,
                                  color: Colors.white,size: 40.0,),
                                
                              
                            SizedBox(height:media.size.height * 0.025),
                            Row(
                              children: [
                                //SizedBox(width:media.size.width * 0.018),
                                Text(
                                'Busco', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                fontSize: 20.0, fontWeight: FontWeight.bold,
                                )),textAlign: TextAlign.center,),
                              ],
                            ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 SizedBox(width:media.size.width * 0.1),
                                 Text(
                                  'productos', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                  fontSize: 20.0, fontWeight: FontWeight.bold,
                                  )),textAlign: TextAlign.center),
                               ],
                             ),
                            
                          ],
                        ),
                        Expanded(
                                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:[
                              Image(image: AssetImage('assets/img/comprador.png'),
                                    fit: BoxFit.fill,
                                    height: double.infinity,),
                            ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: media.size.height * 0.02),
              GestureDetector(
                onTap: () {Navigator.pushNamed(context, 'loginManual');} ,
                            child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Container(
                    color:Color.fromRGBO(29, 233, 182, 1),
                    height: media.size.height * 0.25,
                    width: media.size.width * 0.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //SizedBox(width:media.size.width * 0.008),
                        Column(
                          children: [
                            SizedBox(height:media.size.height * 0.040),
                            
                                Icon(Icons.storefront,
                                  color: Colors.white,size: 40.0,),
                                
                              
                            SizedBox(height:media.size.height * 0.025),
                            Row(
                              children: [
                                SizedBox(width:media.size.width * 0.080),
                                Text(
                                'Tengo un', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                fontSize: 20.0, fontWeight: FontWeight.bold,
                                )),textAlign: TextAlign.center,),
                              ],
                            ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 SizedBox(width:media.size.width * 0.1),
                                 Text(
                                  'comercio', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                  fontSize: 20.0, fontWeight: FontWeight.bold,
                                  )),textAlign: TextAlign.center),
                               ],
                             ),
                            
                          ],
                        ),
                        Expanded(
                                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:[
                              Image(image: AssetImage('assets/img/Vendedor.png'),
                                    fit: BoxFit.fill,
                                    height: double.infinity,),
                            ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


            ],
          ),

        ),
        
      ),
    );
  }
}