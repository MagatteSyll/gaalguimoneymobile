import 'package:flutter/material.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;
import 'package:flutter/services.dart';
import 'package:gaalguimoney/page/souscomponent/animationload.dart';



class ConfirmationPhone extends StatefulWidget {
  final dynamic id;
  ConfirmationPhone(@required this.id);

  @override
  State<ConfirmationPhone> createState() => _ConfirmationPhoneState();
}

class _ConfirmationPhoneState extends State<ConfirmationPhone> {
  late var phone;
  late var decode;
  late var identifiant;
  late var code;
  bool load=false;
  final _formKey = GlobalKey<FormState>();
   var httpIns=HttpInstance();
  static const platform =  MethodChannel("flutter.native.com/auth");

  Future getuser() async{
  var id=convert.jsonEncode(widget.id);
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/getnewusermobile/',);
  var response=await  httpIns.post(url,body: {'id':id});
  if (response.statusCode == 200) {
    print(response.body);
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    return jsonResponse;
  }
  else {
   print(response.statusCode);
 }
  }
Future  handleconnexion(context,tel,mdp) async{
   var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/login/',);
    var response= await httpIns.post(url,body: {'phone':tel,'password':mdp});
    if(response.statusCode==200){
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    final arguments={'access':jsonResponse['access'],'refresh':jsonResponse['access']};
     final setok= await platform.invokeMethod("setoken",arguments);
     Navigator.of(context).pushNamed("/");
    }
  else{
    print(response.statusCode);
  }
  
  }
   
Future handlecode(context) async{
  var id=convert.jsonEncode(identifiant);
  var code_id=convert.jsonEncode(widget.id);
  var tel=convert.jsonEncode(phone);
  var mdp=convert.jsonEncode(decode);
 var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/verificationphoneinscription/',);
  var response=await  httpIns.post(url,body: {'id':id,"code_id": code_id,"code":code});
  if (response.statusCode == 200) {
      await handleconnexion(context, tel, mdp);
  }
  else {
   print(response.statusCode);
 }
}

 @override
  void initState() {
    getuser().then((res) => {
      setState(()=>{
       decode=res['password'],
        phone=res['phone'],
        identifiant=res['id'],
        load=true
      })
    });
   
  super.initState();
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
  @override
  Widget build(BuildContext context) {
    if(load){
     return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 40,left: 10,right: 10),
        child: Column(children: [
          Text("code de confirmation du numero de telephone"),
           SizedBox(height: 15,),
           Container(
             child: Form(
               key: _formKey,
               child: Column(children: [
               _codeWidget(),
               SizedBox(height: 15,),
                ElevatedButton(
              child: Text(
                  'Confirmer',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: (){
                    if (_formKey.currentState!.validate()) {
                       handlecode(context);
                      }}, ),
             ],)),
           )
        ]),
      ),);
    }
  else{
   return ConfirmationPhoneAnimate();
  }
    
  }
}