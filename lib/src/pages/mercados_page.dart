import 'dart:async';

import 'package:flutter/material.dart';


class MercadoPage extends StatefulWidget {
  @override
  _MercadoPageState createState() => _MercadoPageState();
}

class _MercadoPageState extends State<MercadoPage> {


  ScrollController _scrollController = new ScrollController();
  List<int> _listaNumeros = new List();
  int _ultimoItem = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _agregar10();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        //_agregar10();
        fetchData();
      }
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],

      body:

          Stack(
            children: <Widget>[
                 // _crearTitulo(),
                  _crearLista(),
                  _crearLoading()
                  ]
                )
      );
          
       

  }

  Widget _crearLista() {
    return  RefreshIndicator(
        onRefresh: obtenerPagina1,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            //  _crearTitulo(),
              ListView.builder(
              controller: _scrollController,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index){
                return  ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    
/*               width: 800.0,
                    height: 500.0, */
                    child: Column(
                      children: <Widget>[
                      //  _crearTitulo(),
                        SizedBox(height: 20.0),
                        Stack(
                        

                          children: <Widget> [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(20.0),
                              child: FadeInImage(
                              height: 200,
                              fit: BoxFit.cover,
                             image: NetworkImage('https://zainduzaitez.com/wp-content/uploads/2015/09/mercadoabastos.jpg'),

                              placeholder: AssetImage('assets/img/original.gif')),
                           ),

                            Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: ClipRRect(
                               borderRadius: BorderRadius.circular(20.0), 
                               child: Container(
                                 child: Column(
                                    children:<Widget>[ 
                                      Row(
                                        children: <Widget>[
                                          Icon(Icons.local_activity, color: Colors.white,),
                                          Text(
                                          'Mercado de abasto', style: TextStyle(color:Colors.white,
                                            fontSize: 25.0, fontWeight: FontWeight.bold),
                                    ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(Icons.location_on, color: Colors.white,),
                                          Text(
                                          'Humberto primo 525, Córdoba', style: TextStyle(color:Colors.white,
                                            fontSize: 20.0, fontWeight: FontWeight.bold),
                                    ),
                                        ],
                                      )
                                    ]
                                  ),
                               ),
                              ),
                            )
                            ]
                        ),
                      ],
                    ),
                  ),
                );
              },
              
              
              ),
            ],
          ),
        ),
    );

  }

  Future<Null> obtenerPagina1() async {
    final duration = new Duration(seconds: 2);

    new Timer(duration, (){
        _listaNumeros.clear();
        _ultimoItem++;
        _agregar10();
    });
    return Future.delayed(duration);
  }

  void _agregar10(){
    for (var i = 1; i < 10; i++) {
      _ultimoItem++;
      _listaNumeros.add(_ultimoItem);
    }
    setState(() {
      
    });
  }

   Future<Null> fetchData() async {
     _isLoading = true;
     setState(() {});

     final duration = new Duration(seconds: 2);
     new Timer(duration, respuestaHTTP);

   }

   void respuestaHTTP() {

     _isLoading = false;
     _scrollController.animateTo(
       _scrollController.position.pixels + 100,
       duration: Duration(milliseconds: 250),
       curve: Curves.fastOutSlowIn);



     _agregar10();

   }

   Widget _crearLoading() {

     if (_isLoading) {
       return Column(
         mainAxisSize: MainAxisSize.max,
         mainAxisAlignment: MainAxisAlignment.end,
         children: <Widget>[
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               CircularProgressIndicator()
             ]
           ),
           SizedBox(height: 15.0)
         ],
       );

     } else {
       return Container();
     }
   }

   Widget _crearTitulo() {
     return SafeArea(
       child: Container(
         padding: EdgeInsets.all(20.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget> [
             Text('En que mercado quieres comprar?', style: TextStyle(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),),
             SizedBox(height: 1.0),
           ]
           )
       )
       );

   }

}