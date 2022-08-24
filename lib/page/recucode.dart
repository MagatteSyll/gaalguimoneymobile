import 'package:flutter/material.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;
import 'package:intl/intl.dart';
import 'package:gaalguimoney/page/souscomponent/animationload.dart';

class RecuCode extends StatefulWidget {
  final dynamic id;
   RecuCode(@required this.id);

  @override
  State<RecuCode> createState() => _RecuCodeState();
}

class _RecuCodeState extends State<RecuCode> {
 var httpIns=HttpInstance();
  late var montant;
  late var date;
  late var beneficiaire;
  late var commission;
  late var code;
  late var phone;
  late var total;
  bool load=false;

  Future getenvoi()async{
  var id=convert.jsonEncode(widget.id);
   var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/recucode/',);
   var response=await  httpIns.post(url,body: {'id':id});
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    return jsonResponse;
  }
  else {
   print(response.statusCode);
 }
  }
@override
void initState(){
getenvoi().then((res) => 
 setState(()=>{
  beneficiaire=res['Nom_complet_du_receveur'],
  montant=res['somme'],
  commission=res['commission'],
  code=res['code'],
  phone=res['phone_beneficiaire'],
  date=res['created'],
  //total=res['total'],
  load=true
 })
);
super.initState();

}
  @override
  Widget build(BuildContext context) {
    if(load){
    final  formattedDate =DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final heure=DateFormat('HH:mm');
    final String formatted = formatter.format(formattedDate);
     String heuresting=heure.format(formattedDate);
      return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(child: Row(
          children: [
           Icon(Icons.check),
           Text('Envoi via code ')
          ],
        )),
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
        Navigator.of(context).pushNamed('/');
        }),
        ),
      body: SingleChildScrollView(child: Container(
        padding: EdgeInsets.all(5),
      margin:EdgeInsets.only(top: 35,right: 5,left:5) ,
       child:Column(children: [
        Center(
          child:Text('Informations sur la transaction',
          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24)), 
        
      ),
      SizedBox(height: 25,),
      Center(
        child: Row(children: [
         Text("Beneficiare",style: const TextStyle(fontSize: 18)),
         SizedBox(width: 10,),
         Text(beneficiaire,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),

        ]),
      ),
       SizedBox(height: 15,),
       Center(
        child: Row(children: [
         Text("Montant  ",style: const TextStyle(fontSize: 18)),
         SizedBox(width: 10,),
         Text(montant+ " "+ 'CFA',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),

        ]),
      ),
      SizedBox(height: 15,),
      Center(
        child: Row(children: [
         Text("Commission ",style: const TextStyle(fontSize: 18)),
         SizedBox(width: 10,),
         Text(commission + " "+ 'CFA',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),
         ]),
      ),
     SizedBox(height: 15,),
      Center(
        child: Row(children: [
         Text("code de transfert ",style: const TextStyle(fontSize: 18)),
         SizedBox(width: 10,),
         Text("$code",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),
         ]),
      ),
    SizedBox(height: 15,),
    /* SizedBox(height: 15,),
      Center(
        child: Row(children: [
         // Text('Date de l envoi',
         // style: const TextStyle(fontSize: 18)), 
         //  SizedBox(width: 10,),
         // Text(date,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24))
         Text("total",style: const TextStyle(fontSize: 18)),
         SizedBox(width: 10,),
         Text(commission + " "+ 'CFA',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),

        ]),
      ),*/
     SizedBox(height: 15,),
      Center(
        child: Row(children: [
         Text("Le ",style: const TextStyle(fontSize: 18)),
         SizedBox(width: 10,),
         Text(formatted+","+heuresting,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),

        ]),
      ),
     SizedBox(height: 100,),
     Container(
       margin: EdgeInsets.only(left: 100),
       width: MediaQuery.of(context).size.width * 0.95,
       child: Card(child: 
       Text('signature')),
     )
      ]
      ),

   )) );
    }
  else{
     return EnvoiAnimate();
  }
  }
}