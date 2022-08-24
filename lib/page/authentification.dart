import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class Authentification extends StatefulWidget {
  const Authentification({Key? key}) : super(key: key);

  @override
  State<Authentification> createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
   static const platform =  MethodChannel("flutter.native.com/auth");

   deconnexion(context) async{
   var decon= await platform.invokeMethod("deconnexion");
   print(decon);
    Navigator.of(context).pushNamed("/connexion");
    
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(child: Text("deconnexion"),
      onPressed: (){
        deconnexion(context);
      },
      
      ),

    );
    
  }
}