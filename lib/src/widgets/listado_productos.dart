import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/carrito_db.dart';
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:flutter_login_ui/src/pages/productos_page.dart';
import 'package:flutter_login_ui/src/pages/vendedor_prod_serv.dart';
//import 'package:flutter_login_ui/src/pages/vendedor_prod_serv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ListadoProductos extends StatefulWidget {
  List<Producto> productos;
  final globalKey;
  //Function siguientePagina;

  ListadoProductos({@required this.productos,this.globalKey});

  @override
  _ListadoProductosState createState() => _ListadoProductosState();
}

class _ListadoProductosState extends State<ListadoProductos> {
  final _pageController = new ScrollController(
    initialScrollOffset : 120.0,
  );

  int cantProd = 0;

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener( () {

      if ( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 ){
        //siguientePagina();
      }

    });

    return Container(
      child: Column(
        children: [
          Text('  Lista de productos',style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                  fontSize: 16.0, fontWeight: FontWeight.w600,
                  ))),
          Container(
            child: ListView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              // children: _tarjetas(context),
              itemCount: widget.productos.length,
              itemBuilder: ( context, i ) {
              return _tarjeta(context, widget.productos[i] );}
            ),
          ),
        ],
      ),
    );
  }

   Widget _tarjeta(BuildContext context, Producto producto) {

      String preciox1;
      String preciox2;
      String preciox3;
      String cantidad1;
      String cantidad2;
      String cantidad3;
      String foto;
      if((producto.precios.length - 1) >= 2) {
          preciox1 = producto.precios[0].precioProducto;
          preciox2 = producto.precios[1].precioProducto;
          preciox3 = producto.precios[2].precioProducto;
          cantidad1 = producto.precios[0].precioCantidad;
          cantidad2 = producto.precios[1].precioCantidad;
          cantidad3 = producto.precios[2].precioCantidad;
      }else{
        if ((producto.precios.length - 1) == 1) {
          preciox1 = producto.precios[0].precioProducto;
          preciox2 = producto.precios[1].precioProducto;
          preciox3 = '';
          cantidad1 = producto.precios[0].precioCantidad;
          cantidad2 = producto.precios[1].precioCantidad;
          cantidad3 = '';
        } else{
          if ((producto.precios.length - 1) == 0) {
            preciox1 = producto.precios[0].precioProducto;
            preciox2 = '';
            preciox3 = '';
            cantidad1 = producto.precios[0].precioCantidad;
            cantidad2 = '';
            cantidad3 = '';}
            else{
            preciox1 = '';
            preciox2 = '';
            preciox3 = '';
            cantidad1 = '';
            cantidad2 = '';
            cantidad3 = '';

          }
      }
      }
      if(producto.productoFoto == '') {
        foto = 'https://res.cloudinary.com/agilemarket/image/upload/v1594599858/m3wh5dxmlwmyjbpit3cr.png';
      }else{
        
        foto = producto.productoFoto;}
      return _crearLista(producto.productoNombre,
                    foto,preciox1,preciox2,preciox3,cantidad1,cantidad2,cantidad3,
                    producto.comercioNombre,
                    producto.tipoUnidadNombre, producto.productoCalidad,producto.comercioID,producto.comercioPuesto,producto.productoDescripcion,
                    producto.productoStock,producto.comercioNumNave,producto.categoriaID,producto.mercadoID,producto.productoID,context);
        
    
   
   }

   Widget _crearLista(String title, String imagen,String precio1,String precio2,String precio3,String cantidad1,String cantidad2,String cantidad3, String comercio, String unidad,double ratingProd,String comercioId, 
   String comercioPuesto,descripcion,stock,comercioNave, categoriaId,mercadoId,productoId,context) {
    MediaQueryData media = MediaQuery.of(context);
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Container(
            
              width: media.size.height * 95.0,
          //   height: 500.0, */
            child: Column(
              children: <Widget>[
                
              //  _crearTitulo(),
                SizedBox(height: 8.0),
               _crearTarjetas(title, imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioId,comercioPuesto,descripcion,stock,comercioNave,categoriaId,mercadoId,productoId,context)
              ],
            ),
          ),
        ),
      ],
    );
  }

   _crearTarjetas(title,imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioId,comercioPuesto,descripcion,stock,comercioNave,categoriaId,mercadoId,productoId,context) {

/*     String puestos;
    List<Puesto> data;
    Widget obtenerPuesto(){
   // puestos = await _fetchPuestos(comercioId);
    FutureBuilder<List<Puesto>>(
       future: _fetchPuestos(comercioId),
       builder: (context, snapshot){
         if(snapshot.hasData) {
          List<Puesto> data = snapshot.data;
           return Container();
           }
       }
      );}

      obtenerPuesto(); */

/*    puestos = data[0].comercioPuesto;    */
   MediaQueryData media = MediaQuery.of(context); 
  
  String unidad1;
  String speso1;
  String unidad2;
  String unidad3;
  String speso2;
  String speso3;

  if(precio1 == ''){
    unidad1 = '';
    speso1 = '';
  } else{
    unidad1 = unidad;
    speso1 = '\$';
  }
  if(precio2 == ''){
    unidad2 = '';
    speso2 = '';
  } else{
    unidad2 = unidad;
    speso2 = '\$';
  }
  if(precio3 == ''){
    unidad3 = '';
    speso3 = '';
  }else {
    unidad3 = unidad;
    speso3 = '\$';
  }
  return Container(
    padding: EdgeInsets.only(left:15.0),
     child: Column(
       children: <Widget>[
        Divider(
           color: Colors.black,
           endIndent: 15.0,
           height: 1.0,
           thickness: 0.5,
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                Navigator.pushNamed(context, 'detalleProdComp', arguments: ProductoDetalleArg('', title,descripcion,imagen,precio1,cantidad1,precio2,cantidad2,
                                  precio3,cantidad3,stock,unidad1,unidad2,unidad3,comercioId,mercadoId,'',ratingProd,categoriaId,'','','',
                                  comercioNave,comercioPuesto,'','','',comercio,false)); 

              },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: 
                      /* Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CachedNetworkImage('https://pbs.twimg.com/profile_images/945853318273761280/0U40alJG_400x400.jpg'),
          ) */
                      
                      
                      
                      /* FadeInImage(
                      height: 55  ,
                      width: 55,
                      fit: BoxFit.fill,
                      image: NetworkImage(imagen,scale: 0.1),
                      

                     placeholder: AssetImage('assets/img/original.gif'), */
                     /* MeetNetworkImage(
                        height: 55,
                        width: 55,
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.low,
                        
                        imageUrl:
                            imagen,
                        loadingBuilder: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                        errorBuilder: (context, e) => Center(
                              child: Text('Error appear!'),
                            ),
                      
                    ) */
                    Image.network(imagen,fit: BoxFit.fill,
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
                Navigator.pushNamed(context, 'detalleProdComp', arguments: ProductoDetalleArg('', title,descripcion,imagen,precio1,cantidad1,precio2,cantidad2,
                                  precio3,cantidad3,stock,unidad1,unidad2,unidad3,comercioId,mercadoId,'',ratingProd,categoriaId,'','','',
                                  comercioNave,comercioPuesto,'','','',comercio,false)); 

              },
                child: Container(
                  width: media.size.width * 0.63 ,
                  alignment: AlignmentDirectional.bottomStart,
                  padding: EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children:<Widget>[ 
                      SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Container(
                            child: Flexible(
                                                        child: Text(
                              title, style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                fontSize: 16.0, fontWeight: FontWeight.bold,
                                ))
                              ),
                            ),
                          ),
                        SizedBox(width: 10.0),
                        
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                                                    child: Container(
                                color: Color.fromRGBO(29, 233, 182, 1),
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width: 4.0),
                                    Text(
                                      ratingProd.toString(), style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.white,
                                        fontSize: 12.0, fontWeight: FontWeight.w500
                          ))),
                          SizedBox(width: 5.0),
                          Icon(Icons.star, color:Colors.white, size: 15.0 ),
                          SizedBox(width: 4.0),
                                  ],
                                ),
                              ),
                            ),
                          
                        ],
                      ),
                      SizedBox(height:6.0),
                      Row(
                        children: <Widget>[
                           Flexible(
                                child: Text(
                                '$comercio   Puesto:$comercioPuesto', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                  fontSize: 12.0, fontWeight: FontWeight.w400,
                          ))),
                           ),
                          
                        ],
                      ),
                       SizedBox(height:6.0),
                      Row(
                        children: <Widget>[
                           Flexible(
                                child: Text(
                                'Stock: $stock', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                  fontSize: 12.0, fontWeight: FontWeight.w600,
                          ))),
                           ),
                          
                        ],
                      ),
                      SizedBox(height:6.0),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 80.00,
                            child: Text(
                                '$speso1$precio1', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                  fontSize: 14.0, fontWeight: FontWeight.w600,
                            ))),
                          ),
                          Text(
                              '$cantidad1 $unidad1 ', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                fontSize: 12.0, fontWeight: FontWeight.w400,
                          ))),
                          

                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 80.00,
                            child: Text(
                                '$speso2$precio2', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                  fontSize: 14.0, fontWeight: FontWeight.w600,
                            ))),
                          ),
                          Text(
                              '$cantidad2 $unidad2 ', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                fontSize: 12.0, fontWeight: FontWeight.w400,
                          ))),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 80.00,
                            child: Text(
                                '$speso3$precio3', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                  fontSize: 14.0, fontWeight: FontWeight.w600,
                            ))),
                          ),
                          Text(
                              '$cantidad3 $unidad3 ', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                fontSize: 12.0, fontWeight: FontWeight.w400,
                          ))),
                        ],
                      ),
                    ]
                  ),
                ),
              ),
              GestureDetector(
                
                onTap: () async {
                  DateTime now = DateTime.now();
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String mercadoHora = prefs.getString('horaMercado');
                  String mercadoHoraFin = prefs.getString('horaMercadoFin');
                  
                  if (mercadoHora != 'Cerrado'){
                    DateTime horaInicio = DateTime.parse(mercadoHora);
                    DateTime horaFin = DateTime.parse(mercadoHoraFin);
                    if(now.hour >= horaInicio.hour){
                        if(now.hour < horaFin.hour){
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              title:  Center(child: Text('DISCULPA!!!')),
                              content:  SizedBox(
                                        width: media.size.width * 0.005,
                                        height: media.size.height * 0.1,
                                        child:  Center(child:  Text('Los pedidos se realizan luego del cierre del Mercado',
                                        textAlign: TextAlign.center,)),
                                    ),
                              backgroundColor: Colors.white

                        ),
                        barrierDismissible: true
                          ).then((_) => setState((){}));
                          } else {
                             _showModalSheet(title,imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioPuesto,comercioNave,comercioId,mercadoId,productoId,stock,context);
                          }
                      } else {
                        
                          _showModalSheet(title,imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioPuesto,comercioNave,comercioId,mercadoId,productoId,stock,context);
              
                      }

                  }else {
                      _showModalSheet(title,imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioPuesto,comercioNave,comercioId,mercadoId,productoId,stock,context);

                  
                  }},
                child: Icon(Icons.add_box,size: 35.0, color:Color.fromRGBO(0, 255, 208, 1))) 
            ],
          ),
       ],
     ),
  );
  }

  Future<void> _showModalSheet(title,imagen,precio1,precio2,precio3,cantidad1,cantidad2,cantidad3,comercio,unidad,ratingProd,comercioPuesto,comercioNave,comercioId,mercadoId,productoId,stock,context) async {

      int cantidadProd = 1;
      MediaQueryData media = MediaQuery.of(context);
      String precioProducto;
      double precioUnitario;

      var producto = Carrito(
        nombreProducto: title.toString(),
        fotoProducto: imagen.toString(),
        comercioProducto: comercio.toString(),
        cantidadProducto: cantidadProd,
        unidadProducto: unidad.toString(),
        precioProducto: precioProducto.toString(),
        precioUnitario: 0.0,
        productoId: int.parse(productoId),
        comercioId:int.parse(comercioId),
        mercadoId:int.parse(mercadoId),
        );

        String unidad1;
  String speso1;
  String unidad2;
  String unidad3;
  String speso2;
  String speso3;
  String x1;
  String x2;
  String x3;

  if(precio1 == ''){
    unidad1 = '';
    speso1 = '';
    x1 = '';
  } else{
    unidad1 = unidad;
    speso1 = '\$';
    x1 = 'x';
  }
  if(precio2 == ''){
    unidad2 = '';
    speso2 = '';
    x2 = '';
  } else{
    unidad2 = unidad;
    speso2 = '\$';
    x2 = 'x';
  }
  if(precio3 == ''){
    unidad3 = '';
    speso3 = '';
    x3 = '';
  }else {
    unidad3 = unidad;
    speso3 = '\$';
    x3 = '';
  }



      showModalBottomSheet(
          elevation: 300.0,
          context: context,
          builder: (builder) {
            int cantidad = 1;

            cantidadProd = cantidad;
            
            
            return StatefulBuilder(
              builder: (BuildContext context2, StateSetter setState) {
                return Container(
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.topLeft,
                 height: 900.0,
                 width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height:20.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: 
                              /* Container(
                                width: 100.0,
                                height: 110.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: CachedNetworkImage(imageUrl: imagen,),
                              ) */
                              
                              
                              
                              FadeInImage(
                              height: 100,
                              width: 110,
                              fit: BoxFit.fill,
                              image: NetworkImage(imagen),

                              placeholder: AssetImage('assets/img/original.gif')),
                            ),
                            SizedBox(width: 20.0,),
                            Container(
                              width: 200.0,
                              alignment: AlignmentDirectional.bottomStart,
                              padding: EdgeInsets.all(2.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children:<Widget>[ 
                                  Text(
                                  title, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                    fontSize: 20.0, fontWeight: FontWeight.bold,
                                    ))
                                  ),
                                  SizedBox(height:6.0),
                                  Text(
                                      '$speso1$precio1 $x1 $cantidad1$unidad1', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(2, 127, 100, 1),
                                        fontSize: 16.0, fontWeight: FontWeight.w600,
                                  ))),
                                  SizedBox(height:6.0),
                                  Text(
                                      '$speso2$precio2 $x2 $cantidad2$unidad2', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(2, 127, 100, 1),
                                        fontSize: 16.0, fontWeight: FontWeight.w600,
                                  ))),
                                  SizedBox(height:6.0),
                                  Text(
                                      '$speso3$precio3 $x3 $cantidad3$unidad3', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(2, 127, 100, 1),
                                        fontSize: 16.0, fontWeight: FontWeight.w600,
                                  )))
                                ]
                              )
                            ),
                            
                          ]
                ),
                SizedBox(height:15.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                    color: Color.fromRGBO(0, 255, 208,0.2 ),
                    height: media.size.height * 0.11,
                    width: double.infinity,
                    padding: EdgeInsets.all(13.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(width: 15.0),
                            Text(
                                      comercio, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                        fontSize: 16.0, fontWeight: FontWeight.w600,
                                  ))),

                          ],
                        ),
                        SizedBox(
                          height: media.size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 15.0),
                            Flexible(
                                    child: Text(
                                    'Puesto: $comercioPuesto Nave: $comercioNave', style: GoogleFonts.lato(textStyle:TextStyle(color:Colors.black,
                                      fontSize: 12.0, fontWeight: FontWeight.w400,
                              ))),
                               ),
                          ],
                        ),
                      ],
                      
                      
                    ),
                  ),
                ),
                  SizedBox(height:20.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                    GestureDetector(
                        onTap: () {
                        setState(() {
                          if (cantidad > 1) {
                            cantidad = cantidad - 1 ; 
                            cantidadProd = cantidad;}
                        });},
                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                          color: Color.fromRGBO(255, 81, 0, 1),
                          height: media.size.height * 0.06,
                          width: media.size.width * 0.18,
                          //padding: EdgeInsets.all(13.0),
                          child: Center(
                            child: Icon(Icons.remove)
                          ),

                        ),
                      ),
                    ),
                    SizedBox(width:20.0),
                    Text( '$cantidad $unidad', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(43, 47, 58, 1),
                                fontSize: 16.0, fontWeight: FontWeight.w600,
                          ))),
                    SizedBox(width:20.0),
                    GestureDetector(

                        onTap: () {
                          setState(() {
                            cantidad = cantidad + 1 ;
                            cantidadProd = cantidad;
                        });
                        },                  
                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                          color: Color.fromRGBO(0, 255, 208, 1),
                          height: media.size.height * 0.06,
                          width: media.size.width * 0.18,
                          //padding: EdgeInsets.all(13.0),
                          child: Center(
                            child: Icon(Icons.add)
                          ),

                        ),
                      ),
                    ),

                  ],),
                SizedBox(height:15.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                    child: GestureDetector(
                        
                      onTap: () async {


                        if (cantidad3 != '') {
                          int cantidadx3 = int.parse(cantidad3);
                          double preciox3   = double.parse(precio3);
                          if (cantidad >= cantidadx3) {
                            setState(() {
                              precioProducto = (preciox3 * cantidad).toString();
                              precioUnitario = preciox3;
                            });
                          }else{
                            int cantidadx2 = int.parse(cantidad2);
                            double preciox2   = double.parse(precio2);
                            if (cantidad >= cantidadx2) {
                              setState(() {
                                precioProducto = (preciox2 * cantidad).toString();
                                precioUnitario = preciox2;
                              });
                            }else {
                              int cantidadx1 = int.parse(cantidad1);
                              double preciox1   = double.parse(precio1);
                              setState(() {
                                precioProducto = (preciox1 * cantidad).toString();
                                precioUnitario = preciox1;
                              });
                            }
                          }
                        }else{
                          if (cantidad2 != '') {
                            int cantidadx2 = int.parse(cantidad2);
                            double preciox2   = double.parse(precio2);
                            if (cantidad >= cantidadx2) {
                              setState(() {
                                precioProducto = (preciox2 * cantidad).toString();
                                precioUnitario = preciox2;
                              });
                            }else {
                              int cantidadx1 = int.parse(cantidad1);
                              double preciox1   = double.parse(precio1);
                              setState(() {
                                precioProducto = (preciox1 * cantidad).toString();
                                precioUnitario = preciox1;
                              });
                            }
                        }else{
                          if (cantidad1 != '') {
                          int cantidadx1 = int.parse(cantidad1);
                          double preciox1   = double.parse(precio1);
                          setState(() {
                            precioProducto = (preciox1 * cantidad).toString();
                            precioUnitario = preciox1;
                          });
                          
                        } else{
                          setState(() {
                            precioProducto = '';
                            precioUnitario = 0.0;
                          });
                        }
                        }
                        }
                        setState(() {
                        producto.cantidadProducto = cantidad;
                        producto.precioProducto   = precioProducto.toString();
                        producto.precioUnitario = precioUnitario;
                        
                        });
                        
                        //DBProvider().deleteCarrito(1);



                        int stockProducto = int.parse(stock);

                        if(stockProducto < cantidad ){
                            final snackBarError = SnackBar(
                          backgroundColor: Colors.red,
                          content:  Text('Este producto no posee stock para dicha cantidad'),
                          action: SnackBarAction(
                            textColor: Colors.white,
                            label: 'Cerrar',
                            onPressed: () {
                              // Some code to undo the change.
                              },
                            ),
                          );

                        // Find the Scaffold in the widget tree and use
                        // it to show a SnackBar.
                          Navigator.pop(context);
                          widget.globalKey.currentState.showSnackBar(snackBarError);

                        } else {
                          await DBProvider().insertCarrito(producto,stockProducto);
                          final snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Se ha añadido al carrito!'),
                            action: SnackBarAction(
                              textColor: Colors.white,
                              label: 'Cerrar',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          // Find the Scaffold in the widget tree and use
                          // it to show a SnackBar.
                          Navigator.pop(context);
                          widget.globalKey.currentState.showSnackBar(snackBar);

                        }
                        
                        //Navigator.pushNamed(context, 'carrito', arguments: title);
                        },
                      child: Container(
                      color: Color.fromRGBO(29, 233, 182, 1),
                      height: media.size.height * 0.07,
                      width: media.size.width * 0.9,
                      //padding: EdgeInsets.all(13.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(width: 15.0),
                                  Text('Agregar producto', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(55, 71, 79, 1),
                                              fontSize: 14.0, fontWeight: FontWeight.w500,
                                        ))),
                                  SizedBox(width: 5.0),
                                  Icon(Icons.add_shopping_cart)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
                    ),
                ),
                    ],
                  ),
              );
              }
            );
          });
  }
}