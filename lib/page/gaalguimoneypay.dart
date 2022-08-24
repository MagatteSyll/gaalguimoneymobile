import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import '../apiservice.dart';




class GaalguiPay extends StatefulWidget {
  const GaalguiPay({Key? key}) : super(key: key);

  @override
  State<GaalguiPay> createState() => _GaalguiPayState();
}

class _GaalguiPayState extends State<GaalguiPay> {
   List<Map<String, dynamic>> pay=[];
   var httpIns=HttpInstance();
   bool payload=false;

  Future getpay() async{
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/pay/getpayofficiel/',);
  var result=await  httpIns.get(url);
 if(result.statusCode==200){
  // print(result.body);
   var response=convert.jsonDecode(result.body);
   return response;
 }
 else{
  print(result.body);
 }

}
void initState() {
super.initState();
 getpay().then((res) => 
    setState(()=>{
    for(var i=0;i<res.length;i++){
     pay.add(res[i])
    },
    payload=true
    })
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
       // shadowColor: Colors.grey,
        backgroundColor: Colors.grey,
        leading:IconButton(icon:Icon(Icons.arrow_back_ios_new),
        onPressed: (){
          Navigator.of(context).pop();
        },),
      ),
      body:SingleChildScrollView(
        child:Container(
          margin:EdgeInsets.only(top:20),
          child:Column(children: [
            Container(
            margin: EdgeInsets.only(left: 15),
            child: ListTile(
             title:Row(children: [
            Icon(Icons.cast_for_education_outlined,color: Colors.green,size: 24,),
            TextButton(onPressed: (){ Navigator.of(context).pushNamed('/envoidirect');}
           ,child: Text('Education',style: TextStyle(fontSize: 16,
              fontWeight: FontWeight.bold)),
             style: ButtonStyle(
             foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
             overlayColor:  MaterialStateProperty.all<Color>(Colors.black),
               ), ),
             ],)
             
           ), ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: ListTile(
            title:Row(children: [
            Icon(Icons.water,color: Colors.blue,size: 24,),
            TextButton(onPressed: (){ Navigator.of(context).pushNamed('/envoidirect');}
           ,child: Text('Eau',style: TextStyle(fontSize: 16,
              fontWeight: FontWeight.bold)),
             style: ButtonStyle(
             foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
             overlayColor:  MaterialStateProperty.all<Color>(Colors.black),
               ), ),
             ],)
             ),
            ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: ListTile(
             title:Row(children: [
            Icon(Icons.local_fire_department,color: Colors.red,size: 24,),
            TextButton(onPressed: (){ Navigator.of(context).pushNamed('/envoidirect');}
           ,child: Text('Electricite ',style: TextStyle(fontSize: 16,
              fontWeight: FontWeight.bold)),
             style: ButtonStyle(
             foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
             overlayColor:  MaterialStateProperty.all<Color>(Colors.black),
               ), ),
             ],)
             
           ),
            )
          ],)
        )
      )

    );
  }
}