import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../login_state.dart';
import 'login_manual_serv.dart';

class LoginManualPageFinal extends StatefulWidget {
  @override
  _LoginManualPageFinalState createState() => _LoginManualPageFinalState();
}

class _LoginManualPageFinalState extends State<LoginManualPageFinal> {

  String nombreUsuario;
  String contrasenia;


  final nombreUsuarioController = TextEditingController();
  final contraseniaController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  int calidad;
  bool checkboxValue = true;






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
                    height: media.size.height * 0.30),
                    Text(
                      'Inicia sesión con tu', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(0, 182, 134, 1),
                        fontSize: 24.0, fontWeight: FontWeight.w600,
                        ))),
                    Text(
                      'cuenta de Agile Market', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(0, 182, 134, 1),
                        fontSize: 24.0, fontWeight: FontWeight.w600,
                        ))),
/*                 Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                      _armarTitulo(),
                      ]
                    ), */
                    SizedBox(
                    height: media.size.height * 0.08),
                    Center(child: _inputNombreUsuario(context)),
                    SizedBox(height: 25.0),
                    _inputContrasenia(context),
                    SizedBox(height: 25.0),
                    _botonConfirmar(context),
                    SizedBox(height: 25.0),
                    GestureDetector(
                     onTap: () {Navigator.pushNamed(context,'/');},
                     child: Text('Login con redes', style: new TextStyle(color: Color.fromRGBO(0, 182, 134, 1), decoration: TextDecoration.underline, fontSize: 16.0),)),
                     SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Text('Acepto términos y condiciones de estas', style: new TextStyle(color: Colors.black, fontSize: 18.0),),
                              GestureDetector(
                                onTap: () {launch('https://agilemarket.com.ar/politicas.aspx');},
                                child: Text('políticas de privacidad de Agile market', style: new TextStyle(color: Color.fromRGBO(0, 182, 134, 1), decoration: TextDecoration.underline, fontSize: 18.0),)),
                            ],
                          ),
                        ),
                        
                        Container(
                            child: Column(
                              children: <Widget>[
                              new Checkbox(
                                value: checkboxValue,
                                activeColor: Colors.green,
                                onChanged:( newValue){
                                  setState(() {
                                    checkboxValue = newValue;
                                  });
                                }),
                              ],
                            ),
                          ),
                      ],
                    ),

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

  Widget _botonConfirmar(context) {
    MediaQueryData media = MediaQuery.of(context);
    return GestureDetector(
      onTap: () async {
        if(checkboxValue == true){
        

        SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
       String categoriaId = prefs.getString('idCategoria');
       
       String tipoUnidadId = prefs.getString('idTipoUnidad');
      
       String urlFoto;



       if (formKey.currentState.validate()) {

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(child: Text('Iniciando sesión')),
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



        
         LoginManual().login(nombreUsuarioController.text,contraseniaController.text, context);
       }
      }},
        
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
                Text('Iniciar sesión', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
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