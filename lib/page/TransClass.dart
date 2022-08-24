import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class MyTransaction {
  late var  nature;
  var message;
  var montant;
  var commission;
  var beneficiaire;
  var code;
  var date;
  var total;
  var donnateur;

}
class TimeConvert{
 static getime(date){
    final  formattedDate =DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(formattedDate);
    return formatted;
  }
static getheure(date){
    final  formattedDate =DateTime.parse(date);
    final heure=DateFormat('HH:mm');
     String heuresting=heure.format(formattedDate);
     return heuresting;
}

}

Widget ListTileTitle(nature,somme,context){
  return ListTile(
   // leading: Icon(Icons.check,size: 30,color: Colors.white),
    title: Container(
    // height: MediaQuery.of(context).size.width * 0.10,
      child:Column(children: [
      Row(
        children: [
       Icon(Icons.check,color: Colors.white,),
       
    Text(nature,
    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        ],
      ),
    Center(
      child: Text(somme +" "+ "CFA",
      style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white),
    
      ),
    )
    ],)
     ),

  );
}
