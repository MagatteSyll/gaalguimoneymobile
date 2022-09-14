import 'package:flutter/material.dart';
import './page/accueil.dart';
import './route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import './notificationservice.dart';



Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.data}');
   LocalNotificationService().showNotification(
      body: message.data['body'],
      title: message.data['titre'], 
      id: 5,
      payload: "payload"
      );
}


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 FirebaseMessaging messaging = FirebaseMessaging.instance;
 
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('autoriser');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
   print('User granted provisional permission');
  } else {
  print('User declined or has not accepted permission');
  }
  
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        Navigator.pushNamed(
          context,
          '/notification',
         );}});
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.data);
     LocalNotificationService().showNotification(
      body: message.data['body'],
      title: message.data['titre'], 
      id: 5,
      payload: "payload"
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message.data);
      Navigator.pushNamed(
        context,
        '/notification',
      );
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Accueil(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  
  }
}