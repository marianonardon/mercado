

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/productos_serv.dart';
import 'package:google_fonts/google_fonts.dart';

import 'categorias_serv.dart';





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

    

    return SafeArea(
            child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
              child: SingleChildScrollView(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    

                    Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          width: media.size.width * 0.80,
                          padding: EdgeInsets.only(left:10.0),
              
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
                  SizedBox(width: media.size.width * 0.03,),
                  GestureDetector(
                    onTap: () {Navigator.pushNamed(context, 'resultadoProducto', arguments: ProductosArguments(args.categoriaId,args.mercadoId,nombreController.text,
                    args.userId,args.nombreUser,args.fotoUser,args.categoriaNombre));},
                                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        width: 45.0,
                        height: 45.0,
                        color: Color.fromRGBO(29, 233, 182, 1),
                        child:  Center(child: Icon(Icons.search, size:35.0)),)),
                  )
                      ],
                    )
                  ],
                ),
              ),
          ),
         // bottomNavigationBar: _bottomNavigationBar(context)
        ),

    );
  }
}