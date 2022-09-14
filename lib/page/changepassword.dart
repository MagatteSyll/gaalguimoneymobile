// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert' as convert;
import 'package:gaalguimoney/apiservice.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class ChangePassword extends StatefulWidget {
  final dynamic id;
  const ChangePassword(this.id,{super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late String password; 
  late String passwordcon;
  bool visiblepassword=true;
  late var phone;
  final formKey = GlobalKey<FormState>();
  bool load=false;
   static const platform =  MethodChannel("flutter.native.com/auth");
  var httpIns=HttpInstance();
   Widget buildPassword(){
      return Container(
      child: Row(children: [
      Flexible(
      child: TextFormField(
      maxLength: 5,
      keyboardType: const TextInputType.numberWithOptions(),
      inputFormatters:<TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
       ],
      obscureText: visiblepassword,
      decoration:const  InputDecoration(labelText: 'Nouveau mot de passe(5 chiffres)', ),
      validator: (value){
        if(value==null||value.trim().isEmpty){
          return "Entrez un mot de passe valide";
        }
        return null;},
       onChanged: (value){
         password=value;
       }, ) , ),
     IconButton(
        icon: visiblepassword?const Icon(Icons.visibility):const Icon(Icons.visibility_off),
        //color: Colors.white,
        onPressed: () {
          setState(() {
            visiblepassword=!visiblepassword;
          });
        },
          ), 
      ],)
     
      );
     
    }
   Widget buildPasswordCon(){
      return Container(
       child:
       Row(children: [
      Flexible(child:
       TextFormField(
      maxLength: 5,
       obscureText: true,
        keyboardType: const TextInputType.numberWithOptions(),
       inputFormatters:<TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
         ],
      decoration:const InputDecoration(labelText: 'Confirmation du mot de passe',),
      validator: (value){
        if(value==null||value.trim().isEmpty){
          return "Confirmation du mot de passe";
        }
        if(value!=password){
          return "Les mots de passe ne matchent pas";
        }
        return null;},
       onChanged: (value){
         passwordcon=value;
       },) ),
      ],)
       );
      
    }

 Future  handleconnexion(context) async{
   var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/login/',);
   var response= await httpIns.post(url,body: {'phone':phone,'password':password});
    if(response.statusCode==200){
   var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
   final arguments={'access':jsonResponse['access'],'refresh':jsonResponse['access']};
   await platform.invokeMethod("setoken",arguments);
   final phoneargument={'phone':phone,'code':password};
  await platform.invokeMethod("setphone",phoneargument);
  // print(verif);
  Navigator.of(context).pushNamedAndRemoveUntil('/', (Route route) => false);
    }
  else{
   return;
  }
   }
Future handlemodifpassword(context)async{
    var pk=convert.jsonEncode(widget.id);
    var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/resetpassword/reseter/',);
    var response= await httpIns.put(url,body: {
    'password':password,
    'id':pk
    });
    if(response.statusCode==200){
       await handleconnexion(context);
    }
}
Future getphone()async{
     var id=convert.jsonEncode(widget.id);
    var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/getuserphone/',);
    var response= await httpIns.post(url,body: {'id':id,});
    if(response.statusCode==200){
       var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
       setState(() {
         phone=jsonResponse['phone'];
       });
    }
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
        backgroundColor: const Color.fromRGBO(75, 0, 130, 1),
        automaticallyImplyLeading: false,
        title:const  Text('Reinitialisation de mot de passe',style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),),
      ),
      body: SingleChildScrollView(child: Form(
        key: formKey,
        child: Container(
          margin: const EdgeInsets.only(top: 20,left: 10,right: 10),
          child: Column(children: [
            buildPassword(),
            const SizedBox(height: 10,),
            buildPasswordCon(),
            const SizedBox(height: 15,),
            ElevatedButton(
            style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(75, 0, 130, 1)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
               ))),
              child: const Text(
                   'Valider',
                   style: TextStyle(fontSize: 16),
                  ),
                  onPressed: ()async {
                    if (formKey.currentState!.validate()) {
                      await handlemodifpassword(context);
                      }}, ),
           
          ],),
        ),
      )),

    ):
    Container(
    decoration:const  BoxDecoration(color: Colors.white),
     child: const SpinKitSquareCircle(
     color: Color.fromRGBO(75, 0, 130, 1),
     size: 250.0,
     duration: Duration(milliseconds: 1000),
    ));
  }
}