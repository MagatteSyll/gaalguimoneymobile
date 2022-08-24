import 'package:flutter/material.dart';





class ForBusiness extends StatefulWidget {
  const ForBusiness({Key? key}) : super(key: key);

  @override
  State<ForBusiness> createState() => _ForBusinessState();
}

class _ForBusinessState extends State<ForBusiness> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon:Icon(Icons.arrow_back_ios_new,color: Colors.grey,)),
      ),
     body: Container(
       margin: EdgeInsets.only(top: 20,left: 20,right: 5),
       child: Column(children: [
         Container(
           margin: EdgeInsets.only(left: 5),
           child: Card(clipBehavior: Clip.hardEdge,
           elevation: 5,
           child: Column(children:[
             Text("Vous avez un business?",
             style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold,fontSize:24),),
             SizedBox(height: 10,),
             Container(
               margin: EdgeInsets.all(5),
               child: Text
("GaalguiMoney vous propose des comptes speciaux destinés à vous rapprocher de vos clients et de vos partenaires .En un simple click, vos clients peuvent payer leurs services et cela sans frais ",
   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize:16) ),
             )
            
           ])
           )
           ,
         ),
        Container(
           margin: EdgeInsets.only(left: 5),
           child: Card(clipBehavior: Clip.hardEdge,
           elevation: 5,
           child: Column(children:[
             Text(" Vous avez une grande entreprise ?",
             style: TextStyle(color: Color.fromRGBO(230, 20, 202, 0.4), fontWeight: FontWeight.bold,fontSize:24),),
             SizedBox(height: 10,),
             Container(
               margin: EdgeInsets.all(5),
               child: Text
      ("GaalguiMoney vous offre la possibilité d avoir votre propre calpé sur la plateforme où vos cients peuvent payer n importe lequel de vos services en un rien de temps",
   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize:16) ),
             )
           ])
           ) ,
         ),
      Container(
        margin: EdgeInsets.only(left: 10,top: 22),
        child: Column(children: [
          Text("Pour plus de renseignment ,contactez le service client ",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize:16)),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Row(children: [
              Icon(Icons.phone),
              SizedBox(width: 15,),
              Text("339674236",style: TextStyle(color: Colors.red,fontSize:16),),
               SizedBox(width: 15,),
              Text("-",style: TextStyle(fontSize:16),),
              SizedBox(width: 15,),
              Text("339674236",style: TextStyle(color: Colors.red,fontSize:16),),
               ]),
          ),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Row(children: [
          Icon(Icons.mail,),
          SizedBox(width: 15,),
          Text("gaalguimoney@gmail.com",style: TextStyle(color: Colors.red,fontSize:16),),
          ]),

        )
        

        ]),
      )
       ]),
     ),
    );
    
  }
}