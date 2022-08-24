import 'package:flutter/material.dart';




class Parametre extends StatelessWidget {
  //const Parametre({ Key? key }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
      Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.zero,
      child: ListTile(
      title:Row(children: [
      Text('Authentification',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
       Icon(Icons.arrow_circle_right,color: Colors.blue,size: 36,),
         ],), 
        onTap:(){
         Navigator.of(context).pushNamed('/authentification');
        }, 
         ),
         ),
      Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.zero,
      child: ListTile(
      title:Row(children: [
       Text('Protection compte',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
       Icon(Icons.private_connectivity,color: Colors.blue,size: 36,),
         ],),
      onTap:  (){ Navigator.of(context).pushNamed('/protection');},
         ),
         ),
      Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.zero,
      child: ListTile(
      title:Row(children: [
      Text('Application',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
      Icon(Icons.settings_applications,color: Colors.blue,size: 36,),
         ],),
         onTap: (){ Navigator.of(context).pushNamed('/application');},),
         ),
    ]), );
  }
}