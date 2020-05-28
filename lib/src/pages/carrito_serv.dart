import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'carrito_db.dart';


double totalPrecio;

class CarritosListView extends StatefulWidget {
  @override
  _CarritosListViewState createState() => _CarritosListViewState();
}

class _CarritosListViewState extends State<CarritosListView> {
  @override

  int cantidadProd = 1;
  Widget build(BuildContext context){
    return FutureBuilder<List<Carrito>>(
      future: DBProvider().getCarritos() ,
      builder: (context, snapshot) {
        totalPrecio = 0;
        if (snapshot.hasData) {
          List<Carrito> data = snapshot.data;
          return _carritosListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }



     ListView _carritosListView(data) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _crearLista(data[index].nombreProducto,
                        data[index].fotoProducto, data[index].comercioProducto, data[index].cantidadProducto,
                        data[index].unidadProducto, data[index].precioProducto,
                        context);
        }
        );
        
  }

    Widget _crearLista(String title, String imagen, String comercio, int cantidad, String unidad,String precio, context) {
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
           _crearTarjetas(title, imagen,comercio,cantidad,unidad,precio,context),
          ],
        ),
      ),
      
    );
    
  }

  Widget _crearTarjetas(title, imagen,comercio,cantidad,unidad,precio,context) {
  cantidadProd = cantidad;
  totalPrecio = double.parse(precio) + totalPrecio;

  return StatefulBuilder(
  builder: (BuildContext context, StateSetter setState) {
  return Container(
    padding: EdgeInsets.only(left:5.0),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage(
            height: 90,
            width: 90,
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
                  fontSize: 20.0, fontWeight: FontWeight.bold,
                  ))
                ),
                SizedBox(height:6.0),
                Text(
                    comercio, style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                      fontSize: 15.0, fontWeight: FontWeight.w400,
                ))),
                SizedBox(height:6.0),
                Row(
                  children: <Widget>[
                    Text(
                        '\$$precio $unidad ', style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(2, 127, 100, 1),
                          fontSize: 20.0, fontWeight: FontWeight.w700,
                    ))),
                  
                  ],
                )
              ]
            ),
          ),

          ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                color: Colors.grey[100],
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                GestureDetector(
                    onTap: () {
                    setState(() {
                      cantidadProd = cantidad;
                      if (cantidadProd > 1) {
                        cantidadProd = cantidadProd - 1 ; 
                        cantidad = cantidadProd;}
                    });},
                    child: ClipRRect(
                    borderRadius: BorderRadius.circular(1.0),
                      child: Container(
                      color: Colors.transparent,
                      height: 25.0,
                      width: 25.0,
                      child: Center(
                        child: Icon(Icons.remove, color: Colors.black,)
                      ),

                    ),
                  ),
                ),
                SizedBox(width:7.0),
                Text( '$cantidadProd $unidad', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                            fontSize: 17.0, fontWeight: FontWeight.w400,
                      ))),
                SizedBox(width:7.0),
                GestureDetector(

                    onTap: ([index]) {
                      setState(() {
                        cantidadProd = cantidad;
                        cantidadProd = cantidadProd + 1 ;
                        cantidad = cantidadProd;
                    });
                    },                  
                    child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                      color: Colors.transparent,
                      height: 25.0,
                      width: 25.0,
                      child: Center(
                        child: Icon(Icons.add)
                      ),

                    ),
                  ),
                ),

              ],),
            ),
          )


        ],
      ),
  );
  }
  );

  }

  
}


  conseguirTotal() {
    String totPrec = totalPrecio.toString();
    return Container(
      height: 70.0,
      width: double.infinity,

      child: Row(
        children: <Widget>[
          SizedBox(width: 20.0),
          Text('Monto Total:',style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                              fontSize: 20.0, fontWeight: FontWeight.w400,
                                        )),
          ),
          SizedBox(width: 140.0),
          Expanded(
            child: Text('\$$totPrec',style: GoogleFonts.rubik(textStyle:TextStyle(color:Color.fromRGBO(2, 127, 100, 1),
                fontSize: 22.0, fontWeight: FontWeight.w700,
          ))))
        ],
      )
    );
  }