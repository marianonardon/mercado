import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';




enum LoginProvider{
  google,
  facebook,
}



class LoginState with ChangeNotifier {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _loggedIn = false;

  bool _loading = false;

  bool isLoggedIn() => _loggedIn; 

  bool isLoading() => _loading;

  FirebaseUser _user;



  void login(LoginProvider loginProvider) async{
    _loading = true;
    _loggedIn = false;
    notifyListeners();

    switch(loginProvider) {
      case LoginProvider.google:
        _user = await handleSignIn();
        break;
      case LoginProvider.facebook:
        _user = await handleFacebookSignIn();
        break;

    }
    

    _loading = false;
    if (_user != null) {
      _loggedIn = true;   
      notifyListeners();
    } else {
      _loggedIn = false;
      notifyListeners();

    }
  }

  void logout() {
    _googleSignIn.signOut();
    FacebookLogin().logOut();
    _loggedIn = false;
    notifyListeners();
  }

  Future<FirebaseUser> handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn().catchError((onError) => 
    print('maro'));             
      test: GoogleSignIn.kSignInCanceledError.isNotEmpty;



/*       _loading = false;
      _loggedIn = false;
      notifyListeners();

    }); */

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('usuarioId', googleUser.id).catchError((onError) =>
          print("Error $onError")
        );
    prefs.setString('nombre', googleUser.displayName);
    prefs.setString('fotoUser', googleUser.photoUrl);
    prefs.setString('usuarioId2', '');
    print(googleUser.id + googleUser.email + googleUser.displayName);
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken

    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName +' ' + user.uid + '  ' + user.providerId + ' ' + user.email);
    return user;
}

  Future<FirebaseUser> handleFacebookSignIn() async {
    final facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;

    final result = await facebookLogin.logIn(['email']);
    if (result.status != FacebookLoginStatus.loggedIn) {
      return null;
    }

/*       _loading = false;
      _loggedIn = false;
      notifyListeners();

    }); */




    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: result.accessToken.token,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName +' ' + user.uid + '  ' + user.providerId + ' ' + user.email);
    final token = result.accessToken.token;
    final graphResponse = await http.get(
                'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
    final  profile = json.decode(graphResponse.body);
    final profile2 = Profile.fromJson(profile);
    String idUsuario = profile2.id;
  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('usuarioId', idUsuario).catchError((onError) =>
          print("Error $onError")
        );
    prefs.setString('nombre', user.  displayName);
    prefs.setString('fotoUser', user.photoUrl);
    prefs.setString('usuarioId2', '');
    print(user.uid + user.email + user.displayName);
    
    return user;
}

    Widget loginCancelado() {
      _loading = false;
                _loggedIn = false;
                notifyListeners();
    }
}

class Profile {
  final String name;
  final String firstName;
  final String lastName;
  final String email;
  final String id;

  Profile({this.name, this.firstName,this.lastName,this.email,this.id});

  factory Profile.fromJson(Map<String, dynamic> parsedJson) {
    return Profile(
      name: parsedJson['name'],
      firstName: parsedJson['first_name'],
      lastName: parsedJson['last_name'],
      email: parsedJson['email'],
      id: parsedJson['id'],
    );
  }
}