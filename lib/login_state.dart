import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('usuarioId', user.uid).catchError((onError) =>
          print("Error $onError")
        );
    prefs.setString('nombre', user.  displayName);
    prefs.setString('fotoUser', user.photoUrl);
    print(user.uid + user.email + user.displayName);
    
    return user;
}

    Widget loginCancelado() {
      _loading = false;
                _loggedIn = false;
                notifyListeners();
    }
}