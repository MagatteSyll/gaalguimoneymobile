import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import '../apiservice.dart';
import 'package:flutter/services.dart';
import 'package:gaalguimoney/page/souscomponent/animationload.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class PayementCode extends StatefulWidget {
   final dynamic id;
   PayementCode(@required this.id);

  @override
  State<PayementCode> createState() => _PayementCodeState();
}

class _PayementCodeState extends State<PayementCode> {
   bool loaded=false;
    var httpIns=HttpInstance();
    late var nom;
    late var logo;
    late var objet;
    late var somme;
    late var payeur;
    final _formKey = GlobalKey<FormState>();

  Future getprofessionnel() async{
   var id=convert.jsonEncode(widget.id);
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/pay/getbusinessmodel/',);
  var result=await  httpIns.post(url,body: {'id':id});
 if(result.statusCode==200){
  // print(result.body);
   var response=convert.jsonDecode(result.body);
   return response;
 }
 else{
  return;
 }
}
void initState() {
    getprofessionnel()
    .then((res) => 
     setState(()=>{
       nom=res['nom'],
       logo=res['logo'],
       loaded=true

     })
    );
    super.initState();
    }
  Widget buildPayeur(){
      return Container(
      margin:EdgeInsets.only(top: 15),
      child: TextFormField(
      decoration: InputDecoration(labelText: 'Nom complet du client',
       border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.0),
      ),),
      validator: (value){
        if(value==null||value.isEmpty){
          return "Entrez un nom valide";
        }
        return null;},
       onChanged: (value){
         payeur=value;
       },
       ) ,
      );
       }
  Widget buildSomme(context){
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextFormField(
      decoration: InputDecoration(labelText: 'Montant a payer',
       border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters:<TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
         FilteringTextInputFormatter.deny(RegExp(r'^0+')),
      ],
      validator: (value){
        if(value==null||value.isEmpty){
          return "Entrez un montant  valide";
        }
        return null;},
       onChanged: (value){
         somme=value;
       }, ) ,
     );
  }
  Widget buildObject(){
       return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 2,
      decoration: InputDecoration(labelText: 'Objet du payement ',
       border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.0),
      ),),
      validator: (value){
        if(value==null||value.isEmpty){
          return "Donnee invalide";
        }
        return null;},
       onChanged: (value){
         objet=value;
       },
       ) ,
      );
     }
  Future handlevalidation(context) async{
     var id=convert.jsonEncode(widget.id);
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/pay/qrcodepayementbusiness/');
  var response=await  httpIns.post(url,body: {'objet':objet,'somme':somme,'nom':payeur,'id':id});
//  print(response.body);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    Navigator.of(context).pushNamed("/recupayementqrcode",arguments:jsonResponse['id']);
  }
  else {
     showTopSnackBar(
      context,
      CustomSnackBar.error(
      message:"Erreur!Transaction impossible!Veuillez verifier votre solde.",),
     //  persistent: true,
        );
    return;
   
 }
 }

  @override
  Widget build(BuildContext context) {
    if(loaded){
     return Scaffold(
     appBar:AppBar(
       leading:IconButton(onPressed: (){
         Navigator.of(context).pop();
       }, icon:Icon(Icons.arrow_back_ios_new)),
       backgroundColor: Color.fromRGBO(65, 0, 150, 1),
       title: Row(children: [
         Text(nom),
         SizedBox(width: 15,),
         ClipRRect(
        borderRadius: BorderRadius.circular(3.0),
        child: Image.network('https://gaalguimoney.herokuapp.com$logo',
                width: 20,
                height:20,
                fit: BoxFit.cover,),
                
         ),
          ]),

     ),
     body: Container(
       margin: EdgeInsets.only(top: 30,left: 20,right: 20),
       child: Column(children: [
        Container(
        padding: const EdgeInsets.all(3.0),
        child: Form(
           key: _formKey,
          child: 
        Column(children: [
          buildObject(),
          SizedBox(height: 15,),
          buildPayeur(),
          SizedBox(height: 15,),
          buildSomme(context),
          SizedBox(height: 15,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton( 
            style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color.fromRGBO(65, 0, 150, 1)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
           // side: BorderSide(color: Colors.red)
     )
  )
),
               onPressed: (){
              if (_formKey.currentState!.validate()) {
                  handlevalidation(context);
             } 
            }, 
            child: Text( 'Valider',
                      style: TextStyle(fontSize: 16),
                    ),),
          ),

             ],)),)

       ],),
     )
    );
    }
  else{
   return EnvoiAnimate();
  }
   
  }
}