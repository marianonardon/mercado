import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/alta_vendedor.dart';
import 'package:flutter_login_ui/src/pages/carrito_page.dart';
import 'package:flutter_login_ui/src/pages/confirmoReserva.dart';
import 'package:flutter_login_ui/src/pages/login.dart';
import 'package:flutter_login_ui/src/pages/mercado_page.dart';
import 'package:flutter_login_ui/src/pages/categorias_page.dart';
import 'package:flutter_login_ui/src/pages/productos_page.dart';
import 'package:flutter_login_ui/src/pages/vendedor_prod_page.dart';


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
        'categorias'   : (BuildContext context) => CategoriasPage(),
        'productos'    : (BuildContext context) => ProductosPage(),
        'carrito'      : (BuildContext context) => CarritoPage(),
        'confRes'      : (BuildContext context) => ConfirmoReserva(),
        'login'        : (BuildContext context) => LoginPageFinal(),
        'altaVendedor' : (BuildContext context) => AltaVendedor(),
        'vendedorProd' : (BuildContext context) => VendedorProductosPage(),
        },
      ),
    );
  }
}
