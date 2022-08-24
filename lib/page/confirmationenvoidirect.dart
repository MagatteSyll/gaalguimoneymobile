import 'package:flutter/material.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;
import 'package:gaalguimoney/page/souscomponent/animationload.dart';

class ConfirmationDirect extends StatefulWidget {
 // const ConfirmationDirect({ Key? key }) : super(key: key);
 final dynamic id;
 ConfirmationDirect(@required this.id);
  @override
  State<ConfirmationDirect> createState() => _ConfirmationDirectState();
}

class _ConfirmationDirectState extends State<ConfirmationDirect> {
  var httpIns=HttpInstance();
   late var  prenom;
   late var nom;
   late var somme;
   late var phone;
   late var commission;
   late var total;
   bool load=false;


  Future getransaction()async{
  var id=convert.jsonEncode(widget.id);
   var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/getransaction/',);
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
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/envoyerdirect/envoyerdirectement/',);
   var response=await  httpIns.put(url,body: {'id':id});
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    Navigator.of(context).pushNamed("/recudirect",arguments:jsonResponse['id']);
    return jsonResponse;
  }
  else {
  return;
 }
}
Future annulation(context) async{
  var id=convert.jsonEncode(widget.id);
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/envoyerdirect/annulationenvoi/',);
   var response=await  httpIns.put(url,body: {'id':id});
  if (response.statusCode == 200) {
    Navigator.of(context).pop();
  }
  else {
  return;
 }

}

  @override
  void initState() {
    getransaction().then((res) => {
      setState(()=>{
        prenom=res['receveur']['prenom'],
        nom=res['receveur']['nom'],
        somme=res['transaction']['somme'],
        phone=res['receveur']['phone'],
        commission=res['transaction']['commission'],
        total=res['transaction']['total'],
        load=true
      })
    });
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(load){
   return   Scaffold(
     appBar: AppBar(
       title: Text("Confirmation de l envoi"), 
       backgroundColor: Colors.green,
       leading: IconButton(onPressed: (){
        annulation(context);
       }, icon:Icon(Icons.arrow_back_ios_new)),
      ),
      body:SingleChildScrollView(child: Container(
      margin:EdgeInsets.only(top: 20,right: 10,left:10) ,
      child:Column(children: [
        ListTile(
          title: Text('logo'),
        ),
        SizedBox(height: 15,),
        Center(child: Text("Informations ",
        style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
        ),
        SizedBox(height: 15,),
      Center(
        child: Row(children: [
          Text('Beneficiaire',style: const TextStyle(fontSize: 18)),
          SizedBox(width: 10,),
          Text(prenom +" "+  nom,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
        ]),
      ),
    SizedBox(height: 15,),
      Center(
        child: Row(children: [
          Text('Tel du beneficiaire',style: const TextStyle(fontSize: 18)),
          SizedBox(width: 10,),
          Text(phone,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
        ]),
      ),
     SizedBox(height: 15,),
      Center(
        child: Row(children: [
          Text('Montant a envoyer',style: const TextStyle(fontSize: 18)),
          SizedBox(width: 10,),
          Text(somme,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
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
           borderRadius: BorderRadius.circular(100.0),
           // side: BorderSide(color: Colors.red)
     )
  )
),
          child: 
        Text('Confirmer'),
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