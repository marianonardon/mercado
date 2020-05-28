import 'package:flutter/material.dart';
import 'package:flutter_login_ui/src/pages/carrito_serv.dart';
import 'package:google_fonts/google_fonts.dart';

class CarritoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito', style: GoogleFonts.rubik(textStyle: TextStyle(color:Colors.black, fontWeight: FontWeight.w600))),
        backgroundColor: Color.fromRGBO(29, 233, 182, 1),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {}
          )
        ],),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
         child: Column(
          children: <Widget>[
            Container(
                color: Colors.white,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(height: 30.0,),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15.0,0.0,0.0,0.0,),
                        child: Text('Lista de productos', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                              fontSize: 20.0, fontWeight: FontWeight.w500,
                                        ))),
                      ),
                      SizedBox(height: 10.0,),
                      Container(
                        padding: EdgeInsets.only(left:15.0),
                        child: CarritosListView(),),
                    ],
                  ),
            ),
           SizedBox(height: 15.0,),
           Container( 
             color: Colors.white,
             child: conseguirTotal(),),
          SizedBox(height: 15.0,),
          ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                    child: GestureDetector(
                        
                      onTap: () {
                        Navigator.pushNamed(context, 'confRes');},
                      child: Container(
                      color: Color.fromRGBO(29, 233, 182, 1),
                      height: 50.0,
                      width: 370.0,
                      padding: EdgeInsets.all(13.0),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(width: 15.0),
                                Text('Confirmar reserva', style: GoogleFonts.rubik(textStyle:TextStyle(color:Colors.black,
                                            fontSize: 20.0, fontWeight: FontWeight.w500,
                                      ))),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ),
                    ),
                ),
                SizedBox(height: 15.0)
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(context)
    );
  }


    Widget _bottomNavigationBar(BuildContext context) {
    return new Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white,
        primaryColor: Colors.black,
        textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.grey))
      ),
      child: BottomNavigationBar(
        
        currentIndex: 1,
        //onTap: (newIndex) => setState(() => _index = newIndex),
                items: [
                    BottomNavigationBarItem(
                    icon: Icon(Icons.store, size: 30.0),
                    title: Container(),
                    ),
                    BottomNavigationBarItem(
                    icon: Icon(Icons.local_grocery_store, size: 30.0),
                    title: Container()
                    ),
                    BottomNavigationBarItem(
                    icon: Icon(Icons.my_location, size: 30.0),
                    title: Container()
                    ),
                ])
              );
        
              
          }
        
          setState(int Function() param0) {}

}