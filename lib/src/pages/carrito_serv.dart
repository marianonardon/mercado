import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/providers/generar_pedido.dart';
import 'package:google_fonts/google_fonts.dart';

import 'carrito_db.dart';




class CarritosListView extends StatefulWidget {
  CarritosListView(this.categoriaId,this.mercadoId,this.userId,this.nombreUser,this.fotoUser,this.categoriaNombre);
  final String categoriaId;
  final String mercadoId;
  final String userId;
  final String nombreUser;
  final String fotoUser;
  final String categoriaNombre;
  @override
  _CarritosListViewState createState() => _CarritosListViewState(categoriaId,mercadoId,userId,nombreUser,fotoUser,categoriaNombre);
}

class _CarritosListViewState extends State<CarritosListView> {
  double totalPrecio = 0;
  _CarritosListViewState(this.categoriaId,this.mercadoId,this.userId,this.nombreUser,this.fotoUser,this.categoriaNombre);
  final String categoriaId;
  final String mercadoId;
  final String userId;
  final String nombreUser;
  final String fotoUser;
  final String categoriaNombre;


  String telefono;
  String nombre;
  String direccion;
  String comentarios;



  final telefonoController = TextEditingController();
  final nombreController = TextEditingController();
  final direccionController = TextEditingController();
  final comentariosController = TextEditingController();
  final formKey = GlobalKey<FormState>();




  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    telefonoController.dispose();
    nombreController.dispose();
    direccionController.dispose();
    comentariosController.dispose();
    super.dispose();
  }
  @override

  int cantidadProd = 1;
  
  Widget build(BuildContext context){
    MediaQueryData media = MediaQuery.of(context);
    return FutureBuilder<List<Carrito>>(
      future: DBProvider().getCarritos() ,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Carrito> data = snapshot.data;
          if (data.length == 0){
            return Center(
              child: Container(
                child: Column(
                   children: <Widget>[
                     Image(
                       image: AssetImage('assets/img/SinProductos.gif'),
                     ),
                    Text(
                    'No existen productos', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(98, 114, 123, 1),
                      fontSize: 24.0, fontWeight: FontWeight.w600,
                      ))                 
                    ),
                    Text(
                    'en el carrito', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(98, 114, 123, 1),
                      fontSize: 24.0, fontWeight: FontWeight.w600,
                      ))                 
                    ),
                     

                  ]
                )
                
                ),
            );

          }else{
          return Column(
            children: [
              _carritosListView(data),
              SizedBox(height: 15.0),
               Container( 
                  color: Colors.white,
                  child: conseguirTotal(data),
                ),
                SizedBox(height: 5.0,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                    child: GestureDetector(
                        
                      onTap: () {
                        MediaQueryData media = MediaQuery.of(context);
                        telefono = telefonoController.text;
                        nombre = nombreController.text;
                        direccion = direccionController.text;
                        comentarios = comentariosController.text;
                        showDialog(
                          context: context,
                          builder: (context) => WillPopScope(
                            onWillPop: () async => false,
                                      child: AlertDialog(
                              title: Center(child: Text('Ingrese sus datos para realizar la reserva',textAlign: TextAlign.center,)),
                              content:  SingleChildScrollView(
                                                              child: Form(
                                            key: formKey,
                                            child: SizedBox(
                                            width: media.size.width * 0.005,
                                            height: media.size.height * 0.6,
                                            child: Center(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(height: 10.0),
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    width: media.size.width * 0.90,
                                                    child: TextFormField(
                                                      validator: (telefono) {if (telefono.isEmpty) {
                                                          return 'El campo Teléfono no puede estar vacío!';
                                                          }else {
                                                            if(telefono.length < 10) {
                                                              return 'El campo Teléfono está incompleto!';
                                                            }else {
                                                            return null;}
                                                          }},
                                                              controller: telefonoController,
                                                              keyboardType: TextInputType.number,
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                                fontFamily: 'OpenSans',
                                                              ),
                                                              maxLength: 10,
                                                              maxLengthEnforced: true,
                                                              decoration: InputDecoration(
                                                                fillColor: Color.fromRGBO(240, 241, 246, 1),
                                                                  filled: true,
                                                                  border: 
                                                                  
                                                                  new OutlineInputBorder(

                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                    borderSide: BorderSide.none),
                                                            /*       borderSide: new BorderSide(
                                                                      color: Colors.greenAccent,
                                                                      width: 1.0,
                                                                    ), */
                                                                  labelText: 'Teléfono (sin 0 y sin 15)',
                                                                  labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                                                                    fontWeight: FontWeight.bold, fontSize: 14.0),
                                                                contentPadding: EdgeInsets.only(top: 5.0),
                                                                prefixIcon: Icon(
                                                                  Icons.phone,
                                                                  size: 25.0,
                                                                  //color: Colors.black,
                                                                ),
                                                                hintText: 'ej: 3512654599',
                                                                hintStyle: TextStyle(
                                                                            color: Colors.black,
                                                                            fontFamily: 'OpenSans',
                                                                          ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 10.0),
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    width: media.size.width * 0.90,
                                                    child: TextFormField(
                                                      validator: (nombre) {if (nombre.isEmpty) {
                                                          return 'El campo nombre/empresa no puede estar vacío!';
                                                          }else {
                                                            if(nombre.length < 1) {
                                                              return 'El campo nombre/empresa está incompleto!';
                                                            }else {
                                                            return null;}
                                                          }},
                                                              controller: nombreController,
                                                              keyboardType: TextInputType.text,
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                                fontFamily: 'OpenSans',
                                                              ),
                                                              maxLength: 30,
                                                              maxLengthEnforced: true,
                                                              decoration: InputDecoration(
                                                                fillColor: Color.fromRGBO(240, 241, 246, 1),
                                                                  filled: true,
                                                                  border: 
                                                                  
                                                                  new OutlineInputBorder(

                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                    borderSide: BorderSide.none),
                                                            /*       borderSide: new BorderSide(
                                                                      color: Colors.greenAccent,
                                                                      width: 1.0,
                                                                    ), */
                                                                  labelText: 'Nombre/Empresa',
                                                                  labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                                                                    fontWeight: FontWeight.bold, fontSize: 14.0),
                                                                contentPadding: EdgeInsets.only(top: 5.0),
                                                                prefixIcon: Icon(
                                                                  Icons.person,
                                                                  size: 25.0,
                                                                  //color: Colors.black,
                                                                ),
                                                                hintText: 'ej: Agile Market',
                                                                hintStyle: TextStyle(
                                                                            color: Colors.black,
                                                                            fontFamily: 'OpenSans',
                                                                          ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 10.0),
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    width: media.size.width * 0.90,
                                                    child: TextFormField(
                                                      validator: (direccion) {if (direccion.isEmpty) {
                                                          return 'El campo Dirección no puede estar vacío!';
                                                          }else {
                                                            if(direccion.length < 1) {
                                                              return 'El campo Dirección está incompleto!';
                                                            }else {
                                                            return null;}
                                                          }},
                                                              controller: direccionController,
                                                              keyboardType: TextInputType.text,
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                                fontFamily: 'OpenSans',
                                                              ),
                                                              maxLength: 100,
                                                              maxLengthEnforced: true,
                                                              decoration: InputDecoration(
                                                                fillColor: Color.fromRGBO(240, 241, 246, 1),
                                                                  filled: true,
                                                                  border: 
                                                                  
                                                                  new OutlineInputBorder(

                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                    borderSide: BorderSide.none),
                                                            /*       borderSide: new BorderSide(
                                                                      color: Colors.greenAccent,
                                                                      width: 1.0,
                                                                    ), */
                                                                  labelText: 'Dirección',
                                                                  labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                                                                    fontWeight: FontWeight.bold, fontSize: 14.0),
                                                                contentPadding: EdgeInsets.only(top: 5.0),
                                                                prefixIcon: Icon(
                                                                  Icons.location_on,
                                                                  size: 25.0,
                                                                  //color: Colors.black,
                                                                ),
                                                                hintText: '24 de Septiembre 1490',
                                                                hintStyle: TextStyle(
                                                                            color: Colors.black,
                                                                            fontFamily: 'OpenSans',
                                                                          ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 10.0),
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    width: media.size.width * 0.90,
                                                    child: TextFormField(
                                                      
                                                              controller: comentariosController,
                                                              keyboardType: TextInputType.text,
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                                fontFamily: 'OpenSans',
                                                              ),
                                                              maxLength: 140,
                                                              maxLengthEnforced: true,
                                                              decoration: InputDecoration(
                                                                fillColor: Color.fromRGBO(240, 241, 246, 1),
                                                                  filled: true,
                                                                  border: 
                                                                  
                                                                  new OutlineInputBorder(

                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                    borderSide: BorderSide.none),
                                                            /*       borderSide: new BorderSide(
                                                                      color: Colors.greenAccent,
                                                                      width: 1.0,
                                                                    ), */
                                                                  labelText: 'Comentarios',
                                                                  labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                                                                    fontWeight: FontWeight.bold, fontSize: 14.0),
                                                                contentPadding: EdgeInsets.only(top: 5.0),
                                                                prefixIcon: Icon(
                                                                  Icons.message,
                                                                  size: 25.0,
                                                                  //color: Colors.black,
                                                                ),
                                                                hintText: 'ej: Prefiero retirar por la tarde',
                                                                hintStyle: TextStyle(
                                                                            color: Colors.black,
                                                                            fontFamily: 'OpenSans',
                                                                          ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: media.size.width * 0.01,),
                                                          Center(
                                                            child: FlatButton(
                                                              color: Color.fromRGBO(29, 233, 182, 1),
                                                              onPressed: () async {
                                                                if (formKey.currentState.validate()) {
                                                                  Navigator.of(context);
                                                                  showDialog(
                                                                    context: formKey.currentContext,
                                                                    builder: (context) => WillPopScope(
                                                                      onWillPop: () async => false,
                                                                                child: AlertDialog(
                                                                        title: Center(child: Text('Cargando pedido')),
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
                                                                    GenerarPedido(categoriaId,mercadoId,userId,nombreUser,fotoUser,categoriaNombre).createProducto(data,telefonoController.text,
                                                                    nombreController.text,direccionController.text,comentariosController.text, context);
                                                                }
                                                                
                                                              },
                                                              child: Text('Confirmar reserva'),
                                                              textColor: Colors.black,
                                                            
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ),
                                        ),
                                ),
                              ),
                              backgroundColor: Colors.white

                        ),
                          ),
                        barrierDismissible: false,
                          ).then((_) => setState((){}));
                        /* showDialog(
                          context: context,
                          builder: (context) => WillPopScope(
                            onWillPop: () async => false,
                                      child: AlertDialog(
                              title: Center(child: Text('Cargando pedido')),
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
                          ).then((_) => setState((){})); */
                        
                        //GenerarPedido(categoriaId,mercadoId,userId,nombreUser,fotoUser,categoriaNombre).createProducto(data, context);
                        },
                      child: Container(
                      color: Color.fromRGBO(29, 233, 182, 1),
                      height: media.size.height * 0.07,
                      width: media.size.width * 0.9,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(width: 10.0),
                                  Text('Confirmar reserva', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                              fontSize: 16.0, fontWeight: FontWeight.w500,
                                        ))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
                    ),
                ),
                SizedBox(height: 5.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                    child: GestureDetector(
                        
                      onTap: () {
                        
                        DBProvider().deleteCarrito(1);
                        setState(() {
                          
                        });
                        },
                      child: Container(
            width: double.infinity,
            height: media.size.height * 0.1,
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
                    child: Text('Vaciar carrito',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(195, 15,0, 1),
                    fontSize: 16.0, fontWeight: FontWeight.w600,
                    ))),
                  )
                
                ),
                ]
                ),
          ),
                    ),
                ),
                SizedBox(height: 20.0),
            ],
          );}
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }



     Widget _carritosListView(data) {
      return Container(
        child: Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return _crearLista(data[index].nombreProducto,
                              data[index].fotoProducto, data[index].comercioProducto, data[index].cantidadProducto,
                              data[index].unidadProducto, data[index].precioProducto,
                              data[index].precioUnitario,data[index].productoId,data[index].comercioId,data[index].mercadoId,
                              context);
              }
              ),
               
          ],
        ),
      );
        
  }

    Widget _crearLista(String title, String imagen, String comercio, int cantidad, String unidad,String precio,double precioUnitario,
                       int productoId,comercioId,mercadoId, context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
          color: Colors.white,
          width: 600.0,
      //   height: 500.0, */
        child: Column(
          children: <Widget>[
          //  _crearTitulo(),
            SizedBox(height: 15.0),
           _crearTarjetas(title, imagen,comercio,cantidad,unidad,precio,precioUnitario,productoId,comercioId,mercadoId,context),
          ],
        ),
      ),
      
    );
    
  }

  Widget _crearTarjetas(title, imagen,comercio,cantidad,unidad,precio,precioUnitario,productoId,comercioId,mercadoId,context) {
  cantidadProd = cantidad;

  return  Container(
    padding: EdgeInsets.only(left:5.0),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage(
            height: 55,
            width: 55,
            fit: BoxFit.fill,
            image: NetworkImage(imagen),

            placeholder: AssetImage('assets/img/original.gif')),
          ),
          SizedBox(width: 15.0),
          Container(
            width: 180.0,
            alignment: AlignmentDirectional.bottomStart,
            padding: EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children:<Widget>[ 
                Text(
                title, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                  fontSize: 16.0, fontWeight: FontWeight.bold,
                  ))
                ),
                SizedBox(height:6.0),
                Text(
                    comercio, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                      fontSize: 12.0, fontWeight: FontWeight.w400,
                ))),
                SizedBox(height:6.0),
                Row(
                  children: <Widget>[
                    Text(
                        '$cantidadProd $unidad ', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(2, 127, 100, 1),
                          fontSize: 14.0, fontWeight: FontWeight.w700,
                    ))),
                  
                  ],
                )
              ]
            ),
          ),


                SizedBox(width:7.0),
                Flexible(
                        child: Text( '\$$precio', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(2, 127, 100, 1),
                          fontSize: 14.0, fontWeight: FontWeight.w700,
                    ))),
                  ),
                

              ],),
        
  );

  }

  conseguirTotal(data) {
    MediaQueryData media = MediaQuery.of(context);
    double precioTotal = 0.0;
    String precioString;
    double precio = 0.0;
    for(var i = 0; i< data.length; i++) {
      precioString = data[i].precioProducto;
      if( precioString != '') {
      precio = double.parse(precioString);
      }else {
        precio = 0.0;
      }
      precioTotal = precio + precioTotal;
    }
    String totPrec = precioTotal.toString();
    return Container(
      height: 70.0,
      width: double.infinity,

      child: Row(
        children: <Widget>[
          SizedBox(width: 20.0),
          Text('Monto Total:',style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                              fontSize: 16.0, fontWeight: FontWeight.w400,
                                        )),
          ),
          SizedBox(width: media.size.width * 0.36),
          Expanded(
            child: Text('\$$totPrec',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(2, 127, 100, 1),
                fontSize: 16.0, fontWeight: FontWeight.w700,
          ))))
        ],
      )
    );
  }

  
}


  