// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';




class EnvoiDirect extends StatefulWidget {
  const EnvoiDirect({ Key? key }) : super(key: key);

  @override
  State<EnvoiDirect> createState() => _EnvoiDirectState();
}

class _EnvoiDirectState extends State<EnvoiDirect> {
 late PhoneNumber  phone;
  final formKey = GlobalKey<FormState>();
  bool permissionDenied = false;
  bool load=false;
  List<Contact>? contact;
  var httpIns=HttpInstance();
   Widget buildPhone(){
      return Container(
        child: InternationalPhoneNumberInput(
        //initialValue: phone,
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
        selectorTextStyle:const TextStyle(color: Colors.black),
        formatInput: false,
        //keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
        inputBorder:const OutlineInputBorder(),
        countries: const ["SN"],
        inputDecoration: const InputDecoration(
          hintText: 'Phone du beneficiaire',
         //border: InputBorder.none,
         isDense: true
         ),
        ),
       );
       }
  
Future handledirect(context) async{
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/verifynumb/');
  var response=await  httpIns.post(url,body: {'num':"$phone",});
  //print(response.body);
  if (response.statusCode == 200) {
  Navigator.of(context).pushNamed("/confirmationsommenvoidirect",arguments:"$phone");
   
   }
  else {
    showTopSnackBar(
    context,
    const CustomSnackBar.error(
    message:"Erreur!Veuillez verifier les credentiels entres.",),
     //  persistent: true,
        );
    return;
  
 }
 }
  
  /*
   Future fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts(withProperties: true,withPhoto: true);
      for(var i=0;i<contact!.length;i++){
        // ignore: prefer_is_not_empty
        String num=!(contact![i].phones.isEmpty)?(contact![i].phones.first.number):"-"; 
        var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/verifynumb/');
        var response=await  httpIns.post(url,body: {'num':num,});
    if(response.statusCode==200){
      print(response.body);
       setState(() => contact!.add(contacts[i])); 
    }  

      }
     
     // print(contacts);
    }
  }
  @override
  void initState() {
    fetchContacts();
    setState(() {
      load=true;
    });
    super.initState();
  }*/
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
       title:const  Text("Envoi direct"), 
       backgroundColor:const Color.fromRGBO(75, 0, 130, 1),
       leading: IconButton(onPressed: (){
         Navigator.of(context).pop();
       }, icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body:SingleChildScrollView(
      physics:const ScrollPhysics(),
      child: Container(
      width: MediaQuery.of(context).size.width * 0.95,
      margin: const EdgeInsets.only(top:20,right:5,left:5) ,
      child: Column(children: [
        ListTile
        (leading: Image.asset('assets/logo.jpg'
        ,scale:0.1,
        height: 50,
        width: 70,)
       ),
        Container(
        child: Form(
          key: formKey,
          child: Column(children: [
          buildPhone(),
        const SizedBox(height: 20,),
       //   _buildSomme(context),
       // const  SizedBox(height: 20,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all( const Color.fromRGBO(75, 0, 130, 1)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              ))),
              onPressed: (){
              if (formKey.currentState!.validate()) {
               handledirect(context);} }, 
            child: const  Text( 'Valider',
                      style: TextStyle(fontSize: 16),
                    ),),
          ),
        ],)),
        ),
   /*const ListTile(
      title: Text("Choisir parmi les contacts",style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        decoration: TextDecoration.underline
      ),),
    ),
    
    Container(
      child: ListView.builder(
        physics:const  NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: contact!.length ,
         itemBuilder: ((context, index){
          var cont=contact![index];
          Uint8List? image=contact![index].photo;
          // ignore: prefer_is_not_empty
          String num=!(contact![index].phones.isEmpty)?(contact![index].phones.first.number):"-";

          return  Container(
             child:ListTile(
              leading: cont.photo==null?
              const CircleAvatar(
                child: Icon(Icons.person,color: Color.fromRGBO(75, 0, 130,1),))
                :CircleAvatar(
                  backgroundImage: MemoryImage(image!),
                ),
              title: Text(
                cont.displayName
              ),
              subtitle: Text(num),
              onTap: () async{
                if(num=="-"){
                  return;
                }
              await  handledirectfromcontact(context, num);
              },
              )
             );
              }
          ),))*/
           ]),
      ),)
    );
  
  }
}
