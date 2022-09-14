// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';
import '../apiservice.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter/services.dart';
import 'dart:convert' as convert;
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
//import 'package:local_auth/local_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SimpleLogin extends StatefulWidget {
  const SimpleLogin({super.key});

  @override
  State<SimpleLogin> createState() => _SimpleLoginState();
}

class _SimpleLoginState extends State<SimpleLogin> {
   static const platform =  MethodChannel("flutter.native.com/auth");
    var code;
    var phone;
     var httpIns=HttpInstance();
     bool load=false;
    
   Future getphone() async{
    var tel=await platform.invokeMethod("getphone") ;
    var mdp=await platform.invokeMethod("getcode");
    setState(() {
      phone=tel;
      code=mdp;
    },);}
  
  Future deconnextion(context) async{
    await platform.invokeMethod("deconnexion");
    Navigator.of(context).pushNamedAndRemoveUntil('/connexion', (Route route) => false);
  }
  Future handleconnexion(context) async{
   await getphone();
   var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/login/',);
    var response= await httpIns.post(url,body: {'phone':"$phone",'password':code});
    if(response.statusCode==200){
   var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
   final arguments={'access':jsonResponse['access'],'refresh':jsonResponse['access']};
   await platform.invokeMethod("setoken",arguments);
   Navigator.of(context).pushNamedAndRemoveUntil("/", (Route route) => false);
    }
  else{
    showTopSnackBar(
    context,
     const CustomSnackBar.error(
    message:"Erreur!Verifiez les donnees entrees ",),
     //  persistent: true,
   );
   return;
  } 
  }
  Future handlemore()async{
    return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child:  Row(
            children: [
              TextButton(onPressed: () async{
              await deconnextion(context);
              },
        child: const  Text('Changer de compte ',style: TextStyle(color: Colors.blue,
        fontWeight: FontWeight.bold,fontSize:16,)),
              ),
     
              ]),
       ) );
    },
  );
  }
 /* Future localauth( BuildContext context) async{
  final localauth=LocalAuthentication();
  final didauth=await localauth.authenticate(localizedReason: "Authentification");
  if(didauth){

  }
  }*/
 Future handlepasswordforget(context)async{
  await deconnextion(context);
   Navigator.of(context).pushNamedAndRemoveUntil("/resetpassword", (Route route) => false);
 }
 @override
 void initState() {
    getphone();
    setState(() {
      load=true;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return  load? Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.white,
       title: Row(
         children: [
           Image.asset('assets/logo.jpg'
            ,scale:0.1,
             height: 30,
             width: 50,),
             const SizedBox(width: 180,),
            IconButton(onPressed: () async{
               await handlemore();
            },
             icon: const Icon(Icons.more_horiz,color: Colors.black,size: 40,))
         ],
       ),
         automaticallyImplyLeading: false,
        
      ),
      body: ScreenLock(
          correctString: code,
          digits: 5,
          title:const Text("Mot de passe ",
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
         didCancelled: Navigator.of(context).pop,
          didUnlocked: () async{
          await  handleconnexion(context);
          },
          deleteButton: const Icon(Icons.backspace_rounded,color: Colors.red,),
          screenLockConfig:const  ScreenLockConfig(backgroundColor: Colors.white),
          secretsConfig:const SecretsConfig(
            spacing: 20,
            secretConfig: SecretConfig(
             borderColor: Colors.blue ,
             disabledColor: Colors.grey,
             enabledColor: Colors.green
            )
          ),
          footer: TextButton(child: const Text("Mot de passe oublie?",
          style: TextStyle(fontWeight: FontWeight.bold),),
          onPressed:()async{
            await handlepasswordforget(context);
          }
          )
        /*  didOpened: ()async{
             await localauth(context);
          },
          customizedButtonChild:const Icon(Icons.fingerprint,color: Colors.green,size: 34,),
          customizedButtonTap: ()async{
            await localauth(context);
          },*/
           ),
     
    ):
    Container(
      decoration:const BoxDecoration(color: Colors.white),
     child:const SpinKitSquareCircle(
     color: Color.fromRGBO(75, 0, 130, 1),
     size: 250.0,
     duration: Duration(milliseconds: 1000),)
    );
  }
}