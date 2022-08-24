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
   final _formKey = GlobalKey<FormState>();

     Widget _buildPhone(){
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
           child: Container(
          child: TextFormField(
          obscureText: visiblepassword,
          decoration: InputDecoration(labelText: 'Mot de passe',
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
          )),
         validator: (value){
        if(value==null||value.isEmpty||value.length<8||RegExp(r"\s").hasMatch(value)){
          return "Entrez un mot de passe valide";
        }
        return null;},
       onChanged: (value){
         password=value;
       },
      
       ),
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
        ]),
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
    message:"Erreur!Tel ou mot de passe incorrect!",),
     //  persistent: true,
   );
   return;
  }
   
  }
   
   
  @override
  Widget build(BuildContext context) { 
    return  Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: ListTile(
          title: Text('logo'),
        ),
        leading: ListTile(
          title:Text('qch'),
        ),
        elevation: 0,
        ),
        body: SingleChildScrollView(child: Container(
        margin:EdgeInsets.only(top: 25,left:5),
        decoration: BoxDecoration(
        border: Border.all(color: Colors.black),),
        width: MediaQuery.of(context).size.width * 0.95,
        padding: EdgeInsets.all(5),
        child:Column(children: [
          SizedBox(height: 10),
          ListTile(
          title: Row(
            children: [
              Text("Authentification"),
              Icon(Icons.person,color: Colors.green,),
            ],
          )),
          Container(
          padding: const EdgeInsets.all(3.0),
          child: Form(
          key: _formKey ,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
             _buildPhone(),
             SizedBox(height: 30,),
             _buildPassword(),
             SizedBox(height: 30,),
             SizedBox(
               width: double.infinity,
               child: ElevatedButton(
                     style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                   RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                   ))),
                      child: Text(
                      'Connexion',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
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
      SizedBox(height: 50,),
      Text('Vous n avez pas encore de compte?'),
       TextButton(
       onPressed: (){
         Navigator.of(context).pushNamed("/inscription");
       }, 
       child: Text(
         'Inscrivez vous',
       style: TextStyle(fontSize: 16),
        ),) ],
        )
        
      ),) 
      
    );
    
  }
}