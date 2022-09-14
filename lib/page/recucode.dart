import 'package:flutter/material.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;
import 'package:intl/intl.dart';
import 'package:gaalguimoney/page/souscomponent/animationload.dart';

class RecuCode extends StatefulWidget {
  final dynamic id;
  const RecuCode(this.id,{ Key? key }) : super(key: key);

  @override
  State<RecuCode> createState() => _RecuCodeState();
}

class _RecuCodeState extends State<RecuCode> {
 var httpIns=HttpInstance();
 
  // ignore: prefer_typing_uninitialized_variables
  late var data;
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
  data=res,
  load=true
 })
);
super.initState();

}
  @override
  Widget build(BuildContext context) {
    if(load){
    final  formattedDate =DateTime.parse(data['created']);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final heure=DateFormat('HH:mm');
    final String formatted = formatter.format(formattedDate);
     String heuresting=heure.format(formattedDate);
      return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(child: Row(
          children:const  [
           Icon(Icons.done_all),
           Text('Transaction éffectuée')
          ],
        )),
        leading: IconButton(
        icon:const Icon(Icons.arrow_back),
        onPressed: () {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route route) => false);
        }),
        ),
      body: SingleChildScrollView(child: Container(
        padding:const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 35,right: 5,left:5) ,
       child:Column(children: [
       const Center(
          child:Text('Informations sur la transaction',
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24)), 
        
      ),
    const  SizedBox(height: 25,),
      Center(
        child: Row(children: [
       const  Text("Beneficiare",style:  TextStyle(fontSize: 18)),
       const  SizedBox(width: 10,),
        Text(data['Nom_complet_du_receveur'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),

        ]),
      ),
     const  SizedBox(height: 15,),
       Center(
        child: Row(children: [
        const Text("Montant  ",style: TextStyle(fontSize: 18)),
        const SizedBox(width: 10,),
         Text(data['somme']+ " "+ 'CFA',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),

        ]),
      ),
     const SizedBox(height: 15,),
      Center(
        child: Row(children: [
        const Text("Commission ",style:  TextStyle(fontSize: 18)),
        const SizedBox(width: 10,),
         Text(data['commission'] + " "+ 'CFA',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),
         ]),
      ),
      const SizedBox(height: 15,),
      Center(
        child: Row(children: [
        const Text("Total de la transaction ",style:  TextStyle(fontSize: 18)),
        const SizedBox(width: 10,),
         Text(data['total'] + " "+ 'CFA',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),
         ]),
      ),
    const SizedBox(height: 15,),
      Center(
        child: Row(children: [
        const Text("code de transfert ",style:  TextStyle(fontSize: 18)),
       const  SizedBox(width: 10,),
         Text("${data['code']}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),
         ]),
      ),
   const SizedBox(height: 15,),
      Center(
        child: Row(children: [
        const Text("Le ",style:  TextStyle(fontSize: 18)),
        const SizedBox(width: 10,),
         Text("$formatted,$heuresting",
            style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),

        ]),
      ),
    const SizedBox(height: 100,),
     Container(
       margin:const EdgeInsets.only(left: 100),
       width: MediaQuery.of(context).size.width * 0.95,
       child:const Card(child: 
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