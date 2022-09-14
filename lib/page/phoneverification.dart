// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';



class PhoneVerification extends StatefulWidget {
  final dynamic id;
  const PhoneVerification( this.id, {super.key});

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  var code;
    final formKey = GlobalKey<FormState>();
     var httpIns=HttpInstance();
  Widget codeWidget(){
      return  TextFormField(
     // maxLength: 6,
      keyboardType:TextInputType.number,
      decoration: InputDecoration(labelText: 'code',
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.0), )),
      validator: (value){
        if(value==null||value.trim().isEmpty){
          return "Entrez  un code valide";
        }
        return null;},
       onChanged: (value){
         code=value;
        
       },
      
      );  }
  
  Future handlecode(context)async{
    var pk=convert.jsonEncode(widget.id);
     var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/verificationtel/',);
    var response= await httpIns.post(url,body: {'id':pk,'code':code});
    if (response.statusCode == 200) {
    Navigator.of(context).pushNamed('/finalisationinscription',arguments: widget.id);
    }
  else {
   showTopSnackBar(
    context,
     const CustomSnackBar.error(
    message:"Erreur!Code invalide",),
     //  persistent: true,
   );
   return;
 }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(75,0,120,1),
      ),
      body:Container(
      margin: const EdgeInsets.only(top: 40,left: 10,right: 10),
      child: Form(
        key: formKey,
        child: 
      Column(
        children: [
      const   ListTile(
        title: Text("Code de confirmation du numero de telephone",
        style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      const SizedBox(height: 30,),
        codeWidget(),
        const SizedBox(height: 15,),
         ElevatedButton(
          style: ButtonStyle(
           backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(75, 0, 130, 1)),
           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
               ))),
              child: const Text(
                   'Confirmer',
                   style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                       await handlecode(context);
                      }}, ),
        ],
      )),
      ) ,
    );
  }
}