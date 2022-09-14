import 'package:flutter/material.dart';
import 'package:gaalguimoney/page/souscomponent/animationload.dart';
import './TransClass.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;


class HistoriqueOnePayement extends StatefulWidget {
  final dynamic id;
 const HistoriqueOnePayement(this.id,{ Key? key }) : super(key: key);

  @override
  State<HistoriqueOnePayement> createState() => _HistoriqueOnePayementState();
}

class _HistoriqueOnePayementState extends State<HistoriqueOnePayement> {
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
   backgroundColor: const Color.fromRGBO(34, 139, 34, 1.0),
  title:listTileTitle(trans['nature_transaction'], trans['montant'],context)
       ) ,
    body: Container(
    margin: const EdgeInsets.only(top: 30),
     child: Column(children: [
      Center(
        child:Row(children: const [
        Text(
        'Transaction GaalguiMoneyPay',
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
        ),
       Text('logo entreprise')
        ],) 
      ),
    const SizedBox(height:15,),
     Container(
      margin: const EdgeInsets.only(left: 5),
      child: Row(children: [
        const Text("Effectué le  ",style: TextStyle(fontSize:18)),
        const SizedBox(width:10,),
        Text(TimeConvert.getime(trans.date)+" ,"+" "+ TimeConvert.getheure(trans.date)
        ,style: const TextStyle(fontWeight: FontWeight.bold,fontSize:16))
      ]),
    ),
    const SizedBox(height:10,),
     Container(
      margin: const EdgeInsets.only(left: 5),
      child: Row(children: [
        const Text("Montant ",style: TextStyle(fontSize:18)),
         const SizedBox(width:10,),
        Text(trans['montant'] +" "+ "CFA",style: const TextStyle(fontWeight: FontWeight.bold,fontSize:18))
      ]),
    ),
    const SizedBox(height:10,),
   Container(
      margin: const EdgeInsets.only(left: 5),
      child: Row(children: [
        const Text("Commission ",style: TextStyle(fontSize:16)),
        const SizedBox(width: 10,),
        Text(trans['commission']+" "+ "CFA",style: const TextStyle(fontWeight: FontWeight.bold,fontSize:16))
      ]),
    ),
    const SizedBox(height:10,),
    Container(
      margin: const EdgeInsets.only(left: 5),
      child: Row(children: [
        const Text("Total",style: TextStyle(fontSize:16)),
         const SizedBox(width:10,),
        Text(trans['total'] +" "+ "CFA",style: const TextStyle(fontWeight: FontWeight.bold,fontSize:16))
      ]),
    ),
    const SizedBox(height:100,),
    Container(
      margin: const EdgeInsets.only(left: 100),
      child: const Card(child: Text('signature')),
    )
     ]),
    ),
  );
   }
   else{
     return HistoriqueAnimate();
   }
  }
}