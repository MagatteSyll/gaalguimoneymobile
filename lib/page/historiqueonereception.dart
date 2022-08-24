import 'package:flutter/material.dart';
import 'package:gaalguimoney/page/souscomponent/animationload.dart';
import './TransClass.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;


class HistoriqueOneReception extends StatefulWidget {
  final dynamic id;
   HistoriqueOneReception(@required this.id);

  @override
  State<HistoriqueOneReception> createState() => _HistoriqueOneReceptionState();
}

class _HistoriqueOneReceptionState extends State<HistoriqueOneReception> {
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
    trans.montant=res['montant'],
    trans.message=res['message'],
    trans.nature=res['nature_transaction'],
    trans.date=res['created'],
    trans.code=res['code'],
    trans.donnateur=res['donnateur'],
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
         SizedBox(width:10,),
        Text(trans.nature,style: TextStyle(fontWeight: FontWeight.bold,fontSize:16))
      ]),
    ),
    SizedBox(height:10,),
     Container(
      margin: EdgeInsets.only(left: 5),
      child: Row(children: [
        Text(" date de la reception",style: TextStyle(fontSize:16)),
        SizedBox(width:10,),
        Text(TimeConvert.getime(trans.date)+" ,"+" "+ TimeConvert.getheure(trans.date),
        style: TextStyle(fontWeight: FontWeight.bold,fontSize:16)
        ),
      ]),
    ),
    SizedBox(height:10,),
     Container(
      margin: EdgeInsets.only(left: 5),
      child: Row(children: [
        Text("Montant recu ",style: TextStyle(fontSize:16)),
        SizedBox(width:10,),
        Text(trans.montant +" "+ "CFA",style: TextStyle(fontWeight: FontWeight.bold,fontSize:16))
      ]),
    ),
    SizedBox(height:10,),
    Container(
      margin: EdgeInsets.only(left: 5),
      child: Row(children: [
        Text("De",style: TextStyle(fontSize:16)),
         SizedBox(width:10,),
        Text(trans.donnateur ,style: TextStyle(fontWeight: FontWeight.bold,fontSize:16))
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