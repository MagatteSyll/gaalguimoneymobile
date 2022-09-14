import 'package:flutter/material.dart';
import 'package:gaalguimoney/page/souscomponent/animationload.dart';
import './TransClass.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;




class HistoriqueOneDirect extends StatefulWidget {
  final dynamic id;
 const  HistoriqueOneDirect(this.id,{ Key? key }) : super(key: key);

  @override
  State<HistoriqueOneDirect> createState() => _HistoriqueOneDirectState();
}

class _HistoriqueOneDirectState extends State<HistoriqueOneDirect> {
   var httpIns=HttpInstance();
   bool load=false;
  // ignore: prefer_typing_uninitialized_variables
  var trans;

 Future getrecu() async{
    var id=convert.jsonEncode(widget.id);
    var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/messagespecifique/',);
    var response=await  httpIns.post(url,body: {'id':id});
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
   // print(jsonResponse);
    return jsonResponse;
  }
  else {
   return;
 }}

 @override
 void initState(){
   getrecu().then((res) => 
    setState(()=>{
    trans=res,
    load=true
    })
    );
   super.initState();
 }


  @override
  Widget build(BuildContext context) {

    if(load){
      return Scaffold(
    appBar:AppBar(
     elevation: 0.1,
      backgroundColor:const Color.fromRGBO(34, 139, 34, 1.0),
      title:listTileTitle(trans['nature_transaction'], trans['montant'],context)
       ) ,
      body:Container(
    margin: const EdgeInsets.only(top: 30,),
     child: Column(children: [
     const Center(
        child: Text(
        'Transaction GaalguiMoney',
        style: TextStyle(fontWeight: FontWeight.bold,
        fontSize: 20)
        ),
      ),
   const  SizedBox(height:15,),
    Container(
      margin:const EdgeInsets.only(left: 5),
      child: Row(children: [
       const Text("Nature de la transaction ",style: TextStyle(fontSize:18)),
       Text(trans['nature_transaction'],style:const TextStyle(fontWeight: FontWeight.bold,fontSize:18))
      ]),
    ),
  const  SizedBox(height:10,),
     Container(
      margin:const EdgeInsets.only(left: 5),
      child: Row(children: [
       const Text("Effectué le  ",style: TextStyle(fontSize:18)),
        Text(TimeConvert.getime(trans['created'])+" ,"+" "+ TimeConvert.getheure(trans['created']),style: const TextStyle(fontWeight: FontWeight.bold,fontSize:18))
      ]),
    ),
    
   
   const SizedBox(height:10,),
     Container(
      margin: const EdgeInsets.only(left: 5),
      child: Row(children: [
      const  Text("Montant envoyé",style: TextStyle(fontSize:18)),
      const  SizedBox(width: 10,),
      Text(trans['montant'] +" "+ "CFA",style: const TextStyle(fontWeight: FontWeight.bold,fontSize:18))
      ]),
    ),
    
  const SizedBox(height:10,),
   Container(
      margin:const EdgeInsets.only(left: 5),
      child: Row(children: [
      const  Text("Commission ",style: TextStyle(fontSize:18)),
      const  SizedBox(width: 10,),
        Text(trans['commission']+" "+ "CFA",style:const TextStyle(fontWeight: FontWeight.bold,fontSize:18))
      ]),
    ),
    
  const  SizedBox(height:10,),
    Container(
      margin: const EdgeInsets.only(left: 5),
      child: Row(children: [
      const  Text("Total ",style: TextStyle(fontSize:18)),
      const  SizedBox(width:10,),
        Text(trans['total'] +" "+ "CFA",style: const TextStyle(fontWeight: FontWeight.bold,fontSize:18))
      ]),
    ),
    
   const SizedBox(height:10,),
    Container(
      margin:const EdgeInsets.only(left: 5),
      child: Row(children: [
       const Text("Beneficiare ",style: TextStyle(fontSize:18)),
       const SizedBox(width: 10,),
        Text(trans['beneficiaire'],style:const TextStyle(fontWeight: FontWeight.bold,fontSize:18))
      ]),
    ),
  const  SizedBox(height:100,),
    Container(
      margin:const EdgeInsets.only(left: 100),
      child:const Card(child: Text('signature')),
    ) ]),
    ) ,
   
  );
      }
    
  else{
   return HistoriqueAnimate();
  }
    
   
  
}
}
