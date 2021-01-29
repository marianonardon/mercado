import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/registro_user_serv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../login_state.dart';
import 'login_manual_serv.dart';

class RegistroUserPageFinal extends StatefulWidget {
  @override
  _RegistroUserPageFinalState createState() => _RegistroUserPageFinalState();
}

class _RegistroUserPageFinalState extends State<RegistroUserPageFinal> {

  String nombreUsuario;
  String contrasenia;
  String confContrasenia;
  String nombre;
  String apellido;
  String mail;

  final nombreUsuarioController = TextEditingController();
  final contraseniaController = TextEditingController();
  final confContraseniaController = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final mailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  int calidad;






  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    nombreUsuarioController.dispose();
    contraseniaController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
  
    return WillPopScope(
          onWillPop: () async => false,
          child: SafeArea(
          child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
          //fit: StackFit.,
           children: <Widget>[
             Image(image: AssetImage('assets/img/loginManual.png'),
             fit: BoxFit.cover,
             width: double.infinity,
             height: double.infinity,),
             //fit: BoxFit.fill,),
              //width: double.infinity,
              //height: double.infinity,),
             /* Padding(
               padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.33),
               child: Image(image: AssetImage('assets/img/logo.png'),),
             ),  */          
             SingleChildScrollView(
                child: Container(
                 padding: EdgeInsets.only(left:20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    
                    
                    SizedBox(
                    height: media.size.height * 0.18),
/*                 Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                      _armarTitulo(),
                      ]
                    ), */
                    SizedBox(
                    height: media.size.height * 0.08),
                    Center(child: _inputNombreUsuario(context)),
                    SizedBox(height: 10.0),
                    _inputContrasenia(context),
                    SizedBox(height: 10.0),
                    _inputConfContrasenia(context),
                    SizedBox(height: 10.0),
                    _inputNombre(context),
                    SizedBox(height: 10.0),
                    _inputApellido(context),
                    SizedBox(height: 10.0),
                    _inputMail(context),
                    SizedBox(height: 10.0),
                    _botonConfirmar(context),
                    SizedBox(height: 25.0),
                    GestureDetector(
                     onTap: () {Navigator.pushNamed(context,'/');},
                     child: Text('Volver a seleccionar perfil', style: new TextStyle(color: Color.fromRGBO(0, 182, 134, 1), decoration: TextDecoration.underline, fontSize: 16.0),)),
                    SizedBox(height: 25.0),
                    ]
                  ),
                )
            ),
             ),]
          ),
          
        ),
      ),
    );
  }

  Widget _inputNombreUsuario(context) {
    MediaQueryData media = MediaQuery.of(context);
    nombreUsuario = nombreUsuarioController.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(width:media.size.width * 0.03),
            Container(
              alignment: Alignment.centerLeft,
              width: media.size.width * 0.85,
              child: TextFormField(
                autocorrect: false,
                validator: (nombreUsuario) {if (nombreUsuario.isEmpty) {
                    return 'El usuario no puede estar vacío!';
                    }else {
                      return null;
                    }},
                controller: nombreUsuarioController,
                keyboardType: TextInputType.text,
                style: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                             fontWeight: FontWeight.bold, fontSize: 14.0),
                decoration: InputDecoration(
                  icon: Icon(Icons.person,color: Color.fromRGBO(29, 233, 182, 1),),
                  fillColor: Color.fromRGBO(240, 241, 246, 1),
                  filled: true,
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.blue)),
                  
                  /* OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none
                    ), */
                  labelText: 'Usuario',
                  labelStyle: TextStyle(color:Colors.black, 
                             fontWeight: FontWeight.bold, fontSize: 14.0),
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0, 0.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _inputContrasenia(context) {
    MediaQueryData media = MediaQuery.of(context);
    contrasenia = contraseniaController.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(width:media.size.width * 0.03),
            Container(
              alignment: Alignment.centerLeft,
              width: media.size.width * 0.85,
              child: TextFormField(
                validator: (contrasenia) {if (contrasenia.isEmpty) {
                    return 'La contraseña no puede estar vacío!';
                    }else {
                      return null;
                    }},
                controller: contraseniaController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                             fontWeight: FontWeight.bold, fontSize: 14.0),
                decoration: InputDecoration(
                  icon: Icon(Icons.lock,color: Color.fromRGBO(29, 233, 182, 1),),
                  fillColor: Color.fromRGBO(240, 241, 246, 1),
                  filled: true,
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.blue)),
                  
                  /* OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none
                    ), */
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(color:Colors.black, 
                             fontWeight: FontWeight.bold, fontSize: 14.0),
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0, 0.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _inputConfContrasenia(context) {
    MediaQueryData media = MediaQuery.of(context);
    confContrasenia = confContraseniaController.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(width:media.size.width * 0.03),
            Container(
              alignment: Alignment.centerLeft,
              width: media.size.width * 0.85,
              child: TextFormField(
                validator: (confContrasenia) {if (confContrasenia.isEmpty) {
                    return 'La contraseña no puede estar vacío!';
                    }else {
                      if (confContrasenia != contraseniaController.text) {
                        return 'Las contraseñas no coinciden';
                      }
                      return null;
                    }},
                controller: confContraseniaController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                             fontWeight: FontWeight.bold, fontSize: 14.0),
                decoration: InputDecoration(
                  icon: Icon(Icons.lock,color: Color.fromRGBO(29, 233, 182, 1),),
                  fillColor: Color.fromRGBO(240, 241, 246, 1),
                  filled: true,
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.blue)),
                  
                  /* OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none
                    ), */
                  labelText: 'Confirmar contraseña',
                  labelStyle: TextStyle(color:Colors.black, 
                             fontWeight: FontWeight.bold, fontSize: 14.0),
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0, 0.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _inputNombre(context) {
    MediaQueryData media = MediaQuery.of(context);
    nombre = nombreController.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(width:media.size.width * 0.03),
            Container(
              alignment: Alignment.centerLeft,
              width: media.size.width * 0.85,
              child: TextFormField(
                validator: (nombre) {if (nombre.isEmpty) {
                    return 'El nombre no puede estar vacío!';
                    }else {
                      return null;
                    }},
                controller: nombreController,
                keyboardType: TextInputType.text,
                style: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                             fontWeight: FontWeight.bold, fontSize: 14.0),
                decoration: InputDecoration(
                  icon: Icon(Icons.person,color: Color.fromRGBO(29, 233, 182, 1),),
                  fillColor: Color.fromRGBO(240, 241, 246, 1),
                  filled: true,
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.blue)),
                  
                  /* OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none
                    ), */
                  labelText: 'Nombre',
                  labelStyle: TextStyle(color:Colors.black, 
                             fontWeight: FontWeight.bold, fontSize: 14.0),
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0, 0.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _inputApellido(context) {
    MediaQueryData media = MediaQuery.of(context);
    apellido = apellidoController.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(width:media.size.width * 0.03),
            Container(
              alignment: Alignment.centerLeft,
              width: media.size.width * 0.85,
              child: TextFormField(
                validator: (apellido) {if (apellido.isEmpty) {
                    return 'El apellido no puede estar vacío!';
                    }else {
                      return null;
                    }},
                controller: apellidoController,
                keyboardType: TextInputType.text,
                style: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                             fontWeight: FontWeight.bold, fontSize: 14.0),
                decoration: InputDecoration(
                  icon: Icon(Icons.person,color: Color.fromRGBO(29, 233, 182, 1),),
                  fillColor: Color.fromRGBO(240, 241, 246, 1),
                  filled: true,
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.blue)),
                  
                  /* OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none
                    ), */
                  labelText: 'Apellido',
                  labelStyle: TextStyle(color:Colors.black, 
                             fontWeight: FontWeight.bold, fontSize: 14.0),
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0, 0.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _inputMail(context) {
    MediaQueryData media = MediaQuery.of(context);
    mail = mailController.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(width:media.size.width * 0.03),
            Container(
              alignment: Alignment.centerLeft,
              width: media.size.width * 0.85,
              child: TextFormField(
                validator: (mail) {if (mail.isEmpty) {
                    return 'El email no puede estar vacío!';
                    }else {
                       String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                        "\\@" +
                        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                        "(" +
                        "\\." +
                        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                        ")+";
                    RegExp regExp = new RegExp(p);
                    if (regExp.hasMatch(mail)) {
                      return null;
                    } else {
                    return 'El Email suministrado no es válido.';}
                  }},
                controller: mailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                             fontWeight: FontWeight.bold, fontSize: 14.0),
                decoration: InputDecoration(
                  icon: Icon(Icons.mail,color: Color.fromRGBO(29, 233, 182, 1),),
                  fillColor: Color.fromRGBO(240, 241, 246, 1),
                  filled: true,
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.blue)),
                  
                  /* OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none
                    ), */
                  labelText: 'Email',
                  labelStyle: TextStyle(color:Colors.black, 
                             fontWeight: FontWeight.bold, fontSize: 14.0),
                  contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0, 0.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _botonConfirmar(context) {
    MediaQueryData media = MediaQuery.of(context);
    return GestureDetector(
      onTap: () async {
        
       if (formKey.currentState.validate()) {

        showDialog(
          context: context,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
                      child: AlertDialog(
              title: Center(child: Text('Registrando usuario')),
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
          ),
        barrierDismissible: false,
          ).then((_) => setState((){})); 



        
         RegistroUser().registro(nombreUsuarioController.text,contraseniaController.text,confContraseniaController.text,
                                  nombreController.text,apellidoController.text,mailController.text, context);
       }
      },
        
        // Navigator.pushNamed(context, 'vendedorProd');                                         
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: Color.fromRGBO(29, 233, 182, 1),
          height: media.size.height * 0.07,
          width: media.size.width * 0.85,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child: 
                Text('Registrarse', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                            fontSize: 16.0, fontWeight: FontWeight.w500,
                                      ))),
              )
            ],
          ),
        ),
      )
      
    );
    
  }
}