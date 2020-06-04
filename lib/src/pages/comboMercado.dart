import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ComboMercado extends StatefulWidget {
  ComboMercado({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ComboMercado> {
  String dropdownValue = 'Mercado Norte';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Mercado',style: GoogleFonts.roboto(textStyle: TextStyle(color:Color.fromRGBO(0, 0, 0,0.6), 
        fontWeight: FontWeight.normal, fontSize: 18.0))),
        SizedBox(height: 10.0),
        Container(
                alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
                color: Color.fromRGBO(240, 241, 246, 1),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
          height: 60.0,
          width: 370.0,
          child: DropdownButton<String>(
            value: dropdownValue,
            isExpanded: true,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>['Mercado Norte', 'Mercado Sur', 'Mercado Berbo', 'Mercado Abasto'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}