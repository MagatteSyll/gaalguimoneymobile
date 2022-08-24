import 'package:flutter/material.dart';
import 'package:gaalguimoney/page/souscomponent/animationload.dart';
import './TransClass.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;


class HistoriqueOnePayement extends StatefulWidget {
  final dynamic id;
 HistoriqueOnePayement(@required this.id);

  @override
  State<HistoriqueOnePayement> createState() => _HistoriqueOnePayementState();
}

class _HistoriqueOnePayementState extends State<HistoriqueOnePayement> {
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
   print(response.body);
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
        child:Row(children: [
         Text(
        'Transaction GaalguiMoneyPay',
        style: TextStyle(fontWeight: FontWeight.bold,)
        ),
        Text('logo entreprise')
        ],) 
      ),
    SizedBox(height:15,),
     Container(
      margin: EdgeInsets.only(left: 5),
      child: Row(children: [
        Text("Effectue le  ",style: TextStyle(fontSize:16)),
        SizedBox(width:10,),
        Text(TimeConvert.getime(trans.date)+" ,"+" "+ TimeConvert.getheure(trans.date)
        ,style: TextStyle(fontWeight: FontWeight.bold,fontSize:16))
      ]),
    ),
    SizedBox(height:10,),
     Container(
      margin: EdgeInsets.only(left: 5),
      child: Row(children: [
        Text("Montant ",style: TextStyle(fontSize:16)),
         SizedBox(width:10,),
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
         SizedBox(width:10,),
        Text(trans.total +" "+ "CFA",style: TextStyle(fontWeight: FontWeight.bold,fontSize:16))
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