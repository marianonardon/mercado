import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_ui/src/pages/mercados_serv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter_login_ui/src/pages/carrito_db.dart';
import 'package:apple_sign_in/apple_sign_in.dart';




enum LoginProvider{
  google,
  facebook,
  apple,
}



class LoginState with ChangeNotifier {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _loggedIn = false;

  bool _loading = false;

  bool isLoggedIn() => _loggedIn; 

  bool isLoading() => _loading;

  FirebaseUser _user;

  


 Future<void> isLogin(context) async {
   
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String loginEstado = prefs.getString('login');
    String usuarioId = prefs.getString('usuarioId2');
    String nombreUser = prefs.getString('nombre');
    String fotoUser = prefs.getString('fotoUser');
    if (loginEstado == 'true' ) {
      _loggedIn = true;
      notifyListeners();
    }
    if (loginEstado == 'trueManual'){
       _loggedIn = true;
      Navigator.pushNamed(context, 'puestos',arguments: ScreenArguments(usuarioId,nombreUser,fotoUser,''));
      notifyListeners();
    }
  }


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
      case LoginProvider.apple:

      final authResult = await signInWithApple();
       _user = authResult.user;
       SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('usuarioId', _user.uid).catchError((onError) =>
              print("Error $onError")
            );
        prefs.setString('nombre', _user.displayName);
        prefs.setString('fotoUser', _user.photoUrl);
        prefs.setString('usuarioId2', '');
        prefs.setString('login', 'true');
        print(_user.uid + _user.email + _user.displayName);  
       

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

  Future<void> logout() async {
    _googleSignIn.signOut();
    FacebookLogin().logOut();
    
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('login', 'false');
    _loggedIn = false;
    DBProvider().deleteCarrito(1);
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
    prefs.setString('login', 'true');
    print(googleUser.id + googleUser.email + googleUser.displayName);
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken

    );

    final AuthResult user = await _auth.signInWithCredential(credential);
    print("signed in " + user.user.displayName +' ' + user.user.uid + '  ' + user.user.providerId + ' ' + user.user.email);
    return user.user;
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

    final AuthResult user = await _auth.signInWithCredential(credential);
    print("signed in " + user.user.displayName +' ' + user.user.uid + '  ' + user.user.providerId + ' ' + user.user.email);
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
    prefs.setString('nombre', user.user.displayName);
    prefs.setString('fotoUser', user.user.photoUrl);
    prefs.setString('usuarioId2', '');
    prefs.setString('login', 'true');
    print(user.user.uid + user.user.email + user.user.displayName);
    
    return user.user;
}

 

    Widget loginCancelado() {
      _loading = false;
                _loggedIn = false;
                notifyListeners();
    }

  Future<FirebaseUser> signInWithAppleee({List<Scope> scopes = const []}) async {
    final _firebaseAuth = FirebaseAuth.instance;
    
    // 1. perform the sign-in request
    final result = await AppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider(providerId: 'apple.com');
        final credential = oAuthProvider.getCredential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode),
        );
        final authResult = await _firebaseAuth.signInWithCredential(credential);
        final firebaseUser = authResult.user;
        
        if (scopes.contains(Scope.fullName)) {
          final updateUser = UserUpdateInfo();
          updateUser.displayName =
              '${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}';
          await firebaseUser.updateProfile(updateUser);
        }
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('usuarioId', firebaseUser.uid).catchError((onError) =>
              print("Error $onError")
            );
        prefs.setString('nombre', firebaseUser.displayName);
        prefs.setString('fotoUser', firebaseUser.photoUrl);
        prefs.setString('usuarioId2', '');
        prefs.setString('login', 'true');
        print(firebaseUser.uid + firebaseUser.email + firebaseUser.displayName);  

        return firebaseUser;
      case AuthorizationStatus.error:
        print(result.error.toString());
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
    }
    return null;
  }

  Future<AuthResult> signInWithApple() async {

    final AuthorizationResult result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);
    switch (result.status) {
      case AuthorizationStatus.authorized:
        try {
          print("successfull sign in");
          final AppleIdCredential appleIdCredential = result.credential;
          OAuthProvider oAuthProvider = new OAuthProvider(providerId: "apple.com");
          final AuthCredential credential = oAuthProvider.getCredential(
            idToken: String.fromCharCodes(appleIdCredential.identityToken),
            accessToken: String.fromCharCodes(appleIdCredential.authorizationCode),
          );
          final AuthResult _res = await FirebaseAuth.instance
          .signInWithCredential(credential);

        FirebaseAuth.instance.currentUser().then((val) async {
         
          UserUpdateInfo updateUser = UserUpdateInfo();
          updateUser.displayName =
              "${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}";
          updateUser.photoUrl =
              "define a photo url here"; 
          await val.updateProfile(updateUser);
          
        });
         return _res;
        
              
        
        } catch (e) {
          print("error");
        }
        
        break;
      case AuthorizationStatus.error:
        print('User auth error');
        break;
      case AuthorizationStatus.cancelled:
        print('User cancelled');
        break;
    }
   
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