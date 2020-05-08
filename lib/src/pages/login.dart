import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../login_state.dart';

class LoginPageFinal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return SafeArea(
        child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(  
          child: Container(
            child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
              height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                _armarTitulo(),
                ]
              ),
              SizedBox(
              height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                _armarSubTitulo(),
                ]
              ),
              SizedBox(height: 20.0),
              _inputEmail(),
              _inputPassword(),
              _olvidastePassword(),
              SizedBox(height: 25.0),
              _iniciarSesion(),
              _registrate(),
              _iniciarSesionGoogle(context),
              SizedBox(height: 25.0),
              _iniciarSesionFacebook(context),
              SizedBox(height: 25.0),

              ]
            )
          ),
        ),
        
      ),
    );
  }

  Widget _armarTitulo() {
    return Container(
      child: Center(
        child: Text('Bienvenido', style: TextStyle(color: Colors.black, fontFamily: 'Rubik', fontStyle: FontStyle.normal, fontWeight: FontWeight.bold,
                    fontSize: 35.0)
        )
        ) ,);
  }

    Widget _armarSubTitulo() {
    return Container(
      child: Center(
        child: Text('Usa tu e-mail y contraseña ' +
                    'para iniciar sesión', style: TextStyle(color: Colors.black, fontStyle: FontStyle.normal,
                    fontSize: 15.0)
        )
        ) ,);
  }

    Widget _inputEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
          height: 60.0,
          width: 380.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                //color: Colors.black,
              ),
              hintText: 'E-mail',
              hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Rubik',
                        ),
            ),
          ),
        ),
      ],
    );
  }

    Widget _inputPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
          height: 60.0,
          width: 380.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                //color: Colors.white,
              ),
              hintText: 'Contraseña',
              hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                        ),
            ),
          ),
        ),
      ],
    );
  }

    Widget _olvidastePassword() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 18.0),
        child: Text(
          'Olvidaste tu contraseña?',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
        ),
      ),
    );
  }

    Widget _iniciarSesion() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => print('Login Button Pressed'),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.cyanAccent[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                 Text(
                'Iniciar Sesión',
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
          ],
        ),
      ),
    );
  }

    Widget _registrate() {
    return  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              'No tienes cuenta todavía? ',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
            ),
          FlatButton(
            onPressed: () => print('Forgot Password Button Pressed'),
            padding: EdgeInsets.only(right: 18.0),
            child: Text(
              'Registrate.',
              style: TextStyle(
                  color: Colors.blue[300],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
            ),
          ),
        ],
      );
  }

    Widget _iniciarSesionGoogle(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Consumer<LoginState>(
          builder: (BuildContext context, LoginState value, Widget child) {
          if (value.isLoading()) {
            return CircularProgressIndicator();
          } else {
            return child;
          }
          },
          child: RaisedButton(
          elevation: 5.0,
          onPressed: () {Provider.of<LoginState>(context).login();},
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
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
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
              SizedBox(width: 30.0,)
            ],
          ),
        ),
      ),
    );
  }

      Widget _iniciarSesionFacebook(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Consumer<LoginState>(
          builder: (BuildContext context, LoginState value, Widget child) {
          if (value.isLoading()) {
            return CircularProgressIndicator();
          } else {
            return child;
          }
          },
          child: RaisedButton(
          elevation: 5.0,
          onPressed: () {Provider.of<LoginState>(context).login();},
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
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