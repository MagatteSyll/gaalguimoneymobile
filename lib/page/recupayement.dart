import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import '../apiservice.dart';
import 'package:intl/intl.dart';
import 'package:gaalguimoney/page/souscomponent/animationload.dart';




class RecuPayement extends StatefulWidget {
  final dynamic id;
  const RecuPayement(@required this.id);

  @override
  State<RecuPayement> createState() => _RecuPayementState();
}

class _RecuPayementState extends State<RecuPayement> {
   bool loaded=false;
  var httpIns=HttpInstance();
  late var nom;
  late var logo;
  late var total;
  late var montant;
  late var commission;
  late var date;

  Future getpayement() async{
  var id=convert.jsonEncode(widget.id);
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/pay/getbusinesspayement/',);
  var result=await  httpIns.post(url,body: {'id':id});
 if(result.statusCode==200){
   var response=convert.jsonDecode(result.body);
   return response;
 }
 else{
  print(result.body);
 }
}
void initState() {
    getpayement()
    .then((res) => 
     setState(()=>{
       nom=res['business']['nom'],
       logo=res['business']['logo'],
       montant=res['somme'],
       total=res['total'],
       commission=res['commission'],
       date=res['created']
       ,
       loaded=true

     })
    );
    super.initState();
    }
  @override
  Widget build(BuildContext context) {
  
   if(loaded){
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
           Text(nom)
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
         Text("Entreprise",style: const TextStyle(fontSize: 18)),
         SizedBox(width: 10,),
         Text(nom,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),

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
       Text('Le',
       style: const TextStyle(fontSize: 18)), 
          SizedBox(width: 10,),
      Text(formatted+","+heuresting,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
      
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
