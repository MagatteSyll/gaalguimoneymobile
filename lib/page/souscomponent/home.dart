import 'package:flutter/material.dart';




Widget myBodyWidget(prenom,nom,solde,context,documentverif){
 
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
                   margin:const EdgeInsets.all(20),
                   width: 200,
                  // height: 00,
                   child: Card(
                     child: Container(
                       padding:const EdgeInsets.all(5) ,
                       child: Column(children: [
                        const FittedBox(
                        fit: BoxFit.contain,
                        child: Text("Compte",
                        style: TextStyle(color: Color.fromARGB(255, 8, 42, 233),
                          fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 15,),
                        Row
                        (children:[
                          const Icon(Icons.account_circle),
                          const SizedBox(width: 5,),
                          Text(prenom+" "+ nom),
                        ]),
                        const SizedBox(height: 15,),
                        Row(children: [
                         const Text("solde"),
                         const SizedBox(width: 5,),
                         Text(solde,
                          style: const TextStyle(color: Color.fromARGB(255, 218, 7, 147),
                          fontWeight: FontWeight.bold)
                         ),
                         const SizedBox(width: 5,),
                          const Text("CFA")
                        ],),
                       ]),
                     ),
                   ),
                 ),
                 Container(
                   margin:const EdgeInsets.all(20),
                   width: 200,
                  // height: 100,
                   child: Card(
                     child: Container(
                       padding: const EdgeInsets.all(15),
                       child: Column(children: [
                           const FittedBox(
                        fit: BoxFit.contain,
                        child: Text("Taux d echange en CFA",
                        style: TextStyle(color: Color.fromARGB(255, 8, 42, 233),
                          fontWeight: FontWeight.bold)
                        ),),
                        const SizedBox(height: 15,),
                        Row(
                        children:const [
                        Text('Dollar',),
                        SizedBox(width: 5,),
                        Text("450", style: TextStyle(color: Color.fromARGB(255, 223, 9, 9),
                          fontWeight: FontWeight.bold))
                          ],
                        ),
                       const SizedBox(height: 15,),
                        Row(
                        children: const [
                        Text('Euro',),
                        SizedBox(width: 5,),
                        Text("650", style: TextStyle(color: Color.fromARGB(255, 223, 9, 9),
                          fontWeight: FontWeight.bold))
                        ],
                        ),
                       const SizedBox(height: 15,),
                        Row(
                        children: const [
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
         const SizedBox(height: 20.0),
          Card( 
            elevation: 5, 
            child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            padding: const EdgeInsets.all(10),
            child: Column(children: [
            const Text("Nos point d acces ", style: TextStyle(color: Color.fromARGB(254,
             90,80, 0),
           fontWeight: FontWeight.bold)),
             IconButton(onPressed: (){
               Navigator.of(context).pushNamed('/pointacces');
               
             },
             iconSize: 36,
             color: Colors.purple,
             icon:const Icon(Icons.location_on))
            ]), ),),
         const SizedBox(height: 25,),
         
          Container(
          margin:const  EdgeInsets.only(top: 20),
         child: Column(
         children: [
        const ListTile
        (title:Text("Mon qr-code",
        style: TextStyle(color: Colors.brown),)),
       const   SizedBox(height: 5.0), 
         SizedBox(
         height: 50.0,
         width: 150.0,
         child:  IconButton(
        color:   Colors.green,
         padding: const  EdgeInsets.all(0.0),
        icon: const 
         Icon(Icons.qr_code ,size: 50.0),
       onPressed:() { 
       Navigator.of(context).pushNamed('/qrcodeuser');
      
        } ,)
  ),],),),
   const SizedBox(height: 25,),
    FittedBox(
           fit: BoxFit.contain,
          child: Container(
            margin: const EdgeInsets.only(top: 15,bottom: 5),
            padding: const EdgeInsets.only(left: 15),
            child: const Text("Services",
            style: TextStyle(color: Color.fromARGB(255, 8, 42, 233),
            fontWeight: FontWeight.bold)
            ),
          ),),
          Column(
            children: [
              Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                     child: Container(
                       padding: const EdgeInsets.all(10),
                       child: Column(children: [
                         const Text("GaalguiMoneyBusiness", style: TextStyle(color: Color.fromARGB(255, 223, 9, 9),
                          fontWeight: FontWeight.bold)),
                        IconButton(onPressed: (){
                       Navigator.of(context).pushNamed('/gaalguimoneybusiness');
                        },
                        iconSize: 36,
                        color: Colors.deepPurple,
                        icon:const Icon(Icons.money))
                        
                       ]),
                     ),
                   ),
                   Card(
                     child: Container(
                       padding: const EdgeInsets.all(10),
                       child: Column(children: [
                         const Text("Devenir Partenaire", style: TextStyle(color: Color.fromARGB(255, 223, 9, 9),
                          fontWeight: FontWeight.bold)),
                        IconButton(onPressed: (){
                        Navigator.of(context).pushNamed('/partenaire');
                        },
                        iconSize: 36,
                        color: Colors.green,
                        icon:const Icon(Icons.business),)
                        
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
  const Actif(this.actif, {super.key});

  @override
  Widget build(BuildContext context) {
    if(!actif){
     return const ListTile(
       title: Text("Rendez vous avec vos documents(piece d identite ou passport) au point d acces le plus proche pour activer votre compte",
       style: TextStyle(color: Colors.red),),
     );
    }
    else{
      return Container();
    }
  }
}


