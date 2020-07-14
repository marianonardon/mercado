import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../login_state.dart';

class LoginPageFinal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
  
    return SafeArea(
        child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
        //fit: StackFit.,
         children: <Widget>[
           Image(image: AssetImage('assets/img/login.png'),),
           //fit: BoxFit.fill,),
            //width: double.infinity,
            //height: double.infinity,),
           Padding(
             padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.33),
             child: Image(image: AssetImage('assets/img/logo.png'),),
           ),           
           Container(
             padding: EdgeInsets.only(left:20.0),
            child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
              height: 100.0),
/*                 Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                _armarTitulo(),
                ]
              ), */
              SizedBox(
              height: media.size.height * 0.57),
              _iniciarSesionGoogle(context),
              SizedBox(height: 25.0),
              _iniciarSesionFacebook(context),
              SizedBox(height: 25.0),

              ]
            )
          ),]
        ),
        
      ),
    );
  }

  Widget _armarTitulo() {
    
    return Container(
      child: Center(
        child: Text('agile', style: TextStyle(color: Colors.black, fontFamily: 'Rubik', fontStyle: FontStyle.normal, fontWeight: FontWeight.bold,
                    fontSize: 14.0)
        )
        ) ,);
  }


    Widget _iniciarSesionGoogle(BuildContext context) {
      final String assetName = 'assets/logos/google.svg';
     
      MediaQueryData media = MediaQuery.of(context);
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
        width: media.size.width * 0.90,
        height: 50.0,
        child: Consumer<LoginState>(
            builder: (BuildContext context, LoginState value, Widget child) {
            if (value.isLoading()) {
              return  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: media.size.width * 0.05,
                        height: media.size.height * 0.03,
                        margin: EdgeInsets.all(5),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor : AlwaysStoppedAnimation(Color.fromRGBO(29, 233, 182, 1),),
                        ),
                      ),
                    ),
                  ],
              );
            } else {
              return child;
            }
            },
            child: RaisedButton(
            elevation: 1.0,
            onPressed: () {Provider.of<LoginState>(context).login(LoginProvider.google);},
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            color: Color.fromRGBO(255, 83, 83, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               // SizedBox(width: 53.0),
                ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                    color: Colors.transparent,
                    //padding: EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                          assetName,
                          color: Colors.white,
                        )
                    
                    
                    /* Image.asset('assets/logos/google.jpg',
                            fit: BoxFit.scaleDown,
                            scale: 20.0,), */
                  ),
                ),
                SizedBox(width: 30.0,),
                Text('Iniciar con Google',style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.white,
                        fontSize: 14.0, fontWeight: FontWeight.w600, letterSpacing: 0.15
                        ))),
                SizedBox(width: 30.0,)
              ],
            ),
          ),
        ),
      ),
    );
  }

      Widget _iniciarSesionFacebook(BuildContext context) {
        final String assetName = 'assets/logos/facebook.jpg';
     
      MediaQueryData media = MediaQuery.of(context);
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
        width: media.size.width * 0.90,
        height: 50.0,
        child: Consumer<LoginState>(
            builder: (BuildContext context, LoginState value, Widget child) {
            if (value.isLoading()) {
              return  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: media.size.width * 0.05,
                        height: media.size.height * 0.03,
                        margin: EdgeInsets.all(5),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor : AlwaysStoppedAnimation(Color.fromRGBO(29, 233, 182, 1),),
                        ),
                      ),
                    ),
                  ],
              );
            } else {
              return child;
            }
            },
            child: RaisedButton(
            elevation: 1.0,
            onPressed: () {Provider.of<LoginState>(context).login(LoginProvider.facebook);},
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            color: Color.fromRGBO(0, 87, 201, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               // SizedBox(width: 53.0),
                ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                    color: Colors.transparent,
                    //padding: EdgeInsets.all(10.0),
                    child:  Image.asset('assets/logos/facebook.jpg',
                            fit: BoxFit.scaleDown,
                            scale: 20.0,),
                  ),
                ),
                SizedBox(width: 30.0,),
                Text('Iniciar con Facebook',style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.white,
                        fontSize: 14.0, fontWeight: FontWeight.w600, letterSpacing: 0.15
                        ))),
                SizedBox(width: 30.0,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}