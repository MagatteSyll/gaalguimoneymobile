import 'package:flutter/material.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;
import 'package:intl/intl.dart';
import 'package:gaalguimoney/page/souscomponent/animationload.dart';


class RecuDirect extends StatefulWidget {
 // const RecuDirect({ Key? key }) : super(key: key);
   final dynamic id;
   RecuDirect(@required this.id);
  @override
  State<RecuDirect> createState() => _RecuDirectState();
}

class _RecuDirectState extends State<RecuDirect> {
  var httpIns=HttpInstance();
  late var montant;
  late var date;
  late var beneficiaire;
  late var commission;
  late var total;
  bool load=false;

  Future getenvoi()async{
  var id=convert.jsonEncode(widget.id);
   var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/recudirect/',);
   var response=await  httpIns.post(url,body: {'id':id});
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    //Navigator.of(context).pushNamed("/confirmationenvoi",arguments:jsonResponse['id']);
    return jsonResponse;
  }
  else {
   print(response.body);
 }
  }
@override
void initState(){
getenvoi().then((res) => 
 setState(()=>{
  beneficiaire=res['receveur']['prenom']+ " "+ res['receveur']['nom'],
  montant=res['envoi']['somme'],
  commission=res['envoi']['commission'],
  date=res['envoi']['created'],
  //total=res['envoi']['total'],
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
           Text('Envoi direct GaalguiMoney')
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
      margin:EdgeInsets.only(top: 15,right: 5,left:5) ,
       child:Column(children: [
        ListTile(
          title: Text("logo"),
        ),
        SizedBox(height: 15,),
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