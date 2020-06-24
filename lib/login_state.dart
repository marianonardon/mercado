import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';




class LoginState with ChangeNotifier {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _loggedIn = false;

  bool _loading = false;

  bool isLoggedIn() => _loggedIn; 

  bool isLoading() => _loading;



  void login() async{
    _loading = true;
    notifyListeners();
    var user = await handleSignIn();

    _loading = false;
    if (user != null) {
      _loggedIn = true;
      _googleSignIn.signOut();
      notifyListeners();
    } else {
      _loggedIn = false;
      notifyListeners();

    }
  }

  void logout() {
    _googleSignIn.signOut();
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

    Widget loginCancelado() {
      _loading = false;
                _loggedIn = false;
                notifyListeners();
    }
}