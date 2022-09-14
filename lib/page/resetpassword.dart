import 'package:flutter/material.dart';
import 'package:gaalguimoney/apiservice.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'dart:convert' as convert;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';



class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late PhoneNumber phone;
  var httpIns= HttpInstance();
  final formKey = GlobalKey<FormState>();
  
   Widget buildPhone(){
       return   InternationalPhoneNumberInput(
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
        selectorTextStyle:  const TextStyle(color: Colors.black),
        formatInput: false,
        keyboardType: const  TextInputType.numberWithOptions(signed: true, decimal: true),
        inputBorder:const  OutlineInputBorder(),
        countries:const  ["SN"],
        inputDecoration: const InputDecoration(
          hintText: 'Numero de telephone',
        // border: InputBorder.none,
         isDense: true
          ),
         ); }

  Future handlereset(context)async{
     var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/resetconfirmation/',);
    var response= await httpIns.post(url,body: {'phone':"$phone"});
    if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    // print(response.body);
    Navigator.of(context).pushNamed('/coderesetpassword',arguments: jsonResponse['id']);
    }
  else {
   showTopSnackBar(
    context,
     const CustomSnackBar.error(
    message:"Erreur!Echec de la requete ",),
     //  persistent: true,
   );
   return;
  }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title:const Text("Reinitialisation de mot de passe",style: TextStyle(
          fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18
        ),),
        elevation: 0,
        ),
      body:SingleChildScrollView(
        child: Container(
      decoration: BoxDecoration(
      border: Border.all(color: Colors.black),),
      width: MediaQuery.of(context).size.width * 1,
      padding:const  EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 20,right: 10,left: 10,bottom: 5) ,
      child: Column(children: [
       const  SizedBox(height: 10),
        ListTile(
         leading: Image.asset('assets/logo.jpg'
        ,scale:0.1,
         height: 50,
         width: 70,),
          title:const  Icon(Icons.person,color: Color.fromRGBO(75, 0, 130, 1),),
            ),
        Container(
        padding: const EdgeInsets.all(3.0),
        child: Form(
          key: formKey,
          child: Column(children: [
            buildPhone(),
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
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      handlereset(context);
                      }}, ),
          ],)
           ),
        ),
         TextButton(child: const Text("Se connecter"),
      onPressed: (){
        Navigator.of(context).pushNamed('/connexion');
      },)
        ])
      
    )));
      
  }
  }
