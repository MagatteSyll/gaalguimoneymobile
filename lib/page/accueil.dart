// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gaalguimoney/page/souscomponent/animationload.dart';
import './souscomponent/historique.dart';
import '../apiservice.dart';
import 'package:flutter/services.dart';
import 'dart:convert' as convert;
import './souscomponent/parametres.dart';
import './souscomponent/home.dart';
import './souscomponent//transaction.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:badges/badges.dart';






class Accueil extends StatefulWidget {
  const Accueil({super.key});

  //const Accueil({ Key? key }) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  bool payload=false;
  bool islog=false;
  bool loaded=false;
  bool business =false;
  bool professionnel=false;
  bool documentverif=false;
   var prenom="";
   var nom="";
   var solde="";
   var phone;
   var badge=0;
   var qrcode;
  

 var httpIns=HttpInstance();
  static const platform =  MethodChannel("flutter.native.com/auth");
 
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  deconnexion() async{
  await platform.invokeMethod("simpledeconnexion");
}


  
Future getuser() async{
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/getuser/',);
  var result=await  httpIns.get(url);
 if(result.statusCode==200){
   var response=convert.jsonDecode(result.body);
   return response;
 }
 else{
  
 }
}

Future getqrcode()async{
   var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/getuserqrcode/',);
  var result=await  httpIns.get(url);
 if(result.statusCode==200){
  var jsonResponse=convert.jsonDecode(result.body) as Map<String, dynamic> ;
  setState(() {
    qrcode=jsonResponse['qrcode'];
  });
 }
 else{
  
 }
}


 Future<bool> getislog()  async{
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/islog/',);
  var result=await  httpIns.get(url);
 if(result.statusCode!=200){
    await deconnexion();
   return false;
 }
 else{
var  jsonResponse = convert.jsonDecode(result.body);
return jsonResponse;
 }
}
 Future getphone()async{
  return await platform.invokeMethod('getphone');
 }
 Future getbadgenotif()async{
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/getbadgenotif/',);
  var result=await  httpIns.get(url);
 if(result.statusCode==200){
   var response=convert.jsonDecode(result.body) as Map<String, dynamic> ;
   setState(() {
     badge=response['badge'];
   });
 }
 else{
  
 }
 }
  @override
  void initState() {
    super.initState();
    getphone().then((value) => setState((() {
     phone=value; 
    })));
   getislog().then((res) => 
    setState(()=>{
      islog=res,
      if(res==true){
      getuser().then((res) =>
      setState(()=>{
       prenom=res['prenom'],
       nom=res['nom'],
       solde=res['solde'],
       business=res['business'],
       professionnel=res['professionnel'],
       documentverif=res['document_verif'],
       loaded=true
       })),
       getbadgenotif()
      }
    else{
      setState(()=>{
        loaded=true
      })
    }}));
  
  
 }

  envoiqrcode(context) async{
     try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#028A0F',
        'Annuler',
        true,
        ScanMode.QR,
      );

  if (!mounted) return;
  //print(qrCode);
  var url=Uri.parse('http://gaalguimoney.herokuapp.com/api/client/qrcodeenvoiverification/',);
  var result=await  httpIns.post(url,body: {'slug':qrCode});
 if(result.statusCode==200){
   print(result.body);
   var response=convert.jsonDecode(result.body);
   Navigator.of(context).pushNamed('/confirmationsommenvoidirect',arguments:response['phone']);
 }
 else{
  print(result.statusCode);
  showTopSnackBar(
     context,
     const CustomSnackBar.error(
      message:"Erreur!Payement impossible!",),
     //  persistent: true,
    );
 }
}
     on PlatformException {
     showTopSnackBar(
     context,
     const CustomSnackBar.error(
      message:"Erreur!",),
     //  persistent: true,
    );
    }
  }


Future handleopennotif(context)async{
 if(badge>0){
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/client/usereadnotif/',);
  var result=await  httpIns.get(url,);
 if(result.statusCode==200){
    await getbadgenotif();
   Navigator.of(context).pushNamed('/notification',);
 }
 }
 else{
 Navigator.of(context).pushNamed('/notification',);
 }
}

  @override
  Widget build(BuildContext context) {
   
   if(loaded){
     return myAccueilWidget(islog, context, _selectedIndex, _onItemTapped,prenom,nom,solde,
     business,professionnel,documentverif,phone,badge,handleopennotif,envoiqrcode);
   }
  else{
    return const  AnimatedLoad();
  }
}}

Widget myAccueilWidget(islog, context, _selectedIndex, _onItemTapped,prenom,nom,solde,
     business,professionnel,documentverif,phone,badge,handleopennotif,envoiqrcode){
  final List<Widget>_tabcomponent=[
    myBodyWidget(prenom,nom,solde,context,documentverif),
    myTransactionWidget(context,envoiqrcode),
    const Historique(),
   const Parametre(), 
  ];
  if(islog==true){
      return  Scaffold(
       appBar: AppBar(
     backgroundColor:const Color.fromRGBO(255, 255, 255,1),
     elevation: 0,
     automaticallyImplyLeading: false,
       title: ListTile(
      leading: const Icon(
      Icons.search,
       color: Colors.black,
      size: 28,
   ), title: const  TextField(
     decoration: InputDecoration(labelText: "Recherche",
      border: InputBorder.none,
     
  ),
  style: TextStyle(color: Colors.black),
   ),
  trailing:MyTrailing(context,business,professionnel,badge,handleopennotif),
      ),),
       body:_tabcomponent[_selectedIndex],
       bottomNavigationBar: BottomNavigationBar(
       type: BottomNavigationBarType.fixed,
       iconSize: 20,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.refresh),
            label: 'Historiques',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Parametres',
            
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:const Color.fromRGBO(75, 0, 130, 1),
        onTap: _onItemTapped,
      ),
    );
    } 
    else{
     Future.delayed(Duration.zero,(){
     if(phone=="pas de phone"){
      Navigator.of(context).pushNamedAndRemoveUntil('/connexion', (Route route) => false);
     }
   else{
  Navigator.of(context).pushNamedAndRemoveUntil('/simplelogin', (Route route) => false);
     }
     
     }) ;
      return Container();
    }
}


// ignore: non_constant_identifier_names
Widget MyTrailing(context,business,professionnel,badge,handleopennotif){
 /* if(business){
     return  IconButton(
   icon: const Icon(Icons.notifications),
    color: Colors.black,
    onPressed: () {
    Navigator.of(context).pushNamed('/notificationbusiness');
    },
     );
    }
  if(professionnel){
    return  IconButton(
   icon: const Icon(Icons.notifications),
    color: Colors.black,
    onPressed: () {
    Navigator.of(context).pushNamed('/notificationprofessionnel');
    },
     );}
  else{*/
    return  badge==0?IconButton(
    onPressed: (){
      handleopennotif(context);
    }, 
    icon:const Icon(Icons.notifications),
    color: Colors.black,
    
    ):GestureDetector(
        onTap: (){ 
        handleopennotif(context);
        },
        child: Badge(
          elevation: 0,
          alignment: Alignment.topLeft,
          badgeContent: Text('$badge',style: const TextStyle(color:Colors.white)),
          child: const  Icon(Icons.notifications,color: Colors.black,size: 30,),
           )
      );
  }


