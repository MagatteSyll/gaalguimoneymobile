import 'package:flutter/material.dart';
import '../apiservice.dart';
import 'dart:convert' as convert;
import 'package:intl/intl.dart';




class NotificationProfessionnel extends StatefulWidget {
  //const NotificationProfessionnel({Key? key}) : super(key: key);

  @override
  State<NotificationProfessionnel> createState() => _NotificationProfessionnelState();
}

class _NotificationProfessionnelState extends State<NotificationProfessionnel> {
   List<Map<String, dynamic>> historibusiness=[] ;
   bool load =false;
   var httpIns=HttpInstance();

  Future gethistoribusinees() async{
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/pay/getpayementprofessionnel/',);
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
 Future handlerelever(identifiant) async{
  var id=convert.jsonEncode(identifiant);
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/pay/releverprofessionnel/',);
  var response=await  httpIns.post(url,body: {'id':id});
  if (response.statusCode == 200) {
    Navigator.of(context).pushNamed("/notificationprofessionnel");
  }
  else {
   print(response.statusCode);
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
      handleTap(){
      Navigator.of(context).pushNamed('/detailnotificationprofessionnel',arguments:item['id']);
      }
      return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child:Container(
      decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, .9)),
      child: ListTileMessage(item,handlerelever),
         
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

Widget ListTileMessage(item,handlerelever){
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
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            SizedBox(width: 25,),
            IconButton(
              onPressed: (){
                handlerelever(item['id']);
              },
              icon:Icon(Icons.toggle_on),
              iconSize: 50,
              color: Colors.purple,
              
              )
          ],
        ),
        trailing:  Icon(Icons.keyboard_arrow_right, color: Colors.black,),
        
            
          );
            

}