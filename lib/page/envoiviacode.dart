import 'package:flutter/material.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';



class EnvoiCode extends StatefulWidget {
  //const EnvoiCode({ Key? key }) : super(key: key);

  @override
  State<EnvoiCode> createState() => _EnvoiCodeState();
}

class _EnvoiCodeState extends State<EnvoiCode> {
  late var nom;
  late var phone;
  late var montant;
  final _formKey = GlobalKey<FormState>();
  var httpIns=HttpInstance();

  Widget builNomComplet(){
    return Container(
      child: TextFormField(
      decoration: InputDecoration(labelText: 'Nom complet du beneficiare',
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.0),
      )),
      validator: (value){
        if(value==null||value.isEmpty){
          return "Entrez un nom  valide";
        }
        return null;},
       onChanged: (value){
         nom=value;
       }, ) ,

    );}
  Widget buildSomme(){
    return(
      Container(
      child: TextFormField(
      decoration: InputDecoration(labelText: 'Montant',
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.0),
      )),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters:<TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
         FilteringTextInputFormatter.deny(RegExp(r'^0+')),
      ],
      validator: (value){
        if(value==null||value.isEmpty||RegExp(r"\s").hasMatch(value)){
          return "Entrez un montant  valide";
        }
        return null;},
       onChanged: (value){
        montant=value;
       }, ) ,
      )
    );
  }
  Widget builPhone(){
    return Container(
     
        child: InternationalPhoneNumberInput(
        validator: (value){
          if(value==null||value.isEmpty||RegExp(r"\s").hasMatch(value)){
            return "Entrez un numero de telephone valide";
          }
          return null;},
         onInputChanged: (PhoneNumber value){
           phone=value;
         },
        selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.DROPDOWN,  ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: TextStyle(color: Colors.black),
        formatInput: false,
        keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
        inputBorder: OutlineInputBorder(),
        countries: ["SN"],
        inputDecoration:InputDecoration(
          hintText: 'Numero de telephone du beneficiaire',
         //border: InputBorder.none,
         isDense: true
         ),
        ),
       );
       }
  Future handlecode(context) async{
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/verificationviacode/');
  var response=await  httpIns.post(url,body: {'phone':"$phone",'somme':montant,'nom':nom});
//  print(response.body);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    Navigator.of(context).pushNamed("/confirmationcode",arguments:jsonResponse['id']);
  }
  else {
   showTopSnackBar(
      context,
      CustomSnackBar.error(
      message:"Erreur!Transaction impossible!Veuillez verifier les credentiels entres.",),
     //  persistent: true,
        );
    return;
 }
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
     title: Text("Envoi via code"), 
     backgroundColor: Colors.green,
     leading: IconButton(onPressed: (){
     Navigator.of(context).pop();
      },icon:Icon(Icons.arrow_back_ios_new)),
      ),
     body:SingleChildScrollView(child: Container(
     width: MediaQuery.of(context).size.width * 0.95,
     padding: EdgeInsets.all(5),
     margin:EdgeInsets.only(top: 20,left:10,right: 10,),
     child: Column(children: [
        ListTile
        (title: Text('logo')),
        SizedBox(height: 20),
        Container(
        child: Form(
          key: _formKey,
          child: Column(children: [
          builNomComplet(),
          SizedBox(height: 20,),
          builPhone(),
          SizedBox(height: 20,),
          buildSomme(),
          SizedBox(height: 20,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
            style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
            ))),
             onPressed: (){
             if(_formKey.currentState!.validate()){
             handlecode(context);
            }},
                   child:Text('envoyer')),
          )
        ],)),
        )

      ]),
      ),)
    );
  
  }
}