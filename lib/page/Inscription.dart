import 'package:flutter/material.dart';
import 'package:gaalguimoney/apiservice.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'dart:convert' as convert;
import 'package:flutter/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class Inscription extends StatefulWidget {
  //const Inscription({ Key? key }) : super(key: key);
 
  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  late PhoneNumber phone;
  late String password;
  late String passwordcon;
  bool visiblepassword=true;
  bool visiblepasswordcon=true;
  late var code;
  late String nom;
  late String prenom;
  late String  numerodocument;
 
 var httpIns= HttpInstance();
  String naturedocument = 'piece d identite';
  final _formKey = GlobalKey<FormState>();
  final _formKeycode = GlobalKey<FormState>();
  static const platform =  MethodChannel("flutter.native.com/auth");

  Widget _buildPhone(){
       return Container(
      child:  InternationalPhoneNumberInput(
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
          hintText: 'Numero de telephone',
        // border: InputBorder.none,
         isDense: true
         
         ),
        ),
       );
      
      }
    Widget _buildPassword(){
      return Container(
      child: Row(children: [
      Flexible(
      child: TextFormField(
      obscureText: visiblepassword,
      decoration: InputDecoration(labelText: 'Mot de passe',
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.0),
          )
      ),
      validator: (value){
        if(value==null||value.isEmpty||value.length<8||RegExp(r"\s").hasMatch(value)){
          return "Entrez un mot de passe valide";
        }
        return null;},
       onChanged: (value){
         password=value;
       },
      
       ) , ),
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
   Widget _buildPasswordCon(){
      return Container(
       child:
       Row(children: [
      Flexible(child:
       TextFormField(
       obscureText: visiblepasswordcon,
      decoration: InputDecoration(labelText: 'Confirmation du mot de passe',
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.0),
          )),
      validator: (value){
        if(value==null||value.isEmpty||value.length<8||RegExp(r"\s").hasMatch(value)){
          return "Confirmation du mot de passe";
        }
        if(value!=password){
          return "Les mots de passe ne matchent pas";
        }
        return null;},
       onChanged: (value){
         passwordcon=value;
       },) ),
      IconButton(
        icon: visiblepasswordcon?const Icon(Icons.visibility):const Icon(Icons.visibility_off),
        //color: Colors.white,
        onPressed: () {
          setState(() {
            visiblepasswordcon=!visiblepasswordcon;
          });
        },
          ), ],)
       
      );
      
    }
   Widget _buildPreNom(){
      return Container(
       child:
      TextFormField(
      decoration: InputDecoration(labelText: 'Prenom',
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.0),
          )),
      validator: (value){
        if(value==null||value.isEmpty||RegExp(r"\s").hasMatch(value)){
          return "Entrez un prenom";
        }
        return null;},
       onChanged: (value){
         prenom=value;
       },
      
       )
      );
      
    }
    Widget _buildNom(){
      return Container(
     child:TextFormField(
      decoration: InputDecoration(labelText: 'Nom',
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.0),
          )),
      validator: (value){
        if(value==null||value.isEmpty||RegExp(r"\s").hasMatch(value)){
          return "Entrez un nom";
        }
        return null;},
       onChanged: (value){
         nom=value;
       },
      
       )
      );
      
    }
  Widget _buildDocument(){
      return Container(
        child:
        TextFormField(
      keyboardType:TextInputType.number,
      decoration: InputDecoration(labelText: 'Numero du document',
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.0),
          )),
      validator: (value){
        if(value==null||value.isEmpty||value.length<8||RegExp(r"\s").hasMatch(value)){
          return "Entrez le numero du document";
        }
        return null;},
       onChanged: (value){
         numerodocument=value;
       },
      
       )
      );
     
    }
  
  Widget _DocumentNature(){
  return   DropdownButton<String>(
      value: naturedocument,
    //  icon: const Icon(Icons.pages),
      elevation: 16,
      //style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? newValue) {
        setState(() {
          naturedocument = newValue!;
        });
      },
      items: <String>['piece d identite', 'passport',]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
  Widget _codeWidget(){
      return Container(
        child:
        TextFormField(
      keyboardType:TextInputType.number,
      decoration: InputDecoration(labelText: 'code',
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.0),
          )),
      validator: (value){
        if(value==null||value.isEmpty||RegExp(r"\s").hasMatch(value)){
          return "Entrez le un code valide";
        }
        return null;},
       onChanged: (value){
         code=value;
       },
      
       )
      );
     
    }
  Future  handleconnexion(context) async{
   var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/login/',);
    var response= await httpIns.post(url,body: {'phone':"$phone",'password':password});
    if(response.statusCode==200){
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    final arguments={'access':jsonResponse['access'],'refresh':jsonResponse['access']};
     await platform.invokeMethod("setoken",arguments);
     Navigator.of(context).pushNamed("/");
    }
  else{
    showTopSnackBar(
    context,
    CustomSnackBar.error(
    message:"Erreur!Impossible de s inscrire!Veuillez verifier les credentiels entres .",),
     //  persistent: true,
   );
   return;
  }
  
  }
  Future handlecode(context,id,codid) async{
  var userid=convert.jsonEncode(id);
   var idcode=convert.jsonEncode(codid);
   var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/verificationphoneinscription/',);
  var response=await  httpIns.post(url,body: {'id':userid,"code_id": idcode,"code":code});
  if (response.statusCode == 200) {
      await handleconnexion(context);
    // print(response.body);
  }
  else {
   print(response.statusCode);
 }
}

  Future handleinscription() async{
    var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/registration/',);
    var response= await httpIns.post(url,body: {'phone':"$phone",'password':password,"prenom":prenom,
    "nom":nom,"nature_document":naturedocument,"numero_document":numerodocument});
    if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    var id =jsonResponse['id'];
    var codid=jsonResponse['code_id'];
    return showDialog(context: context,
    barrierDismissible: false, 
    builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Code de verification du numero de telephone'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
                 SizedBox(height: 15,),
                 Container(
                   child: Form(
                     key: _formKeycode,
                     child: Column(children: [
                     _codeWidget(),
                     SizedBox(height: 15,),
                      ElevatedButton(
                    style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    ))),
                    child: Text(
                    'Confirmer',
                    style: TextStyle(fontSize: 16),
                    ),
                    onPressed: (){
                     if (_formKey.currentState!.validate()) {
                    handlecode(context,id,codid);
                     }}, ),
                   ],)),
                 )
              
            ],
          ),
        )

      );
    });
   
  }
  else {
   print(response.statusCode);
 }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
      ),
      body:SingleChildScrollView(
        child: Container(
      decoration: BoxDecoration(
      border: Border.all(color: Colors.black),),
      width: MediaQuery.of(context).size.width * 1,
      padding: EdgeInsets.all(5),
      margin:EdgeInsets.only(top: 20,right: 10,left: 10,bottom: 5) ,
      child: Column(children: [
        SizedBox(height: 5),
        Container(
          child: Row(children: [
            SizedBox(width: 50,),
            Text("Vous avez un compte?"),
            TextButton(
            onPressed: (){Navigator.of(context).pushNamed("/connexion");},
            child: Text('se connecter'))
            ]),
        ),
        Container(
        padding: const EdgeInsets.all(3.0),
       // decoration: BoxDecoration(
       // border: Border.all(color: Colors.black),),
        child: Form(
          key: _formKey,
          child: Column
          (children: [
             _buildPhone(),
            SizedBox(height: 15,),
            _buildPreNom(),
            SizedBox(height: 15,),
            _buildNom(),
            SizedBox(height: 15,),
            _buildPassword(),
            SizedBox(height: 15,),
            _buildPasswordCon(),
            SizedBox(height: 15,),
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                
                children: [
                Text("Nature du document",style: TextStyle(color: Colors.purple),),
                SizedBox(width: 50,),
                _DocumentNature()

              ]),
            ),
           _buildDocument(),
           SizedBox(height: 10,),
            ElevatedButton(
              style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
               ))),
              child: Text(
                   'Inscription',
                   style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      handleinscription();
                      }}, ),
           SizedBox(height: 10,),

          ],)),
        )
      ]),
      )
    ));
      
      
  }
}