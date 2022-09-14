import 'package:flutter/material.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;
import 'package:gaalguimoney/page/souscomponent/animationload.dart';

class ConfirmationCode extends StatefulWidget {
  const ConfirmationCode(this.id,{ Key? key }) : super(key: key);
  final dynamic id;
  

  @override
  State<ConfirmationCode> createState() => _ConfirmationCodeState();

}

class _ConfirmationCodeState extends State<ConfirmationCode> {
  var httpIns=HttpInstance();
   late var data;
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
    return;
 }
  }

Future confirmation(context) async{
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
   return;
 }
}
  @override
  void initState() {
    getransaction().then((res) => {
      setState(()=>{
        data=res,
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
   return;
 }

}
  @override
  Widget build(BuildContext context) {
     if(load){
   return  Scaffold(
       appBar: AppBar(
       title:const Text("Confirmation de l envoi "), 
       backgroundColor:const  Color.fromRGBO(75, 0, 130, 1),
       leading: IconButton(onPressed: (){
        annulation(context);
       }, icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body:SingleChildScrollView(child: Container(
      padding:const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top:20,right: 5,left:5) ,
      child:Column(children: [
      ListTile(
        leading:Image.asset('assets/logo.jpg',scale:0.1,
        height: 50,
        width: 70,)
      ),
     const SizedBox(height: 20,),
      Center(
        child: Row(children: [
        const  Text('Beneficiaire',style: TextStyle(fontSize: 18)),
        const  SizedBox(width: 10,),
          Text(data['nom_complet_destinataire'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
        ]),
      ),
   const SizedBox(height: 15,),
      Center(
        child: Row(children: [
         const Text('Tel du beneficiaire',style:  TextStyle(fontSize: 18)),
        const  SizedBox(width: 10,),
          Text(data['phone_destinataire'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
        ]),
      ),
    const SizedBox(height: 15,),
      Center(
        child: Row(children: [
        const  Text('Montant a envoyer',style:  TextStyle(fontSize: 18)),
        const  SizedBox(width: 10,),
          Text(data['somme'] + " "+ 'CFA',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
        ]),
      ),
   const  SizedBox(height: 15,),
      Center(
        child: Row(children: [
        const  Text('Commission',style:  TextStyle(fontSize: 18)),
        const  SizedBox(width: 10,),
          Text(data['commission']+ " "+ 'CFA',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
        ]),
      ),
    const SizedBox(height: 15,),
      Center(
        child: Row(children: [
        const  Text('Total de la transaction',style:  TextStyle(fontSize: 18)),
        const  SizedBox(width: 10,),
          Text(data['total']+ " "+ 'CFA' ,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
        ]),
      ),
     const SizedBox(height: 15,),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
           backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(75, 0, 130, 1)),
           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
           RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(100.0), ))),
        onPressed:(){
          confirmation(context);
        } ,
          child: const Text('Confirmer'),),
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