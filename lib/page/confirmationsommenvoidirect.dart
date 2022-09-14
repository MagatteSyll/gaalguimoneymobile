// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;
import 'package:flutter/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



enum NaturePayement{inclus,noninclus}
class ConfirmationSommeDirect extends StatefulWidget {
  final dynamic phone;
  const ConfirmationSommeDirect(this.phone,{super.key});

  @override
  State<ConfirmationSommeDirect> createState() => _ConfirmationSommeDirectState();
}

class _ConfirmationSommeDirectState extends State<ConfirmationSommeDirect> {

   var httpIns=HttpInstance();
   
  var beneficiaire ;
   bool load=false;
   late var montant;
   final formKey = GlobalKey<FormState>();
  
  var nature=['non inclus','inclus'];
  var naturepay;

  Future getbeneficiaire()async{
      var phone=convert.jsonEncode(widget.phone);
      var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/getbeneficiaire/');
  var response=await  httpIns.post(url,body: {'phone':phone});
//  print(response.body);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
   // print(response.body);
     setState(() {
      beneficiaire=jsonResponse;
     });
  }
  else {
    return;
 }
  }

Widget buildSomme(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Montant',
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.0),
      )),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
     inputFormatters:<TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
         ],
      validator: (value){
        if(value==null||value.trim().isEmpty){
          return "Entrez un montant  valide";
        }
        if(int.parse(value)<5){
          return "Le minimum a envoyer est de 5 CFA"; 
        }
        return null;},
       onChanged: (value){
        montant=value;
       } ,
     
    );
  }


  Future handlesomme(context)async{
     var phone=convert.jsonEncode(widget.phone);
     var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/verifenvoi/');
  var response=await  httpIns.post(url,body: {'phone':phone,'somme':montant,"nature":naturepay});
//  print(response.body);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    Navigator.of(context).pushNamed("/confirmationenvoi",arguments:jsonResponse['id']);
  }
  else {
    showTopSnackBar(
      context,
      const CustomSnackBar.error(
      message:"Erreur!Transaction impossible!Veuillez verifier les credentiels entres.",),
     //  persistent: true,
        );
    return;
 }
  }
  @override
  void initState() {
    getbeneficiaire();
    setState(() {
      load=true;
     naturepay=nature[0];
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return load? Scaffold(
      appBar: AppBar(
      backgroundColor: const Color.fromRGBO(75, 0, 130, 1),
       title:const Text("Donnees du beneficiaire",style: TextStyle(
        fontWeight: FontWeight.bold,color: Colors.white
       ),),  
      ),
      body: SingleChildScrollView(child: 
      Container(
        child: Column(children: [
         ListTile(
          title: Text('Beneficiaire :${beneficiaire['prenom']} ${beneficiaire['nom']}',
          style:const TextStyle(fontWeight: 
          FontWeight.bold),),
         ) ,
         ListTile(
          title: Text(' Phone:${beneficiaire['phone']}',style:const TextStyle(fontWeight: 
          FontWeight.bold),),
         ) ,
         Container(
          margin: const EdgeInsets.only(top: 10,left: 10,right: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
           const  ListTile(title: Text("Mode de payement de la commission")),
            ListTile(  
             title: const Text('Non incluse'),  
              leading: Radio(  
              value: nature[0],  
             groupValue: naturepay,  
              onChanged: (  value) {  
                print(value); 
               setState(() {
                 naturepay=value;
               });
              }
               ,  
              ),  
                ), 
            ListTile(  
             title: const Text('Incluse'),  
              leading: Radio(  
              value:nature[1] ,  
             groupValue: naturepay,  
              onChanged: ( value) {
                print(value)  ;
               setState(() {  
             naturepay=value; 
                  });  
                 },  
              ),  
                ), 
            
          
             const SizedBox(height: 15,),
             buildSomme(),
             const SizedBox(height: 15,),
             SizedBox(
            width: double.infinity,
            child: ElevatedButton(
            style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all (const Color.fromRGBO(75, 0, 130, 1)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
            ))),
             onPressed: () async{
             if(formKey.currentState!.validate()){
              await handlesomme(context);
            }},
             child: const Text('Soumettre')),
          )

            ],
          )),
         )
        ]),
      )),
    )
    :
    Container(
       decoration:const  BoxDecoration(color: Colors.white),
     child:const SpinKitPouringHourGlass(
     color: Colors.red,
     size: 250.0,
     duration: Duration(milliseconds: 1000),
    ));
  }
}