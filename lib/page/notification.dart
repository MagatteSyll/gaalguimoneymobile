// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:gaalguimoney/page/souscomponent/animationload.dart';
import '../../apiservice.dart';
import 'dart:convert' as convert;
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';




class NotificationUser extends StatefulWidget {
  const NotificationUser({super.key});

  @override
  State<NotificationUser> createState() => _NotificationUserState();
}

class _NotificationUserState extends State<NotificationUser> {
 List<Map<String, dynamic>> notif=[] ;
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
 var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/getnotification/',);
 var response=await  httpIns.get(url);
 if(response.statusCode==200){
  //print(response.body); 
  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic> ;
   setState(() {
  for(var i=0;i<jsonResponse['results'].length;i++){
     notif.add(jsonResponse['results'][i]);
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
      message:"Requete refusée!",),
     //  persistent: true,
        );
 }
  }  
 }
 Future getotherhistorique()async{
  setState(() {
  load=true;
    });
   var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/getnotification/?page=$page',);
 var response=await  httpIns.get(url);
 if(response.statusCode==200){
  //print(response.body); 
  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic> ;
   setState(() {
  for(var i=0;i<jsonResponse['results'].length;i++){
     notif.add(jsonResponse['results'][i]);
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
    return loaded? Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        automaticallyImplyLeading: false,
        leading: IconButton(icon:const Icon(Icons.arrow_back_ios,color: Colors.black,),
        onPressed: () {
          Navigator.of(context).pop();
        },
        ), 
        title: const Text("Notifications",style: TextStyle(
          color: Colors.black
        ),),),
        body: Container(
           margin: const  EdgeInsets.only(top: 15,left:15),
         child: Stack(
         children: [
            ListView.builder(
            controller: scrollController,  
            scrollDirection: Axis.vertical,
            itemCount: notif.length,
            itemBuilder: (context, index) {
            final item = notif[index];
            handleTap(){
          if(notif[index]['nature_transaction']=="depot"){
          Navigator.of(context).pushNamed('/historiqueonedepot',arguments:notif[index]['id']);
            }
            if(notif[index]['nature_transaction']=="retrait"){
            Navigator.of(context).pushNamed('/historiqueoneretrait',arguments:notif[index]['id']);
            }
            if(notif[index]['nature_transaction']=="reception"){
            Navigator.of(context).pushNamed('/historiqueonereception',arguments:notif[index]['id']);
            }
            if(notif[index]['nature_transaction']=="payement"){
            Navigator.of(context).pushNamed('/historiqueonepayement',arguments:notif[index]['id']); 
            }
            if(notif[index]['nature_transaction']=="annulation commande"){
            Navigator.of(context).pushNamed('/annulationcommandegaalguishop',arguments:notif[index]['id']); 
            }
            if(notif[index]['nature_transaction']=="activation compte"){

            }
            if(notif[index]['nature_transaction']=="code"){
              
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
        
         ),
    ): const AnimatedLoad();
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

  