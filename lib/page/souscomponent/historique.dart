// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:gaalguimoney/page/souscomponent/animationload.dart';
import '../../apiservice.dart';
import 'dart:convert' as convert;
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Historique extends StatefulWidget {
  const Historique({ Key? key }) : super(key: key);

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
 List<Map<String, dynamic>> histo=[] ;
 var httpIns=HttpInstance();
  ScrollController scrollController=ScrollController();
 bool load=false;
 int page=1;
 var next;
 var previous;
 bool loaded=false;

 Future gethistorique() async{
  if(previous==null){
    setState(() {
      load=true;
    });
 var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/message/',);
 var response=await  httpIns.get(url);
 if(response.statusCode==200){
  //print(response.body); 
  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic> ;
   setState(() {
  for(var i=0;i<jsonResponse['results'].length;i++){
     histo.add(jsonResponse['results'][i]);
      }
    next=jsonResponse['next'];
     page++;
     previous=jsonResponse['previous'];
    load=false;
    });
   return ;}
 
 else{
    // ignore: use_build_context_synchronously
    showTopSnackBar(
      context,
      const CustomSnackBar.error(
      message:"Requete refusee!",),
     //  persistent: true,
        );
 }
  }  
 }
 Future getotherhistorique()async{
  setState(() {
  load=true;
    });
   var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/message/?page=$page',);
 var response=await  httpIns.get(url);
 if(response.statusCode==200){
  //print(response.body); 
  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic> ;
   setState(() {
  for(var i=0;i<jsonResponse['results'].length;i++){
     histo.add(jsonResponse['results'][i]);
      }
    next=jsonResponse['next'];
     page++;
     previous=jsonResponse['previous'];
    load=false;
    });
   return ;}
}
 @override
  void initState() {
    gethistorique(); 
    setState(()=>{
    loaded=true
    });
     scrollController.addListener(() {
    if(scrollController.position.maxScrollExtent==scrollController.offset && !load){
     if(next!=null){
     getotherhistorique();}
     else{
       setState(() {
         load=false;
       });
     }
     }});
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    if(loaded==true){
      if(histo.isNotEmpty){
       return Scaffold(
         body: Container(
           margin: const  EdgeInsets.only(top: 15,left:15),
         child: Stack(
           children: [
             ListView.builder(
             controller: scrollController,  
        scrollDirection: Axis.vertical,
        itemCount: histo.length,
             itemBuilder: (context, index) {
      final item = histo[index];
      handleTap(){
  if(histo[index]['nature_transaction']=="envoi direct"){
    Navigator.of(context).pushNamed('/historiqueonedirect',arguments:histo[index]['id']);
   }
  if(histo[index]['nature_transaction']=="envoi via code"){
  Navigator.of(context).pushNamed('/historiqueonecode',arguments:histo[index]['id']);
  }
 if(histo[index]['nature_transaction']=="depot"){
 Navigator.of(context).pushNamed('/historiqueonedepot',arguments:histo[index]['id']);
 }
 if(histo[index]['nature_transaction']=="retrait"){
Navigator.of(context).pushNamed('/historiqueoneretrait',arguments:histo[index]['id']);
 }
 if(histo[index]['nature_transaction']=="reception"){
  Navigator.of(context).pushNamed('/historiqueonereception',arguments:histo[index]['id']);
 }
 if(histo[index]['nature_transaction']=="payement"){
  Navigator.of(context).pushNamed('/historiqueonepayement',arguments:histo[index]['id']); 
 }
 if(histo[index]['nature_transaction']=="annulation commande"){
 Navigator.of(context).pushNamed('/annulationcommandegaalguishop',arguments:histo[index]['id']); 
}
if(histo[index]['nature_transaction']=="activation compte"){
 
}
}
    return Card(
      shadowColor: Colors.grey,
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child:Container(
      decoration: const  BoxDecoration(color: Color.fromRGBO(255, 255, 255, .9)),
      child: listTileMessage(item,handleTap),
       )
       ,  ); }, ),
        if(load)...const [
                 Positioned(
                left:130,
                bottom: 0,
                child: Center(
                child:  Produitloadanimate(),
              ))]

           ]),
        
         )
    );
     }
     else{
       return const Scaffold(
         body:Center(child: Text(" Oups vous n avez  effectue aucune transaction")),
       );
     }
   }
  else{
   return HistoriqueAnimate();
  }
   }
}

Widget listTileMessage(item,handleTap){
    String date=item['created'];
    final  formattedDate =DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final heure=DateFormat('HH:mm');
    final String formatted = formatter.format(formattedDate);
     String heuresting=heure.format(formattedDate);
    
  return ListTile(
        contentPadding:const  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
       // leading: img (logo pour les transferts et logo entreprise pour les payements)
        title: Text(
         item['message']
          ,
          style: const  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
          const   Icon(Icons.alarm,color: Color.fromRGBO(75,0,130,1),),
            Text("$formatted,$heuresting",
            style:const  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          ],
        ),
        trailing: const  Icon(Icons.keyboard_arrow_right, color: Colors.black,),
        onTap:handleTap
            
          );
            

}

class Produitloadanimate extends StatelessWidget {
  const Produitloadanimate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     decoration: const BoxDecoration(color: Colors.white),
     child: const  SpinKitFadingCircle(
     color: Color.fromARGB(137, 18, 35, 92),
     size: 30.0,
     duration: Duration(milliseconds: 1000),
)
    );
    
  }
}
class Loadinganimate extends StatelessWidget {
  const Loadinganimate({super.key});

  @override
  Widget build(BuildContext context) {
     return Container(
     decoration: const BoxDecoration(color: Colors.white),
     child: const  SpinKitCircle(
     color: Color.fromARGB(137, 18, 35, 92),
     size: 50.0,
     duration: Duration(milliseconds: 1000),
)
    );
    
  }
}

