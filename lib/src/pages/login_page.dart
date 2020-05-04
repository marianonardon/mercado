import 'package:flutter/material.dart';
import 'package:flutter_login_ui/login_state.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<LoginState>(
            builder: (BuildContext context, LoginState value, Widget child) {
              if (value.isLoading()) {
                return CircularProgressIndicator();
              } else {
                return child;
              }
            },
            child: RaisedButton(
            onPressed: () {
              Provider.of<LoginState>(context).login();
            } ,
            child: Text('Sign In'),),
        )
      )
      
    );
  }

  
}