import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../login_state.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 214, 0, 0),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: null,),
        title: Text('ENFOCATE'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.chat),
                     onPressed: () {
                       Provider.of<LoginState>(context).logout();
                     }, )
        ],

      ),
      body: 
        Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15.0,),
            _cardTipo1(context),
           // _cards1(context),
             SizedBox(height: 10.0,),
             _cardTipo2(context),
           // _cards2(context),
             SizedBox(height: 10.0,),
            _cardTipo3(context),
          ],)
      ),
      
    );
  }

    _cardTipo1(BuildContext context) {
    final estiloTitulo  = TextStyle(fontSize: 20.0,  color: Colors.white);
    final _screnSize = MediaQuery.of(context).size;
    final card = Container(
      //clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            GestureDetector(
                onTap: (){Navigator.pushNamed(context, 'planes');},
                child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fadeInDuration: Duration(milliseconds: 150),
                image: AssetImage('assets/img/planes.jpg'),
                height: _screnSize.height * 0.25,
                fit: BoxFit.cover,
                ),
            ),
            
            Row(
              children: <Widget>[
                SizedBox(height: 50.0,
                          width: 330.0,),
                Text('Planes',style: estiloTitulo),
              ],
            )
          ],
      ),
    );

    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: card,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.black,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 10.0)
          )
        ]
      ),
      );
  }

      _cardTipo2(BuildContext context) {
    final estiloTitulo  = TextStyle(fontSize: 20.0, color: Colors.white);
    final _screnSize = MediaQuery.of(context).size;
    final card = Container(
      //clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            GestureDetector(
                onTap: (){Navigator.pushNamed(context, 'planes');},
                child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fadeInDuration: Duration(milliseconds: 150),
                image: AssetImage('assets/img/comidas.jpg'),
                height: _screnSize.height * 0.25,
                fit: BoxFit.cover,
                ),
            ),
            
            Row(
              children: <Widget>[
                SizedBox(height: 50.0,
                          width: 255.0,),
                Text('Guía alimenticia',style: estiloTitulo),
              ],
            )
          ],
      ),
    );

    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: card,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.black,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 10.0)
          )
        ]
      ),
      );
  }

        _cardTipo3(BuildContext context) {
    final estiloTitulo  = TextStyle(fontSize: 20.0, color: Colors.white);
    final _screnSize = MediaQuery.of(context).size;
    final card = Container(
      //clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            GestureDetector(
                onTap: (){Navigator.pushNamed(context, 'planes');},
                child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fadeInDuration: Duration(milliseconds: 150),
                image: AssetImage('assets/img/recetas.jpg'),
                height: _screnSize.height * 0.25,
                fit: BoxFit.cover,
                ),
            ),
            
            Row(
              children: <Widget>[
                SizedBox(height: 50.0,
                          width: 320.0,),
                Text('Recetas',style: estiloTitulo),
              ],
            )
          ],
      ),
    );

    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: card,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.black,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 10.0)
          )
        ]
      ),
      );
  }

}

