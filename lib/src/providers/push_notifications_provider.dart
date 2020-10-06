import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class PushNotificationProvider {

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  final mensajeStreamController = StreamController<String>.broadcast();

  Stream<String> get mensajesStram => mensajeStreamController.stream;





  static Future<dynamic> onBackgroundMessage(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
  }

  initNotifications() async {

    await firebaseMessaging.requestNotificationPermissions();
    final token = await firebaseMessaging.getToken();
    print('==FCM Toke =====');
    print(token);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tokenDispositivo',token );


    firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume,
    );

  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
  
    print('onmessage');
    print('message $message');
    final notificacionTitulo = message['notification'] ['title'];
    final notificacionBody = message['notification'] ['body'];
    String mensaje = '$notificacionTitulo $notificacionBody';
    mensajeStreamController.sink.add(mensaje);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
  
    print('onLaunch');
    print('message $message');
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
  
    print('onResume');
    print('message $message');
  }

  dispose() {
    mensajeStreamController?.close();
  }

}