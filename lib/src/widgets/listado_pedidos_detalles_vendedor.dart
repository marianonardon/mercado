import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/carrito_db.dart';
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:flutter_login_ui/src/pages/productos_page.dart';
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';
import 'package:flutter_login_ui/src/pages/vendedor_prod_serv.dart';
import 'package:flutter_login_ui/src/providers/actualizar_estado_pedido.dart';
import 'package:flutter_login_ui/src/providers/pedido_detalle_provider.dart';
import 'package:flutter_login_ui/src/providers/pedidos_comprador_provider.dart';
import 'package:flutter_login_ui/src/widgets/listado_pedidos_comprador.dart';
//import 'package:flutter_login_ui/src/pages/vendedor_prod_serv.dart';
import 'package:google_fonts/google_fonts.dart';


class ListadoPedidosDetalleVendedor extends StatefulWidget {
  PedidoDetalle pedidos;
  //Function siguientePagina;

  ListadoPedidosDetalleVendedor({@required this.pedidos});

  @override
  _ListadoPedidosDetalleVendedorState createState() => _ListadoPedidosDetalleVendedorState();
}

class _ListadoPedidosDetalleVendedorState extends State<ListadoPedidosDetalleVendedor> {
  final _pageController = new ScrollController(
    initialScrollOffset : 150.0,
  );

  int cantProd = 0;

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(child: _tarjeta(context, widget.pedidos ));
      
  }

   Widget _tarjeta(BuildContext context, PedidoDetalle pedido) {

      return _crearLista(pedido,context);
        
    
   
   }

   Widget _crearLista(PedidoDetalle pedido,context) {
    MediaQueryData media = MediaQuery.of(context);
    return  
                 _crearTarjetas(pedido,context);
                 
  }

   _crearTarjetas(PedidoDetalle pedido,context) {
     
   final PedidoArguments args = ModalRoute.of(context).settings.arguments;
   MediaQueryData media = MediaQuery.of(context); 
   String pedidoId = pedido.pedidoComercioID;
   String estado   = pedido.estadoNombre;
   DateTime horarioPedido = DateTime.parse(pedido.pedidoFecha);
    String horaPedido = horarioPedido.hour.toString();
    String minPedido  = horarioPedido.minute.toString();
    if (int.parse(minPedido) < 10) {
      minPedido = '0$minPedido';
    }
    String diaPedido = horarioPedido.day.toString();
    String mesPedido = horarioPedido.month.toString();
    String anioPedido = horarioPedido.year.toString();
    String peso = '\$';
    String precioTotalPedido = pedido.pedidoPrecioTotal;

  return Container(
    width: double.infinity,
  // height: double.infinity,
    color: Colors.grey[100],
    child: Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          color: Colors.grey[100],
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          //offset: Offset(5,5), // changes position of shadow
                        ),
                      ],
                      ),
                      width: media.size.width * 0.95,
                      //height: double.infinity,
                      //width: media.size.width * 0.95,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            width:  double.infinity,
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height:10.0),
                                Row(
                                  children: <Widget>[
                                    SizedBox(width:15.0),
                                    Text('Reserva: $pedidoId',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(2, 127, 100, 1),
                                        fontSize: 24.0, fontWeight: FontWeight.bold,
                                    )),),
                                  ],),
                                SizedBox(height:15.0),
                                Container(
                                    color: Color.fromRGBO(0, 203, 159, 0.18),
                                    width: double.infinity,
                                    height: media.size.height * 0.07,
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(width: 15.0),
                                        Text('Puesto del mercado',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(0, 203, 159,1),
                                        fontSize: 12.0, fontWeight: FontWeight.w600,
                                    )),),
                                    SizedBox(
                                      width: media.size.width * 0.38,
                                    ),
                                    Icon(Icons.shopping_basket,
                                    color: Color.fromRGBO(0, 203, 159, 1),)
                                      ]
                                    )
                                  ),
                                  SizedBox(height:15.0),
                                  Row(
                                      children: <Widget>[
                                        SizedBox(width: 15.0),
                                        Text(pedido.comercioNombre,style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(16, 32,39,1),
                                        fontSize: 14.0, fontWeight: FontWeight.w600,
                                    )),),
                                  ]
                                  ),
                                  SizedBox(height:15.0),
                                  Container(
                                    color: Color.fromRGBO(0, 203, 159, 0.18),
                                    width: double.infinity,
                                    height: media.size.height * 0.05,
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(width: 15.0),
                                        Text('Fecha de pedido',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(0, 203, 159,1),
                                        fontSize: 12.0, fontWeight: FontWeight.w600,
                                    )),),
                                    SizedBox(
                                      width: media.size.width * 0.43,
                                    ),
                                    Icon(Icons.calendar_today,
                                    color: Color.fromRGBO(0, 203, 159, 1),)
                                      ]
                                    )
                                  ),
                                  SizedBox(height:15.0),
                                Row(
                                      children: <Widget>[
                                        Container(
                                          child: Row(children: <Widget>[
                                            SizedBox(width: 15.0),
                                          Text('Hora: $horaPedido:$minPedido Fecha: $diaPedido/$mesPedido/$anioPedido',style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(16, 32,39,1),
                                          fontSize: 14.0, fontWeight: FontWeight.w600,
                                          )),),
                                          ],),
                                        ),
                                  ]
                                  ),
                                  SizedBox(height:15.0),
                                  Container(
                                    color: Color.fromRGBO(0, 203, 159, 0.18),
                                    width: double.infinity,
                                    height: media.size.height * 0.07,
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(width: 15.0),
                                        Text('Productos del pedido',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(0, 203, 159,1),
                                        fontSize: 12.0, fontWeight: FontWeight.w600,
                                    )),),
                                    SizedBox(
                                      width: media.size.width * 0.36,
                                    ),
                                    Icon(Icons.shopping_basket,
                                    color: Color.fromRGBO(0, 203, 159, 1),)
                                      ]
                                    )
                                  ),
                                  SizedBox(height:15.0),
                                  listadoProductos(pedido,context),
                                  SizedBox(height: media.size.height * 0.02),
                                  Row(
                                      children: <Widget>[
                                        Container(
                                          child: Row(children: <Widget>[
                                          SizedBox(width: 15.0),
                                          Text('Total',style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(0,0,0,0.87),
                                          fontSize: 16.0, fontWeight: FontWeight.w600,
                                          )),),
                                          SizedBox(width: media.size.width * 0.48),
                                          Text('$peso$precioTotalPedido',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(2,127,100,1),
                                          fontSize: 20.0, fontWeight: FontWeight.w600,
                                          )),),

                                          ],),
                                                ),
                                          ]
                                          ),
                                          SizedBox(height: media.size.height * 0.02),
                              ],
                              
                            )
                          )
                          
                        ]
                      )
                    )
                  ]
                )
              ),
              SizedBox(height: media.size.height * 0.02),
            ],
          ),
        ),
        
        SizedBox(height:10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: media.size.width * 0.05),
            Text('Actulizá estado de reserva',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(43, 43,58, 1),
                        fontSize: 16.0, fontWeight: FontWeight.bold,
                        ))),
          ],
        ),
      SizedBox(height:10.0),                    
        botonListoParaRetirar(pedido.estadoID,pedido.pedidoID,pedido.pedidoComercioID),
        botonEntregado(pedido.estadoID,pedido.pedidoID,pedido.pedidoComercioID),
        SizedBox(height:5.0),
        botonCancelar(pedido.estadoID,pedido.pedidoID,pedido.pedidoComercioID),
        
        SizedBox(height:10.0),
        
        
        
              SizedBox(height: media.size.height * 0.04,),
               ],
             ),
           );  }

  listadoProductos(PedidoDetalle pedido,context) {
    final _screenSize = MediaQuery.of(context).size;
    String peso = '\$';

    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
      itemCount: pedido.productos.length,
      itemBuilder: (BuildContext context, int i) {
        String preciototalprod = pedido.productos[i].pedidoProductoPrecioTotal;
        String precioUnitario  = pedido.productos[i].pedidoProductoPrecio;
        String cantidad  = pedido.productos[i].pedidoProductoCantidad;
        return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 7.0),
              Flexible(
                 child: Container(
                   width: _screenSize.width * 0.5,
                  child: Text(pedido.productos[i].productoNombre, style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(16, 32, 39, 1),
                   fontSize: 14.0, fontWeight: FontWeight.bold,
                  ))),
                ),
              ),
              SizedBox(width: _screenSize.width * 0.12),
              Text('$peso$preciototalprod', style: GoogleFonts.lato(textStyle:TextStyle(color:Color.fromRGBO(2, 127, 100, 1),
               fontSize: 14.0, fontWeight: FontWeight.bold,
              ))),
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 7.0),
              Text('$cantidad x $precioUnitario', style: GoogleFonts.lato(textStyle:TextStyle(color:Colors.grey[400],
               fontSize: 12.0, fontWeight: FontWeight.w600,
              ))),
            ]
          )
        ],
      );
      }
    )
    );

  }

  botonListoParaRetirar(estadoId,pedidoId,pedidoComercioId){

    MediaQueryData media = MediaQuery.of(context);
    final PedidoArguments args = ModalRoute.of(context).settings.arguments;

    if(estadoId != '4'){
      if(estadoId == '3'){
        return Container();
      }

        return GestureDetector(
            onTap: () async {
                showDialog(
                          context: context,
                          builder: (context) => WillPopScope(
                            onWillPop: () async => false,
                                      child: AlertDialog(
                              title: Center(child: Text('Actualizando estado')),
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
                        barrierDismissible: true,
                          ).then((_) => setState((){}));
                await PedidoActualizar().updatePedido('3',pedidoId,pedidoComercioId,context);
                Navigator.pushNamed(context, 'pedidosVendedor',arguments: PuestoArguments(args.userId, args.nombre, args.foto, args.mercadoId, args.idComercio,args.numNave,args.comercioPuesto,
              args.comercioCuit,args.comercioTelefono,args.comercioMail,args.comercioNombre));
            },
            child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(29, 233, 182, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200],
                        spreadRadius: 2.5,
                        blurRadius: 1,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  width: media.size.width * 0.90,
                  height: media.size.height * 0.06,
                  //width: media.size.width * 0.95,
                  child: Center(
                    child: Text('Listo para retirar',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71,79, 1),
                    fontSize: 16.0, fontWeight: FontWeight.w600,
                    ))),
                  )
                
                ),
                ]
                ),
          ),
        );
      

    } else{
      return Container();
    }

  }


  botonCancelar(estadoId,pedidoId,pedidoComercioId){

    MediaQueryData media = MediaQuery.of(context);
    final PedidoArguments args = ModalRoute.of(context).settings.arguments;

    if(estadoId != '4'){
      if(estadoId == '2'){
        return Container();
      }
      
       return GestureDetector(
            onTap: () async {
                showDialog(
                          context: context,
                          builder: (context) => WillPopScope(
                            onWillPop: () async => false,
                                      child: AlertDialog(
                              title: Center(child: Text('Actualizando estado')),
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
                        barrierDismissible: true,
                          ).then((_) => setState((){}));
                await PedidoActualizar().updatePedido('2',pedidoId,pedidoComercioId,context);
                Navigator.pushNamed(context, 'pedidosVendedor',arguments: PuestoArguments(args.userId, args.nombre, args.foto, args.mercadoId, args.idComercio,args.numNave,args.comercioPuesto,
              args.comercioCuit,args.comercioTelefono,args.comercioMail,args.comercioNombre));
            },
            child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(195, 15,0, 0.5),
                        spreadRadius: 2.5,
                        blurRadius: 1,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  width: media.size.width * 0.90,
                  height: media.size.height * 0.06,
                  //width: media.size.width * 0.95,
                  child: Center(
                    child: Text('Cancelar pedido',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(195, 15,0, 1),
                    fontSize: 16.0, fontWeight: FontWeight.w600,
                    ))),
                  )
                
                ),
                ]
                ),
          ),
        );
      

    } else{
      return Container();
    }

  }


  botonEntregado(estadoId,pedidoId,pedidoComercioId){

    MediaQueryData media = MediaQuery.of(context);
    final PedidoArguments args = ModalRoute.of(context).settings.arguments;

    if(estadoId != '4'){
      if(estadoId != '3'){
        return Container();
      }else{
        return GestureDetector(
            onTap: () async {
              showDialog(
                          context: context,
                          builder: (context) => WillPopScope(
                            onWillPop: () async => false,
                                      child: AlertDialog(
                              title: Center(child: Text('Actualizando estado')),
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
                        barrierDismissible: true,
                          ).then((_) => setState((){}));
                await PedidoActualizar().updatePedido('4',pedidoId,pedidoComercioId,context);
                Navigator.pushNamed(context, 'pedidosVendedor',arguments: PuestoArguments(args.userId, args.nombre, args.foto, args.mercadoId, args.idComercio,args.numNave,args.comercioPuesto,
              args.comercioCuit,args.comercioTelefono,args.comercioMail,args.comercioNombre));
            },
            child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(29, 233, 182, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200],
                        spreadRadius: 2.5,
                        blurRadius: 1,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  width: media.size.width * 0.90,
                  height: media.size.height * 0.06,
                  //width: media.size.width * 0.95,
                  child: Center(
                    child: Text('Pedido entregado',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71,79, 1),
                    fontSize: 16.0, fontWeight: FontWeight.w600,
                    ))),
                  )
                
                ),
                ]
                ),
          ),
        );
      }

    } else{
      return Container();
    }

  }
}