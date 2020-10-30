

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/productos_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'categorias_serv.dart';
import 'combo_puestos.dart';
import 'combo_puestos_multi.dart';
import 'mercados_serv.dart';





class ProductosBusquedaPage extends StatefulWidget {
  @override
  _ProductosBusquedaPageState createState() => _ProductosBusquedaPageState();
}

class _ProductosBusquedaPageState extends State<ProductosBusquedaPage> {

  
  final nombreController = TextEditingController();

    @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    nombreController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);


    final ProductosArguments args = ModalRoute.of(context).settings.arguments;

    

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
            child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            
        backgroundColor: Color.fromRGBO(29, 233, 182, 1),
        title: Text('Filtros de búsqueda',style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600))),
        leading: new IconButton(
          icon: new Icon(Icons.backspace, size:35),
          onPressed: () {
            if(args.categoriaId == ''){
               Navigator.pushNamed(context, 'categorias', arguments: ScreenArguments(args.userId, args.nombreUser, args.fotoUser,args.mercadoId));
             } else {
               Navigator.pushNamed(context, 'productos', arguments: ProductosArguments(args.categoriaId,args.mercadoId,'',args.userId,args.nombreUser,args.fotoUser,args.categoriaNombre,''));
             }
             }),
        ),
          body: Container(
              child: SingleChildScrollView(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    

                    Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          width: media.size.width * 0.95,
                          padding: EdgeInsets.all(16),
              
                  child: TextFormField(
                        validator: (nombre) {if (nombre.isEmpty) {
                            return 'El campo Nombre no puede estar vacío!';
                            }else {
                              return null;
                            }},
                        controller: nombreController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                        ),
                        decoration: InputDecoration(
                          fillColor: Color.fromRGBO(240, 241, 246, 1),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none
                            ),
                          //labelText: 'Nombre de producto *',
                          labelStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
                                    fontWeight: FontWeight.bold, fontSize: 14.0),
                          contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0, 5.0),
                          hintText: 'Buscar producto',
                          hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'OpenSans',
                                    ),
                        ),
                  ),),
                  
                      ],
                    ),
                    SizedBox(height: media.size.height * 0.05),

                    Column(
                          children: <Widget>[
                            ComboPuesto2(args.mercadoId),
                            SizedBox(height: media.size.height * 0.08),
                                Center(
                                  child: FlatButton(
                                    color: Color.fromRGBO(29, 233, 182, 1),
                                    onPressed: () async {
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      String puestosId = prefs.getString('idPuesto');
                                      String puesto2;
                                      List<dynamic> puestoLista;
                                      puesto2 = '[$puestosId]';
                                      puestoLista = json.decode(puesto2);
                                      String puestosId2 = puestoLista.toString();
                                      puestosId2 = puestosId2.replaceAll('[', '').replaceAll(']', '');
                                      Navigator.pushNamed(context, 'resultadoProducto', arguments: ProductosArguments(args.categoriaId,args.mercadoId,nombreController.text,
                                      args.userId,args.nombreUser,args.fotoUser,args.categoriaNombre,puestosId2));
                                      
                                      //String productoId2;
                                      //productoId2 = await deleteProducto(args.idProducto,args);
                                    },
                                    child: Text('Buscar'),
                                    textColor: Colors.black,
                                  
                                  ),
                                ),
                                SizedBox(height: media.size.height * 0.02),
                                Center(
                                  child: FlatButton(
                                    color: Colors.red[400],
                                    onPressed: ()  async {

                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setString('idPuesto', '' );
                                      Navigator.pushNamed(context, 'buscarProducto', arguments: ProductosArguments(args.categoriaId,args.mercadoId,'',args.userId,args.nombreUser,args.fotoUser,args.categoriaNombre,''));
                                      
                                      
                                      //String productoId2;
                                      //productoId2 = await deleteProducto(args.idProducto,args);
                                    },
                                    child: Text('Limpiar filtros'),
                                    textColor: Colors.white,
                                  
                                  ),
                                ),
                              
                          ],
                        ),

                  ],
                ),
              ),
          ),
         // bottomNavigationBar: _bottomNavigationBar(context)
        ),

    ));
  }
}