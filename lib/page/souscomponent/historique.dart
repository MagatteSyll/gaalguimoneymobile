import 'package:flutter/material.dart';
import 'package:gaalguimoney/page/souscomponent/animationload.dart';
import '../../apiservice.dart';
import 'dart:convert' as convert;
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';



class Historique extends StatefulWidget {
  const Historique({ Key? key }) : super(key: key);

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  int segmentedControlGroupValue = 0;
 List<Map<String, dynamic>> histo=[] ;
 var httpIns=HttpInstance();
 bool load=false;

 Future gethistorique() async{
 var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/message/',);
 var response=await  httpIns.get(url);
 if(response.statusCode==200){
   var jsonresponse=convert.jsonDecode(response.body);
   return jsonresponse;
 }
 else{
    showTopSnackBar(
      context,
      CustomSnackBar.error(
      message:"Requete refusee!",),
     //  persistent: true,
        );
 }
   
 }
 @override
  void initState() {
    gethistorique().then((res) => 
    setState(()=>{
    for(var i=0;i<res.length;i++){
     histo.add(res[i])
    },
    load=true
    })
    );
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    if(load==true){
      if(histo.length>0){
       return Scaffold(
         body: Container(
           margin: EdgeInsets.only(top: 35,left:15),
         child: ListView.builder(
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
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child:Container(
      decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, .9)),
      child: ListTileMessage(item,handleTap),
         
      )
       ,
    );
  }, 
)
)
 );
     }
     else{
       return Scaffold(
         body: Center(child: Text("Aucune transaction")),
       );
     }
   }
  else{
   return HistoriqueAnimate();
  }
   }
}


Widget ListTileMessage(item,handleTap){
    String date=item['created'];
    final  formattedDate =DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final heure=DateFormat('HH:mm');
    final String formatted = formatter.format(formattedDate);
     String heuresting=heure.format(formattedDate);
    
  return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
       // leading: img (logo pour les transferts et logo entreprise pour les payements)
        title: Text(
         item['message']
          ,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Icon(Icons.alarm,color: Colors.pink,),
            Text(formatted+","+heuresting,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          ],
        ),
        trailing:  Icon(Icons.keyboard_arrow_right, color: Colors.black,),
        onTap:handleTap
            
          );
            

}


