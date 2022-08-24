import 'package:flutter/material.dart';


class PointAcces extends StatefulWidget {
  const PointAcces({Key? key}) : super(key: key);

  @override
  State<PointAcces> createState() => _PointAccesState();
}

class _PointAccesState extends State<PointAcces> {
  @override
  Widget build(BuildContext context) {
  return  Scaffold(
    appBar: AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: IconButton(onPressed: (){
    Navigator.of(context).pop();
   }, icon:Icon(Icons.arrow_back_ios_new,color: Colors.grey,)),
   ),
   body: Container(
    margin: EdgeInsets.only(top: 20,left: 40),
    child:ListView.builder(
      itemCount:2,
      itemBuilder: (context,index){
     // itemCount: histo.length,

      return PointTile();
    }
    )
     
  )

   );
 
    
  }
}
Widget PointTile(){
  return Container(
  margin: EdgeInsets.only(bottom: 20),
  child: Container(
     child: Row(children: [
       Icon(Icons.location_on,color: Colors.red,),
       Text("Louga")
     ]),
  )
  );
}