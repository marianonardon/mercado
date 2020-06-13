import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
              height: media.size.height * 0.50),
              SizedBox(height: 20.0),
              _iniciarSesionGoogle(context),
              SizedBox(height: 25.0),
              //_iniciarSesionFacebook(context),
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
                    fontSize: 50.0)
        )
        ) ,);
  }


    Widget _iniciarSesionGoogle(BuildContext context) {
      MediaQueryData media = MediaQuery.of(context);
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
        decoration: BoxDecoration(
          border: Border.all()
/*           border: Border.all(
            color: Colors.black,
            width: 1.0,
            style: BorderStyle.solid
          ) */
        ),
        width: media.size.width * 0.90,
        height: media.size.height * 0.09,
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
            elevation: 5.0,
            onPressed: () {Provider.of<LoginState>(context).login();},
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               // SizedBox(width: 53.0),
                ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                    color: Colors.transparent,
                    //padding: EdgeInsets.all(10.0),
                    child: Image.asset('assets/logos/google.jpg',
                            fit: BoxFit.scaleDown,
                            scale: 17.0,),
                  ),
                ),
                SizedBox(width: 30.0,),
                Text(
                  'Iniciar con Google',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
                SizedBox(width: 30.0,)
              ],
            ),
          ),
        ),
      ),
    );
  }

      Widget _iniciarSesionFacebook(BuildContext context) {
        MediaQueryData media = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0
        )
      ),
      width: media.size.width * 0.90,
      height: media.size.height * 0.08,
      child: Consumer<LoginState>(
          builder: (BuildContext context, LoginState value, Widget child) {
          if (value.isLoading()) {
            return Column(
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
          elevation: 5.0,
          onPressed: () {Provider.of<LoginState>(context).login();},
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             // SizedBox(width: 53.0),
              ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                  color: Colors.transparent,
                  //padding: EdgeInsets.all(10.0),
                  child: Image.asset('assets/logos/facebook.jpg',
                          scale: 17.0,),
                ),
              ),
              SizedBox(width: 15.0,height: 1.0),
              Text(
                'Iniciar con Facebook',
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              SizedBox(width: 30.0,height: 1.0,)
            ],
          ),
        ),
      ),
    );
  }

  
}