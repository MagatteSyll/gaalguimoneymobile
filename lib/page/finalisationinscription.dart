import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert' as convert;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:gaalguimoney/apiservice.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class FinalisationInscription extends StatefulWidget {
  final dynamic id;
  const FinalisationInscription(this.id,{super.key});

  @override
  State<FinalisationInscription> createState() => _FinalisationInscriptionState();
}

class _FinalisationInscriptionState extends State<FinalisationInscription> {
  late String password; 
  late String passwordcon;
  bool visiblepassword=true;
  // ignore: prefer_typing_uninitialized_variables
  late var phone;
  final formKey = GlobalKey<FormState>();
  late String nom;
  late String prenom;
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
      decoration:const  InputDecoration(labelText: 'Mot de passe(5 chiffres)', ),
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
   Widget buildPreNom(){
    return  TextFormField(
      decoration: const InputDecoration(labelText: 'Prenom',),
      validator: (value){
        if(value==null||value.trim().isEmpty){
          return "Entrez un prenom";
        }
        return null;},
       onChanged: (value){
         prenom=value;
       },
      );
      
    }
    Widget buildNom(){
    return  TextFormField(
      decoration: const  InputDecoration(labelText: 'Nom',),
      validator: (value){
        if(value==null||value.trim().isEmpty){
          return "Entrez un nom";
        }
        return null;},
       onChanged: (value){
         nom=value;
       },
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
  Future handlefinalisation (context)async{
    var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/finalisationinscription/',);
    var response= await httpIns.post(url,body: {
    'phone':"$phone",
    'password':password,
    "prenom":prenom,
    "nom":nom,});
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
    return load? Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(75, 0, 130, 1),
        automaticallyImplyLeading: false,
        title:const  Text('Finalisation de l inscription',style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),),
      ),
      body: SingleChildScrollView(child: Form(
        key: formKey,
        child: Container(
          margin: const EdgeInsets.only(top: 20,left: 10,right: 10),
          child: Column(children: [
            buildPreNom(),
            const SizedBox(height: 10,),
            buildNom(),
            const SizedBox(height: 10,),
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
                      await handlefinalisation(context);
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