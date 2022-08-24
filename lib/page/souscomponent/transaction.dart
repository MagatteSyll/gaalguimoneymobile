import 'package:flutter/material.dart';
import 'package:gaalguimoney/page/payementqrcode.dart';
import 'dart:convert' as convert;
import '../../../apiservice.dart';



Widget MyTransactionWidget(context,payementcodebusiness){
  return SingleChildScrollView(
    child: Container(
     // margin: EdgeInsets.only(top: 15,left: 20,right: 5),
      child: Column(children: [
         Container(
           padding: EdgeInsets.zero,
           child: ListTile(
             title:Row(children: [
            Icon(Icons.arrow_circle_right,color: Colors.blue,),
            TextButton(onPressed: (){ Navigator.of(context).pushNamed('/envoidirect');}
                   ,child: Text('Envoi direct'),
             style: ButtonStyle(
             foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
             overlayColor:  MaterialStateProperty.all<Color>(Colors.black),
               ), ),
             ],)
             
           ),
         ),
   Container(decoration:
     BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey,width: 1))),),
    SizedBox(height: 15,),
    Container(
     margin: EdgeInsets.only(left: 5),
     child:ListTile(
       title: Row(children: [
      Icon(Icons.circle , color: Colors.blue,),
      TextButton(onPressed: (){Navigator.of(context).pushNamed('/envoicode');}
       ,child: Text('Envoi via code'),
        style: ButtonStyle(
       foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      overlayColor:  MaterialStateProperty.all<Color>(Colors.black),
      ),),
       ]),
     )
      
   ),
    Container(decoration:
     BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey,width: 1))),),
      Container(
        margin: EdgeInsets.only(top: 15),
        child: Column(
        children: [
        ListTile
        (title: Text("Payement GaalguiBusiness avec qr-code")),
         SizedBox(height: 5.0), 
         SizedBox(
         height: 50.0,
         width: 150.0,
         child:  IconButton(
        color: Color.fromARGB(225, 255, 196, 0),
         padding:  EdgeInsets.all(0.0),
        icon:  Icon(Icons.qr_code ,size: 30.0),
       onPressed:(){
         payementcodebusiness();
       } ,)
  ),],),),
  Container(decoration:
     BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey,width: 1))),),
     Container(
        margin: EdgeInsets.only(top: 15),
        child: Column(
        children: [
        ListTile
        (title: Text("GaalguiMoneyPay avec qr-code")),
         SizedBox(height: 5.0), 
         SizedBox(
         height: 50.0,
         width: 150.0,
         child:  IconButton(
        color: Color.fromARGB(224, 196, 0, 42),
         padding:  EdgeInsets.all(0.0),
        icon:  Icon(Icons.qr_code ,size: 30.0),
       onPressed:(){} ,)
  ),],),),
  SizedBox(height: 15,),
  Container(decoration:
  BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey,width: 1))),),
  Container(
    padding: EdgeInsets.zero,
    child: ListTile(
    title:Row(children: [
     Icon(Icons.payment,color: Colors.blue,),
     TextButton(onPressed: (){ Navigator.of(context).pushNamed('/gaalguimoneypay');}
   ,child: Text('GaalguiMoneyPay'),
   style: ButtonStyle(
  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
  overlayColor:  MaterialStateProperty.all<Color>(Colors.black),
   ), ),
   ],)
   ),
    ),
  
 ]),),
  );
}

Widget Pay(pay){
  if(pay.length>0){
  return Container(
       child: ListView.builder(
         physics: NeverScrollableScrollPhysics(),
         scrollDirection: Axis.horizontal,
         itemCount: pay.length,
         itemBuilder: (context, index) {
          final item = pay[index];
          return Card(
            child: Column(
              children: [
             ListTile(
             title: Text("GaalguiPay", style: TextStyle(fontSize: 16,
              fontWeight: FontWeight.bold)),),
              SizedBox(height: 5,),
              Container(
              child: Column(children: [
              Text(item['alias'], style: TextStyle(color: Color.fromARGB(254,
              90,80, 0),fontWeight: FontWeight.bold)),
              Image.network('https://gaalguimoney.herokuapp.com${item['logo']}',width: 30,
              height: 30,),
              ]),),
              ],
            ),);
         }),
      ); }
    else{
   return Container();
    }
 
    

 
}
