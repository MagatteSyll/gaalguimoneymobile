import 'package:flutter/material.dart';
import './page/accueil.dart';
import './route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 // const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Accueil(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  
  }
}