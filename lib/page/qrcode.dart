import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import '../apiservice.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class QrCodeUser extends StatefulWidget {
  const QrCodeUser({super.key});

  @override
  State<QrCodeUser> createState() => _QrCodeUserState();
}

class _QrCodeUserState extends State<QrCodeUser> {
  bool load=false;
  var qrcode;
  Future getuserqrcode() async{
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/getuserqrcode/',);
  var result=await  httpIns.get(url);
 if(result.statusCode==200){
   var response=convert.jsonDecode(result.body);
   return response;
 }
 else{
  
 }
}
@override
  void initState() {
  getuserqrcode().then((res) => setState(() {
    qrcode=res['qrcode'];
    load=true;
  },));
  super.initState();
  }
 var httpIns=HttpInstance();
  @override
  Widget build(BuildContext context) {
    return load? Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white,
        automaticallyImplyLeading: false,
        title: const Text('Mon qr-code',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        leading:IconButton(
          onPressed: (){
          Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios,color:Colors.brown)
        ) ,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 15,left: 10,right: 10),
        child: Image.network('https://gaalguimoney.herokuapp.com${qrcode}',
        height: 300,
        width: 300,),
      ),
    ):
      Container(
     decoration: const BoxDecoration(color: Colors.white),
     child: const  SpinKitCircle(
     color: Color.fromARGB(137, 18, 35, 92),
     size: 50.0,
     duration: Duration(milliseconds: 1000),
)
    );
  }
}