import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/carrito_db.dart';
import 'package:flutter_login_ui/src/pages/categorias_serv.dart';
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:flutter_login_ui/src/pages/productos_page.dart';
import 'package:flutter_login_ui/src/pages/puestos_serv.dart';
import 'package:flutter_login_ui/src/pages/vendedor_prod_serv.dart';
import 'package:flutter_login_ui/src/providers/enviar_notificaciones.dart';
import 'package:flutter_login_ui/src/providers/pedidos_comprador_provider.dart';
//import 'package:flutter_login_ui/src/pages/vendedor_prod_serv.dart';
import 'package:google_fonts/google_fonts.dart';


class ListadoProductosMercado extends StatelessWidget {
  List<PedidoComprador> pedidos;
  bool yaPaso;
  //Function siguientePagina;

  ListadoProductosMercado({@required this.pedidos,this.yaPaso});

  final _pageController = new ScrollController(
    initialScrollOffset : 150.0,
  );
  int cantProd = 0;
  

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    if(yaPaso == false) {

      yaPaso = true;

      for(var i = 0; i< pedidos.length; i++) {
        
          DateTime fechaDePedido = DateTime.parse(pedidos[i].pedidoFecha);
          DateTime fechaSumada = fechaDePedido.add(Duration(minutes: 02));
          DateTime now = DateTime.now();
          String usuario = pedidos[i].pedidoFullName;

          if(fechaSumada.isAfter(now)){
            
            EnviarNotificaciones().sendAndRetrieveMessage(pedidos[i].comercioTokenDispositivo, 'Pedido Recibido', '$usuario le ha realizado un pedido');
          }



      }
    }

    return Container(
      child: Column(
        children: [
          Container(
            child: ListView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              // children: _tarjetas(context),
              itemCount: pedidos.length,
              itemBuilder: ( context, i ) {
              return _tarjeta(context, pedidos[i] );}
            ),
          ),
          
        ],
      ),
    );
  }

   Widget _tarjeta(BuildContext context, PedidoComprador pedido) {

    

      return _crearLista(pedido,context);
        
    
   
   }

   Widget _crearLista(PedidoComprador pedido,context) {
    MediaQueryData media = MediaQuery.of(context);
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Container(
          color:Colors.grey[100],
          width: media.size.width * 85.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              
              
                width: media.size.width * 85.0,
            //   height: 500.0, */
              child: Column(
                children: <Widget>[
                  
                //  _crearTitulo(),
                  SizedBox(height: 20),
                 _crearTarjetas(pedido,context),
                 SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

   _crearTarjetas(PedidoComprador pedido,context) {
     
   //final ProductosArguments args = ModalRoute.of(context).settings.arguments;
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
    String telefonoComercio = pedido.comercioTelefono;

  return Container(
    width: media.size.width * 0.93,
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
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 3,
                  //offset: Offset(5,5), // changes position of shadow
                ),
              ],
              ),
    padding: EdgeInsets.all(10.0),
     child: Column(
       children: <Widget>[
         Row(
           mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                /* Navigator.pushNamed(context, 'detalleProdComp', arguments: ProductoDetalleArg('', title,descripcion,imagen,precio1,cantidad1,precio2,cantidad2,
                                  precio3,cantidad3,stock,unidad1,unidad2,unidad3,comercioId,mercadoId,'',ratingProd,categoriaId,'','','',
                                  comercioNave,comercioPuesto,'','','',comercio));  */

              },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: 
                    Image(image: AssetImage('assets/img/iconoAgile.png'),fit: BoxFit.fill,
                    height: 55,
                        width: 55,
                      loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null ? 
                                loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),

                   /*  OptimizedCacheImage(
                         height: 55,
                        fit: BoxFit.fill,
                        width: 55,
                        imageUrl: imagen,
                        placeholder: (context, imagen) => CircularProgressIndicator(),
                        errorWidget: (context, imagen, error) => Icon(Icons.error),
                    ), */
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15.0),
              GestureDetector(
                onTap: () {
                /* Navigator.pushNamed(context, 'detalleProdComp', arguments: ProductoDetalleArg('', title,descripcion,imagen,precio1,cantidad1,precio2,cantidad2,
                                  precio3,cantidad3,stock,unidad1,unidad2,unidad3,comercioId,mercadoId,'',ratingProd,categoriaId,'','','',
                                  comercioNave,comercioPuesto,'','','',comercio));  */

              },
                child: Container(

                  width: media.size.width * 0.70 ,
                  alignment: AlignmentDirectional.bottomStart,
                  padding: EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children:<Widget>[ 
                      SizedBox(height: 5.0),
                      Row(
                        children: <Widget>[
                          Container(
                            child: Flexible(
                              child: Text(
                              pedido.comercioNombre, style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(16,32,39, 1),
                                fontSize: 16.0, fontWeight: FontWeight.bold,
                                ))
                              ),
                            ),
                          ),
                        SizedBox(width: 10.0),
                          
                        ],
                      ),
                      SizedBox(height:4.0),
                      Row(
                        children: <Widget>[
                           Flexible(
                                child: Text(
                                'Teléfono: $telefonoComercio', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                  fontSize: 12.0, fontWeight: FontWeight.w600,
                          ))),
                           ),
                          
                        ],
                      ),
                      SizedBox(height:6.0),
                      Row(
                        children: <Widget>[
                           Flexible(
                                child: Text(
                                'Reserva: $pedidoId', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                  fontSize: 10.0, fontWeight: FontWeight.w400,
                          ))),
                           ),
                          
                        ],
                      ),
                      SizedBox(height:6.0),
                      Row(
                        children: <Widget>[
                           Flexible(
                                child: Text(
                                'Hora: $horaPedido:$minPedido Fecha: $diaPedido/$mesPedido/$anioPedido', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                  fontSize: 10.0, fontWeight: FontWeight.w400,
                          ))),
                           ),
                          
                        ],
                      ),
                      SizedBox(height:media.size.height * 0.022),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              width: media.size.width * 0.50,
                              child: Text(
                                  'Estado: $estado', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                    fontSize: 10.0, fontWeight: FontWeight.w600,
                              ))),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){Navigator.pushNamed(context, 'pedidosDetalleMercado',arguments: PedidoArguments(pedido.pedidoComercioID,pedido.pedidoID,'', '',
                             '','','','','',
                            '','','','','','',pedido.pedidoTokenDispositivo));},
                            child: Container(
                              width: 70.00,
                              child: Text(
                                  'Ver Pedido  >', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(185,185,185, 1),
                                    fontSize: 10.0, fontWeight: FontWeight.w600,
                              ))),
                            ),
                          ),
                          

                        ],
                      ),
                      SizedBox(height: 3.0)
                    ]
                  ),
                ),
              ), 
            ],
          ),
       ],
     ),
  );
  }

  

}

class PedidoArguments {
  final String pedidoComercioID;
  final String pedidoID;
  final String userId;
  final String nombre;
  final String foto;
  final String mercadoId;
  final String idComercio;
  final String numNave;
  final String comercioPuesto;
  final String comercioCuit;
  final String comercioTelefono;
  final String comercioMail;
  final String comercioNombre;
  final String categoriaId;
  final String categoriaNombre;
  final String pedidoTokenDispositivo;


  PedidoArguments(this.pedidoComercioID, this.pedidoID,this.userId,this.nombre,this.foto,this.mercadoId,this.idComercio,this.numNave,this.comercioPuesto,this.comercioCuit,
  this.comercioTelefono,this.comercioMail,this.comercioNombre,this.categoriaId,this.categoriaNombre,this.pedidoTokenDispositivo);
}