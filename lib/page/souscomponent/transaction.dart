import 'package:flutter/material.dart';




Widget myTransactionWidget(context,envoiqrcode){
  return SingleChildScrollView(
    child: Container(
     // margin: EdgeInsets.only(top: 15,left: 20,right: 5),
      child: Column(children: [
         Container(
           padding: EdgeInsets.zero,
           child: ListTile(
           title:Row(children: [
           const  Icon(Icons.arrow_circle_right,color: Color.fromRGBO(75, 0, 130, 1),),
            TextButton(onPressed: (){ Navigator.of(context).pushNamed('/envoidirect');}      ,
             style: ButtonStyle(
             foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
             overlayColor:  MaterialStateProperty.all<Color>(Colors.black),
               ),child: const Text('Envoi direct'), ),
             ],)
             
           ),
         ),
   Container(decoration:
   const   BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromRGBO(75, 0, 130, 1)))),),
   const  SizedBox(height: 15,),
    Container(
     margin:const EdgeInsets.only(left: 5),
     child:ListTile(
     title: Row(children: [
     const  Icon(Icons.circle , color: Colors.orange,),
      TextButton(onPressed: (){Navigator.of(context).pushNamed('/envoicode');},
      style: ButtonStyle(
       foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      overlayColor:  MaterialStateProperty.all<Color>(Colors.black),
      ),child: const Text('Envoi via code'),),
       ]),
     )
      
   ),
    Container(decoration:
    const  BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey,width: 1))),),
      Container(
        margin:const  EdgeInsets.only(top: 15),
        child: Column(
        children: [
        const ListTile
        (title:Text("Qr_code envoi")),
       const   SizedBox(height: 5.0), 
         SizedBox(
         height: 50.0,
         width: 150.0,
         child:  IconButton(
        color:const   Color.fromRGBO(75, 0, 130, 1),
         padding: const  EdgeInsets.all(0.0),
        icon: const 
         Icon(Icons.qr_code ,size: 50.0),
       onPressed:(){
         envoiqrcode(context);
       } ,)
  ),],),),
  Container(decoration:
    const  BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey,width: 1))),),
 const SizedBox(height: 15,),
  Container(
    padding: EdgeInsets.zero,
    child: ListTile(
    title:Row(children: [
    const  Icon(Icons.wallet,color: Colors.brown,size: 30,),
    TextButton(onPressed: (){ Navigator.of(context).pushNamed('/gaalguimoneypay');},
   style: ButtonStyle(
  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
  overlayColor:  MaterialStateProperty.all<Color>(Colors.black),
   ),child: const Text('GaalguiMoneyPay',style: TextStyle(
    fontSize: 16,fontWeight: FontWeight.bold
   ),), ),
   ],)
   ),
    ),
 ]),),
  );
}

