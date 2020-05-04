import 'package:flutter/material.dart';
import 'package:flutter_login_ui/screens/login_screen.dart';
import 'package:flutter_login_ui/src/pages/home_page.dart';
import 'package:flutter_login_ui/src/pages/login.dart';
import 'package:flutter_login_ui/src/pages/login_page.dart';
import 'package:flutter_login_ui/src/pages/mercado_page.dart';
import 'package:flutter_login_ui/src/pages/mercados_page.dart';
import 'package:flutter_login_ui/src/pages/new_account.dart';
import 'package:provider/provider.dart';

import 'login_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginState>(
        builder: (BuildContext context) => LoginState(),
        child: MaterialApp(
        title: 'Flutter Login UI',
        debugShowCheckedModeBanner: false,
        //home: LoginScreen(),
        routes: {
           '/': (BuildContext context) {
             var state = Provider.of<LoginState>(context);
          if (state.isLoggedIn()) {
            return MercadosPage();
            } else{return LoginPageFinal(
            );}
        },
        },
      ),
    );
  }
}