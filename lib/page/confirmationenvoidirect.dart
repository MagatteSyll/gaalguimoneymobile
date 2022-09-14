import 'package:flutter/material.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;
import 'package:gaalguimoney/page/souscomponent/animationload.dart';

class ConfirmationDirect extends StatefulWidget {
 // const ConfirmationDirect({ Key? key }) : super(key: key);
 final dynamic id;
 const ConfirmationDirect(this.id, {super.key});
  @override
  State<ConfirmationDirect> createState() => _ConfirmationDirectState();
}

class _ConfirmationDirectState extends State<ConfirmationDirect> {
  var httpIns=HttpInstance();
   late var data;
   bool load=false;


  Future getransaction()async{
  var id=convert.jsonEncode(widget.id);
   var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/getransaction/',);
   var response=await  httpIns.post(url,body: {'id':id});
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    //Navigator.of(context).pushNamed("/confirmationenvoi",arguments:jsonResponse['id']);
    return jsonResponse;
  }
  else {
   return;
 }
  }

Future confirmation(context) async{
  var id=convert.jsonEncode(widget.id);
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/envoyerdirect/envoyerdirectement/',);
   var response=await  httpIns.put(url,body: {'id':id});
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    Navigator.of(context).pushNamed("/recudirect",arguments:jsonResponse['id']);
    return jsonResponse;
  }
  else {
  return;
 }
}
Future annulation(context) async{
  var id=convert.jsonEncode(widget.id);
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/envoyerdirect/annulationenvoi/',);
   var response=await  httpIns.put(url,body: {'id':id});
  if (response.statusCode == 200) {
    Navigator.of(context).pop();
  }
  else {
  return;
 }

}

  @override
  void initState() {
    getransaction().then((res) => {
      setState(()=>{
        data=res,
        load=true
      })
    });
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(load){
   return   Scaffold(
     appBar: AppBar(
       title: const Text("Confirmation de l envoi"), 
       backgroundColor:const  Color.fromRGBO(75, 0, 130, 1),
       leading: IconButton(onPressed: (){
        annulation(context);
       }, icon:const Icon(Icons.arrow_back_ios_new)),
      ),
      body:SingleChildScrollView(child: Container(
      margin: const EdgeInsets.only(top: 20,right: 10,left:10) ,
      child:Column(children: [
        ListTile(
          leading: Image.asset('assets/logo.jpg'
        ,scale:0.1,
        height: 50,
        width: 70,),
        ),
      const   SizedBox(height: 15,),
       const Center(child: Text("Informations ",
        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
        ),
      const  SizedBox(height: 15,),
      Center(
        child: Row(children: [
        const  Text('Beneficiaire',style:  TextStyle(fontSize: 18)),
       const   SizedBox(width: 10,),
          Text(data['receveur']['prenom'] +" "+  data['receveur']['nom'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
        ]),
      ),
   const  SizedBox(height: 15,),
      Center(
        child: Row(children: [
        const  Text('Tel du beneficiaire',style:  TextStyle(fontSize: 18)),
        const  SizedBox(width: 10,),
          Text(data['receveur']['phone'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
        ]),
      ),
    const  SizedBox(height: 15,),
      Center(
        child: Row(children: [
         const Text('Montant à envoyer',style:  TextStyle(fontSize: 18)),
        const  SizedBox(width: 10,),
          Text(data['transaction']['somme']+" CFA",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
        ]),
      ),
    const  SizedBox(height: 15,),
      Center(
        child: Row(children: [
        const   Text('Commission',style:  TextStyle(fontSize: 18)),
        const  SizedBox(width: 10,),
          Text(data['transaction']['commission']+ " "+ 'CFA',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
        ]),
      ),
     const  SizedBox(height: 15,),
      Center(
        child: Row(children: [
        const  Text('Total de la transaction',style:  TextStyle(fontSize: 18)),
        const  SizedBox(width: 10,),
          Text(data['transaction']['total']+ " "+ 'CFA' ,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18) )
        ]),
      ),
     const SizedBox(height: 15,),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
           style: ButtonStyle(
           backgroundColor: MaterialStateProperty.all(const  Color.fromRGBO(75, 0, 130, 1),),
           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
           RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(100.0),
           // side: BorderSide(color: Colors.red)
     )
  )
),
          child: const Text('Confirmer'),
        onPressed: (){
          confirmation(context);
        }),
      )
    
      ]) ,
      ),)
     );
  }
  else{
    return EnvoiAnimate();
  }
    
}

}