import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';







class Connection extends StatefulWidget {
  const Connection({ Key? key }) : super(key: key);

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
     late PhoneNumber phone;
     late String password;
     static const platform =  MethodChannel("flutter.native.com/auth");
     var httpIns=HttpInstance();
     bool visiblepassword=true;
   final formKey = GlobalKey<FormState>();
   FirebaseMessaging messaging = FirebaseMessaging.instance;

     Widget _buildPhone(){
       return InternationalPhoneNumberInput(
       validator: (value){
         if(value==null||value.trim().isEmpty){
           return "Entrez un numero de telephone valide";
         }
         return null;},
        onInputChanged: (PhoneNumber value){
          phone=value;
        },
       selectorConfig:const SelectorConfig(
       selectorType: PhoneInputSelectorType.DROPDOWN,  ),
       ignoreBlank: false,
       autoValidateMode: AutovalidateMode.disabled,
       selectorTextStyle:const TextStyle(color: Colors.black),
       formatInput: false,
       keyboardType:const TextInputType.numberWithOptions(signed: true, decimal: true),
       inputBorder:const OutlineInputBorder(),
       countries:const  ["SN"],
       inputDecoration:const InputDecoration(
         hintText: 'Numero de telephone',
       // border: InputBorder.none,
        isDense: true
        
        ),
       );
       }
    
    Widget _buildPassword(){
      return Row(children: [
       Flexible(
         child: TextFormField(
         keyboardType:const TextInputType.numberWithOptions(decimal: true,
      signed: false,),
         inputFormatters:<TextInputFormatter>[
         FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
       ],
         obscureText: visiblepassword,
         decoration: InputDecoration(labelText: 'Mot de passe',
         border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(100.0),
         )),
       validator: (value){
      if(value==null||value.trim().isEmpty){
         return "Entrez votre mot de passe";
      }
      return null;},
       onChanged: (value){
       password=value;
       },
      
       )),
      IconButton(
      icon: visiblepassword?const Icon(Icons.visibility_off):const Icon(Icons.visibility),
      //color: Colors.white,
      onPressed: () {
        setState(() {
          visiblepassword=!visiblepassword;
        });
      },
        ),  
      ]);
      
    }
  Future  handleconnexion(context) async{
   var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/login/',);

    var response= await httpIns.post(url,body: {'phone':"$phone",'password':password});
    if(response.statusCode==200){
   var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
   final arguments={'access':jsonResponse['access'],'refresh':jsonResponse['access']};
   await platform.invokeMethod("setoken",arguments);
   final phoneargument={'phone':"$phone",'code':password};
    await platform.invokeMethod("setphone",phoneargument);
    final token = await messaging.getToken();
    print(token);
   await managetokenapp(token);
  Navigator.of(context).pushNamedAndRemoveUntil('/', (Route route) => false);
    }
  else{
    showTopSnackBar(
    context,
  const  CustomSnackBar.error(
    message:"Erreur!Tel ou mot de passe incorrect!",),
     //  persistent: true,
   );
   return;
  }
   }

  Future managetokenapp(token) async{
   var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/getuserdevice/',);
   var result=await  httpIns.post(url,body: {
    "registration_id": token,
    "type": 'android',
  });
 if(result.statusCode==200){
   print(result.body);
 }
 else{

print(result.body);
print(result.statusCode);
 }
  }

  

    
  @override
  Widget build(BuildContext context) { 
    return  Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title:const Text("Compte GaalguiMoney",style: TextStyle(
          fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18
        ),),
        elevation: 0,
        ),
        body: SingleChildScrollView(child: Container(
        margin: const EdgeInsets.only(top: 25,left:5),
        decoration: BoxDecoration(
        border: Border.all(color: Colors.black),),
        width: MediaQuery.of(context).size.width * 0.95,
        padding:const  EdgeInsets.all(5),
        child:Column(children: [
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
          key: formKey ,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
             _buildPhone(),
           const  SizedBox(height: 30,),
             _buildPassword(),
           const   SizedBox(height: 30,),
             SizedBox(
               width: double.infinity,
               child: ElevatedButton(
                  style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(75, 0, 130, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                   RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                   ))),
                      child: const Text(
                      'Se connecter',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                         // print(phone);
                         // print(password);
                         handleconnexion(context);
                        
    
                        } 
                         },
                    ),
             ),
               
            ]
          )
        ),
      
          ),
    const   SizedBox(height: 50,),
    const  Text('Vous n avez pas encore de compte?'),
       TextButton(
       onPressed: (){
         Navigator.of(context).pushNamed("/inscription");
       }, 
       child: const Text(
         'Inscrivez vous',
       style: TextStyle(fontSize: 16),
        ),) ],
        )
       ),) 
      
    );
    
  }
}