// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';



class EnvoiCode extends StatefulWidget {
  const EnvoiCode({ Key? key }) : super(key: key);

  @override
  State<EnvoiCode> createState() => _EnvoiCodeState();
}

class _EnvoiCodeState extends State<EnvoiCode> {
  late var nom;
  late var phone;
  late var montant;
   var nature=['non inclus','inclus'];
  var naturepay;
  final formKey = GlobalKey<FormState>();
  var httpIns=HttpInstance();

  Widget builNomComplet(){
    return  TextFormField(
      decoration:const InputDecoration(labelText: 'Nom complet du beneficiare',),
      validator: (value){
        if(value==null||value.trim().isEmpty){
          return "Entrez un nom  valide";
        }
        return null;},
       onChanged: (value){
         nom=value;
       }, );}
  Widget buildSomme(){
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Montant', ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
     inputFormatters:<TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
         ],
      validator: (value){
        if(value==null||value.trim().isEmpty){
          return "Entrez un montant  valide";
        }
        if(int.parse(value)<5){
          return "Le minimum à envoyer est de 5 CFA"; 
        }
        return null;},
       onChanged: (value){
        montant=value;
       } ,
     
    );
  }
  Widget builPhone(){
    return  InternationalPhoneNumberInput(
        validator: (value){
          if(value==null||value.trim().isEmpty){
            return "Entrez un numero de telephone valide";
          }
          return null;},
         onInputChanged: (PhoneNumber value){
           phone=value;
         },
        selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.DROPDOWN,  ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle:const  TextStyle(color: Colors.black),
        formatInput: false,
        keyboardType:const TextInputType.numberWithOptions(signed: true, decimal: true),
        
        inputBorder:const  OutlineInputBorder(),
        countries: const ["SN"],
        inputDecoration: const InputDecoration(
          hintText: 'Numero de telephone du beneficiaire',
         //border: InputBorder.none,
         isDense: true
        )
         );
        
       }
  Future handlecode(context) async{
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/verificationviacode/');
  var response=await  httpIns.post(url,body: {'phone':"$phone",'somme':montant,'nom':nom,
  "nature":naturepay});
//  print(response.body);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    Navigator.of(context).pushNamed("/confirmationcode",arguments:jsonResponse['id']);
  }
  else {
   showTopSnackBar(
      context,
     const CustomSnackBar.error(
      message:"Erreur!Transaction impossible!Veuillez verifier les credentiels entrés.",),
     //  persistent: true,
        );
    return;
 }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
     title:  const Text("Envoi via code"), 
     backgroundColor:const  Color.fromRGBO(75, 0, 130, 1),
     leading: IconButton(onPressed: (){
     Navigator.of(context).pop();
      },icon: const Icon(Icons.arrow_back_ios_new)),
      ),
     body:SingleChildScrollView(child: Container(
     width: MediaQuery.of(context).size.width * 0.95,
     padding:const  EdgeInsets.all(5),
     margin: const EdgeInsets.only(top: 20,left:10,right: 10,),
     child: Column(children: [
        ListTile
        (leading:Image.asset('assets/logo.jpg',scale:0.1,
        height: 50,
        width: 70,)),
         const  ListTile(title: Text("Mode de payement de la commission")),
            ListTile(  
             title: const Text('Non incluse'),  
              leading: Radio(  
              value: nature[0],  
             groupValue: naturepay,  
              onChanged: (  value) {  
              //  print(value); 
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
               // print(value)  ;
               setState(() {  
             naturepay=value; 
                  });  
                 },  
              ),  
                ), 
       const  SizedBox(height: 20),

        Container(
        child: Form(
          key: formKey,
          child: Column(children: [
          builNomComplet(),
        const  SizedBox(height: 20,),
          builPhone(),
        const  SizedBox(height: 20,),
          buildSomme(),
        const  SizedBox(height: 20,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
            style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all (const Color.fromRGBO(75, 0, 130, 1)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
            ))),
             onPressed: (){
             if(formKey.currentState!.validate()){
             handlecode(context);
            }},
             child: const Text('Soumettre')),
          )
        ],)),
        )

      ]),
      ),)
    );
  
  }
}