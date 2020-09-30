import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'dart:async';


class EnviarNotificaciones {

  final String serverToken = 'AAAA2zIxGy0:APA91bHQjrJfsG_yBAyJfW8Myd3ISHB9bnu7bCeWyxrHwrdvx4EVmwgdt4o_U3FrsBKgTUJ0BAWIOW9TQaaFqVsPjOOWSvp-StxIBo7AcZmpMuVYOEn9R7o050AFZC_w89SciRV9tvkx';
final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

Future<Map<String, dynamic>> sendAndRetrieveMessage(tokenDispositivo,titulo,mensaje) async {
  await firebaseMessaging.requestNotificationPermissions(
    const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
  );

  await http.post(
    'https://fcm.googleapis.com/fcm/send',
     headers: <String, String>{
       'Content-Type': 'application/json',
       'Authorization': 'key=$serverToken',
     },
     body: jsonEncode(
     <String, dynamic>{
       'notification': <String, dynamic>{
         'body': mensaje,
         'title': titulo
       },
       'priority': 'high',
       'data': <String, dynamic>{
         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
         'id': '1',
         'status': 'done'
       },
       'to': tokenDispositivo,
     },
    ),
  );

  final Completer<Map<String, dynamic>> completer =
     Completer<Map<String, dynamic>>();

  firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      completer.complete(message);
    },
  );

  return completer.future;
}


}