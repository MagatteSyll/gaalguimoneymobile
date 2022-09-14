import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




class Parametre extends StatelessWidget {
  const Parametre({super.key});

  //const Parametre({ Key? key }) : super(key: key);
  static const platform =  MethodChannel("flutter.native.com/auth");


  Future deconnexion(context) async{
  //var  verif=await platform.invokeMethod('getphone');
   //print(verif);
  await platform.invokeMethod("deconnexion");
 //print(decon);
 Navigator.of(context).pushNamedAndRemoveUntil('/connexion', (Route route) => false); 
  }
 
 
  @override
  Widget build(BuildContext context) {
    return  Column(children: [
      Container(
      margin:const EdgeInsets.only(top: 15),
      padding: EdgeInsets.zero,
      child: ListTile(
      title:Row(children: const [
       Text('Authentification',style:TextStyle(fontWeight: FontWeight.bold,
        fontSize: 24,color: Colors.black),),
      SizedBox(width: 5,),
     Icon(Icons.arrow_circle_right,color: Color.fromRGBO(75, 0, 130, 1),size: 36,),
         ],), 
        onTap:(){
         Navigator.of(context).pushNamed('/authentification');
        }, 
         ),
         ),
      Container(
      margin:const EdgeInsets.only(top: 15),
      padding: EdgeInsets.zero,
      child: ListTile(
      title:Row(children: const[
      Text('Protection compte',style:TextStyle(fontWeight: FontWeight.bold,
      fontSize: 24,color: Colors.black),),
       SizedBox(width: 5,),
      Icon(Icons.private_connectivity,color: Color.fromRGBO(75, 0, 130, 1),size: 36,),
         ],),
      onTap:  (){ Navigator.of(context).pushNamed('/protection');},
         ),
         ),
      Container(
      margin:const  EdgeInsets.only(top: 15),
      padding: EdgeInsets.zero,
      child: ListTile(
      title:Row(children:const  [
      Text('Application',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
       SizedBox(width: 5,),
      Icon(Icons.settings_applications,color: Color.fromRGBO(75, 0, 130, 1)),
         ],),
         onTap: (){ Navigator.of(context).pushNamed('/application');},),
         ),
      Container(
      margin:const  EdgeInsets.only(top: 15),
      padding: EdgeInsets.zero,
      child: ListTile(
      title:Row(children:const  [
      Text('Deconnexion',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
       SizedBox(width: 5,),
      Icon(Icons.back_hand,color: Color.fromRGBO(75, 0, 130, 1)),
         ],),
      onTap: (){ deconnexion(context);},),
         ),
    ], );
  }
}