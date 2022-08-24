import 'package:flutter/material.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;
import 'package:gaalguimoney/page/souscomponent/animationload.dart';

class ConfirmationCode extends StatefulWidget {
  //const ConfirmationCode({ Key? key }) : super(key: key);
  final dynamic id;
  ConfirmationCode(@required this.id);

  @override
  State<ConfirmationCode> createState() => _ConfirmationCodeState();

}

class _ConfirmationCodeState extends State<ConfirmationCode> {
  var httpIns=HttpInstance();
   late var nature;
   late var beneficiare;
   late var telbeneficiare;
   late var commission;
   late var montant;
   late var total;
   late var date;
   bool load=false;
   Future getransaction()async{
  var id=convert.jsonEncode(widget.id);
   var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/getransactioncode/',);
   var response=await  httpIns.post(url,body: {'id':id});
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    //Navigator.of(context).pushNamed("/confirmationenvoi",arguments:jsonResponse['id']);
    return jsonResponse;
  }
  else {
   print(response.body);
 }
  }

Future confirmation() async{
  var id=convert.jsonEncode(widget.id);
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/envoyercode/envoyerviacodedirectement/',);
  var response=await  httpIns.put(url,body: {'id':id});
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
   // print(response.body);
    Navigator.of(context).pushNamed("/recucode",arguments:jsonResponse['id']);
    return jsonResponse;
  }
  else {
   print(response.body);
 }
}
  @override
  void initState() {
    getransaction().then((res) => {
      setState(()=>{
        beneficiare=res['nom_complet_destinataire'],
        montant=res['somme'],
        telbeneficiare=res['phone_destinataire'],
        commission=res['commission'],
        nature=res['nature_transaction'],
        total=res['total'],
        load=true
      })
    });
   
    super.initState();
  }
  Future annulation(context) async{
  var id=convert.jsonEncode(widget.id);
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/envoyerdirect/annulationenvoi/',);
   var response=await  httpIns.put(url,body: {'id':id});
  if (response.statusCode == 200) {
    Navigator.of(context).pop();
  }
  else {
   print(response.body);
 }

}
  @override
  Widget build(BuildContext context) {
     if(load){
   return  Scaffold(
       appBar: AppBar(
       title: Text("Confirmation de l envoi "), 
       backgroundColor: Colors.green,
       leading: IconButton(onPressed: (){
        annulation(context);
       }, icon:Icon(Icons.arrow_back_ios_new)),
      ),
      body:SingleChildScrollView(child: Container(
      padding: EdgeInsets.all(5),
      margin:EdgeInsets.only(top:20,right: 5,left:5) ,
      child:Column(children: [
      ListTile(
        title: Text('logo'),
      ),
      SizedBox(height: 20,),
      Center(
        child: Row(children: [
          Text('Beneficiaire',style: const TextStyle(fontSize: 18)),
          SizedBox(width: 10,),
          Text(beneficiare,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
        ]),
      ),
    SizedBox(height: 15,),
      Center(
        child: Row(children: [
          Text('Tel du beneficiaire',style: const TextStyle(fontSize: 18)),
          SizedBox(width: 10,),
          Text(telbeneficiare,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
        ]),
      ),
     SizedBox(height: 15,),
      Center(
        child: Row(children: [
          Text('Montant a envoyer',style: const TextStyle(fontSize: 18)),
          SizedBox(width: 10,),
          Text(montant + " "+ 'CFA',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
        ]),
      ),
     SizedBox(height: 15,),
      Center(
        child: Row(children: [
          Text('Commission',style: const TextStyle(fontSize: 18)),
          SizedBox(width: 10,),
          Text(commission+ " "+ 'CFA',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
        ]),
      ),
     SizedBox(height: 15,),
      Center(
        child: Row(children: [
          Text('Total de la transaction',style: const TextStyle(fontSize: 18)),
          SizedBox(width: 10,),
          Text(total+ " "+ 'CFA' ,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
        ]),
      ),
      SizedBox(height: 15,),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
           backgroundColor: MaterialStateProperty.all(Colors.green),
           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
           RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(100.0), ))),
          child: Text('Confirmer'),
        onPressed: confirmation,),
      )
    
      ]) ,
      ),)
     );
  }
  else{
    return EnvoiAnimate();

  }
}
}