import 'package:flutter/material.dart';
import 'package:gaalguimoney/page/souscomponent/animationload.dart';
import './TransClass.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;


class HistoriqueOneCode extends StatefulWidget {
  final dynamic id;
   HistoriqueOneCode(@required this.id);

  @override
  State<HistoriqueOneCode> createState() => _HistoriqueOneCodeState();
}

class _HistoriqueOneCodeState extends State<HistoriqueOneCode> {
   var httpIns=HttpInstance();
   bool load=false;
  var trans=new MyTransaction();

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
 void initState(){
   getrecu().then((res) => 
    setState(()=>{
    trans.beneficiaire=res['beneficiaire'],
    trans.montant=res['montant'],
    trans.message=res['message'],
    trans.commission=res['commission'],
    trans.nature=res['nature_transaction'],
    trans.date=res['created'],
    trans.total=res['total'],
    trans.code=res['code'],
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
      backgroundColor: Color.fromRGBO(34, 139, 34, 1.0),
      title:ListTileTitle(trans.nature, trans.montant,context)
       ) ,
    body: Container(
    margin: EdgeInsets.only(top: 30),
     child: Column(children: [
      
      Center(
        child: Text(
        'Transaction GaalguiMoney',
        style: TextStyle(fontWeight: FontWeight.bold,)
        ),
      ),
    SizedBox(height:15,),
    Container(
      margin: EdgeInsets.only(left: 5),
      child: Row(children: [
        Text("Nature de la transaction ",style: TextStyle(fontSize:16)),
        Text(trans.nature,style: TextStyle(fontWeight: FontWeight.bold,fontSize:16))
      ]),
    ),
    SizedBox(height:10,),
     Container(
      margin: EdgeInsets.only(left: 5),
      child: Row(children: [
        Text("Effectue le  ",style: TextStyle(fontSize:16)),
        Text(TimeConvert.getime(trans.date)+" ,"+" "+ TimeConvert.getheure(trans.date),style: TextStyle(fontWeight: FontWeight.bold,fontSize:16))
      ]),
    ),
    SizedBox(height:10,),
    Container(
      margin: EdgeInsets.only(left: 5),
      child: Row(children: [
        Text("code de la transaction",style: TextStyle(fontSize:16)),
        SizedBox(width: 10,),
        Text(trans.code.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize:16))
      ]),
    ),
    SizedBox(height:10,),
     Container(
      margin: EdgeInsets.only(left: 5),
      child: Row(children: [
        Text("Montant envoye ",style: TextStyle(fontSize:16)),
        Text(trans.montant +" "+ "CFA",style: TextStyle(fontWeight: FontWeight.bold,fontSize:16))
      ]),
    ),
    SizedBox(height:10,),
   Container(
      margin: EdgeInsets.only(left: 5),
      child: Row(children: [
        Text("Commission ",style: TextStyle(fontSize:16)),
        SizedBox(width: 10,),
        Text(trans.commission+" "+ "CFA",style: TextStyle(fontWeight: FontWeight.bold,fontSize:16))
      ]),
    ),
    SizedBox(height:10,),
    Container(
      margin: EdgeInsets.only(left: 5),
      child: Row(children: [
        Text("Total",style: TextStyle(fontSize:16)),
        SizedBox(width: 10,),
        Text(trans.total +" "+ "CFA",style: TextStyle(fontWeight: FontWeight.bold,fontSize:16))
      ]),
    ),
    SizedBox(height:10,),
    Container(
      margin: EdgeInsets.only(left: 5),
      child: Row(children: [
        Text("Beneficiare ",style: TextStyle(fontSize:16)),
        SizedBox(width: 10,),
        Text(trans.beneficiaire,style: TextStyle(fontWeight: FontWeight.bold,fontSize:16))
      ]),
    ),
    SizedBox(height:100,),
    
    Container(
      margin: EdgeInsets.only(left: 100),
      child: Card(child: Text('signature')),
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