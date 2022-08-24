import 'package:flutter/material.dart';
import '../../apiservice.dart';



Widget MyBodyWidget(prenom,nom,solde,context,documentverif){
  return SingleChildScrollView(
    child: Wrap(
       // direction: Axis.horizontal,
        children: [
         Column(
           children: [
             Actif(documentverif),
             Container(
              height: 200,
               child:
             ListView(
              scrollDirection: Axis.horizontal,
               children: [
                 Container(
                   margin:EdgeInsets.all(20),
                   width: 200,
                  // height: 00,
                   child: Card(
                     child: Container(
                       padding:EdgeInsets.all(5) ,
                       child: Column(children: [
                        FittedBox(
                        fit: BoxFit.contain,
                        child: Text("Compte",
                        style: TextStyle(color: Color.fromARGB(255, 8, 42, 233),
                          fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 15,),
                        Row
                        (children:[
                          Icon(Icons.person_rounded),
                          SizedBox(width: 5,),
                          Text(prenom+" "+ nom),
                        ]),
                        SizedBox(height: 15,),
                        Row(children: [
                         Text("solde"),
                         SizedBox(width: 5,),
                         Text(solde,
                          style: TextStyle(color: Color.fromARGB(255, 218, 7, 147),
                          fontWeight: FontWeight.bold)
                         ),
                         SizedBox(width: 5,),
                          Text("CFA")
                        ],),
                       ]),
                     ),
                   ),
                 ),
                 Container(
                   margin:EdgeInsets.all(20),
                   width: 200,
                  // height: 100,
                   child: Card(
                     child: Container(
                       padding: EdgeInsets.all(15),
                       child: Column(children: [
                           FittedBox(
                        fit: BoxFit.contain,
                        child: Text("Taux d echange en CFA",
                        style: TextStyle(color: Color.fromARGB(255, 8, 42, 233),
                          fontWeight: FontWeight.bold)
                        ),),
                        SizedBox(height: 15,),
                        Row(
                        children: [
                        Text('Dollar',),
                        SizedBox(width: 5,),
                        Text("450", style: TextStyle(color: Color.fromARGB(255, 223, 9, 9),
                          fontWeight: FontWeight.bold))
                          ],
                        ),
                       SizedBox(height: 15,),
                        Row(
                        children: [
                        Text('Euro',),
                        SizedBox(width: 5,),
                        Text("650", style: TextStyle(color: Color.fromARGB(255, 223, 9, 9),
                          fontWeight: FontWeight.bold))
                        ],
                        ),
                       SizedBox(height: 15,),
                        Row(
                        children: [
                        Text('Naira',),
                        SizedBox(width: 5,),
                        Text("1.48", style: TextStyle(color: Color.fromARGB(255, 223, 9, 9),
                          fontWeight: FontWeight.bold))
                          ],
                        ),
                       ]),
                     ),
                   ),
                 ),
              ],
             )),
           ],
         ),
         SizedBox(height: 20.0),
          Card( 
            elevation: 5, 
            child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            padding: EdgeInsets.all(10),
            child: Column(children: [
            Text("Nos point d acces ", style: TextStyle(color: Color.fromARGB(254,
             90,80, 0),
           fontWeight: FontWeight.bold)),
             IconButton(onPressed: (){
               Navigator.of(context).pushNamed('/pointacces');
               
             },
             iconSize: 36,
             color: Colors.purple,
             icon:Icon(Icons.location_on))
            ]), ),),
         SizedBox(height: 25,),
          FittedBox(
           fit: BoxFit.contain,
          child: Container(
            margin: EdgeInsets.only(top: 15,bottom: 5),
            padding: EdgeInsets.only(left: 15),
            child: Text("Services",
            style: TextStyle(color: Color.fromARGB(255, 8, 42, 233),
            fontWeight: FontWeight.bold)
            ),
          ),),
          SizedBox(height: 25,),
          Column(
            children: [
              Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                     child: Container(
                       padding: EdgeInsets.all(10),
                       child: Column(children: [
                         Text("GaalguiMoneyBusiness", style: TextStyle(color: Color.fromARGB(255, 223, 9, 9),
                          fontWeight: FontWeight.bold)),
                        IconButton(onPressed: (){
                       Navigator.of(context).pushNamed('/gaalguimoneybusiness');
                        },
                        iconSize: 36,
                        color: Colors.deepPurple,
                        icon:Icon(Icons.money))
                        
                       ]),
                     ),
                   ),
                   Card(
                     child: Container(
                       padding: EdgeInsets.all(10),
                       child: Column(children: [
                         Text("Devenir Partenaire", style: TextStyle(color: Color.fromARGB(255, 223, 9, 9),
                          fontWeight: FontWeight.bold)),
                        IconButton(onPressed: (){
                        Navigator.of(context).pushNamed('/partenaire');
                        },
                        iconSize: 36,
                        color: Colors.green,
                        icon:Icon(Icons.business),)
                        
                       ]),
                     ),
                   ),
                   
                  ],
                ),
              )
            ],
          ),
       //   SizedBox(height: 20,),
         // Pay(pay)

        ],
      ),
  );
}

class Actif extends StatelessWidget {
  final dynamic actif;
  const Actif(@required this.actif);

  @override
  Widget build(BuildContext context) {
    if(!actif){
     return ListTile(
       title: Text("Rendez vous avec vos documents(piece d identite ou passport) au point d acces le plus proche pour activer votre compte",
       style: TextStyle(color: Colors.red),),
     );
    }
    else{
      return Container();
    }
  }
}


