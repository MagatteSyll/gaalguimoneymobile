import 'package:flutter/material.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;
import 'package:intl/intl.dart';


class NotificationBusiness extends StatefulWidget {
  

  @override
  State<NotificationBusiness> createState() => _NotificationBusinessState();
}

class _NotificationBusinessState extends State<NotificationBusiness> {
   List<Map<String, dynamic>> historibusiness=[] ;
   bool load =false;
   var httpIns=HttpInstance();

  Future gethistoribusinees() async{
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/pay/getpayementbusinessuser/',);
  var result=await  httpIns.get(url);
 if(result.statusCode==200){
   var jsonResponse = convert.jsonDecode(result.body);
  // print(jsonResponse);
   return jsonResponse;
 }
 else{
  print(result.body);
 return ;
 }
 }
 void initState() {
    super.initState();
     gethistoribusinees().then((res) => 
    setState(()=>{
    for(var i=0;i<res.length;i++){
     historibusiness.add(res[i])
    },
    load=true
    })
    );
    
    
  }
 
  @override
  Widget build(BuildContext context) {
    if(load){
      if(historibusiness.length>0){
        return Scaffold(
        appBar:AppBar(
         leading: IconButton(
        iconSize: 34,
        icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
          ),
        backgroundColor: Color.fromRGBO(175, 76, 153, 1),
        title: Center(child: Row(
          children: [
           Icon(Icons.luggage),
           Text('Transferts business')
          ],
        )),
        ),
         body: Container(
         margin: EdgeInsets.only(top: 35,left:15),
         child: ListView.builder(
        scrollDirection: Axis.vertical,
         itemCount: historibusiness.length,
      itemBuilder: (context, index) {
      final item = historibusiness[index];
      return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child:Container(
      decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, .9)),
      child: ListTileMessage(item),
         
      )
       ,
    );
  },
)

         )

       );

      }
    else{
     return Center(
      child: Text("Aucun transfert business"),
    );
    }

    }
  else{
    return Center(
      child: Text("loading"),
    );
  }
   
  }
}

Widget ListTileMessage(item,){
    String date=item['created'];
    final  formattedDate =DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final heure=DateFormat('HH:mm');
    final String formatted = formatter.format(formattedDate);
     String heuresting=heure.format(formattedDate);
  
 
    
  return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
       // leading: 
        title: Text(
         item['message']
          ,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Icon(Icons.alarm),
            Text(formatted+","+heuresting,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          ],
        ),
        trailing:  Icon(Icons.keyboard_arrow_right, color: Colors.black,),
            
          );
            

}