import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_ui/src/pages/actualizar_puesto.dart';
import 'package:flutter_login_ui/src/pages/actualizar_puesto_err.dart';
import 'package:flutter_login_ui/src/pages/actualizar_puesto_ok.dart';
import 'package:flutter_login_ui/src/pages/alta_producto.dart';
import 'package:flutter_login_ui/src/pages/alta_vendedor.dart';
import 'package:flutter_login_ui/src/pages/alta_vendedor_ok.dart';
import 'package:flutter_login_ui/src/pages/carrito_page.dart';
import 'package:flutter_login_ui/src/pages/confirmoReserva.dart';
import 'package:flutter_login_ui/src/pages/detalle_producto.dart';
import 'package:flutter_login_ui/src/pages/error_registrar_puesto.dart';
import 'package:flutter_login_ui/src/pages/login.dart';
import 'package:flutter_login_ui/src/pages/login_manual.dart';
import 'package:flutter_login_ui/src/pages/mercado_page.dart';
import 'package:flutter_login_ui/src/pages/categorias_page.dart';
import 'package:flutter_login_ui/src/pages/pedido_detalle_page.dart';
import 'package:flutter_login_ui/src/pages/pedido_detalle_vendedor.dart';
import 'package:flutter_login_ui/src/pages/pedido_ok.dart';
import 'package:flutter_login_ui/src/pages/pedidos_comprador_page.dart';
import 'package:flutter_login_ui/src/pages/pedidos_vendedor_page.dart';
import 'package:flutter_login_ui/src/pages/producto_resultado.dart';
import 'package:flutter_login_ui/src/pages/producto_xpuesto_page.dart';
import 'package:flutter_login_ui/src/pages/productos_busqueda.dart';
import 'package:flutter_login_ui/src/pages/productos_busqueda_vendedor.dart';
import 'package:flutter_login_ui/src/pages/productos_page.dart';
import 'package:flutter_login_ui/src/pages/puestos_page.dart';
import 'package:flutter_login_ui/src/pages/registro_user_page.dart';
import 'package:flutter_login_ui/src/pages/vendedor_prod_page.dart';
import 'package:flutter_login_ui/src/pages/alta_producto_ok.dart';
import 'package:flutter_login_ui/src/pages/alta_producto_err.dart';
import 'package:flutter_login_ui/src/pages/actualizar_producto.dart';
import 'package:flutter_login_ui/src/pages/detalle_producto_comprador.dart';
import 'package:flutter_login_ui/src/pages/vendedor_resultado_page.dart';

import 'package:flutter_login_ui/src/providers/push_notifications_provider.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  @override
  void initState() { 
    super.initState();
    
    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();
    
  }
  bool login = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return ChangeNotifierProvider<LoginState>(
        builder: (BuildContext context) => LoginState(),
        child: MaterialApp(
        title: 'Agile Market',
        debugShowCheckedModeBanner: false,
        //home: LoginScreen(),
        routes: {
           '/': (BuildContext context) {
             var state = Provider.of<LoginState>(context);
            // Provider.of<LoginState>(context).isLogin();
          if (state.isLoggedIn()) {
            return MercadosPage();
            } else{
              Provider.of<LoginState>(context).isLogin();
              return LoginPageFinal(
            );}
        },
        'categorias'   : (BuildContext context) => CategoriasPage(),
        'mercado'      : (BuildContext context) => MercadosPage(),
        'productos'    : (BuildContext context) => ProductosPage(),
        'carrito'      : (BuildContext context) => CarritoPage(),
        'confRes'      : (BuildContext context) => ConfirmoReserva(),
        'login'        : (BuildContext context) => LoginPageFinal(),
        'altaVendedor' : (BuildContext context) => AltaVendedor(),
        'vendedorProd' : (BuildContext context) => VendedorProductosPage(),
        'errorRegPues' : (BuildContext context) => ErrorRegistrarPuesto(),
        'altaComOk'    : (BuildContext context) => AltaComercioOk(),
        'puestos'      : (BuildContext context) => PuestosPage(),
        'altaProd'     : (BuildContext context) => AltaProducto(),
        'detalleProd'  : (BuildContext context) => DetalleProducto(),
        'altaProdOk'    : (BuildContext context) => AltaProductoOk(),
        'errorRegProd' : (BuildContext context) => ErrorRegistrarProducto(),
        'actProd'    : (BuildContext context) => ActualizarProducto(),
        'actPues'    : (BuildContext context) => ActualizarPuesto(),
        'actPuesOk'    : (BuildContext context) => ActPuestoOk(),
        'errorActPues' : (BuildContext context) => ErrorActualizarPuesto(),
        'buscarProducto' : (BuildContext context) => ProductosBusquedaPage(),
        'resultadoProducto' : (BuildContext context) => ProductosResultadoPage(),
        'puestoProd' : (BuildContext context) => ProductoXPuestoPage(),
        'loginManual' : (BuildContext context) => LoginManualPageFinal(),
        'registrarse' : (BuildContext context) => RegistroUserPageFinal(),
        'detalleProdComp'  : (BuildContext context) => DetalleProductoComprador(),
        'pedidoOk' : (BuildContext context) => PedidoOk(),
        'pedidosComprador' : (BuildContext context) => PedidosCompradorPage(),
        'pedidosVendedor' : (BuildContext context) => PedidosVendedorPage(),
        'pedidosDetalle' : (BuildContext context) => PedidosDetallePage(),
        'pedidosDetalleVendedor' : (BuildContext context) => PedidosDetalleVendedorPage(),
        'buscarProductoVendedor' : (BuildContext context) => ProductosBusquedaVendedorPage(),
        'resultadoProductoVendedor' : (BuildContext context) => VendedorProductosResultadoPage(),

        
        
        },
      ),
    );
  }
}
