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






class Accueil extends StatefulWidget {
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
   
  

 var httpIns=HttpInstance();
  static const platform =  MethodChannel("flutter.native.com/auth");
 
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  deconnexion() async{
  await platform.invokeMethod("deconnexion");
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

  void initState() {
    super.initState();
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
       }))
      }
    else{
      setState(()=>{
        loaded=true
      })
    }}));
  
 }

  payementcodebusiness() async{
     try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#028A0F',
        'Annuler',
        true,
        ScanMode.QR,
      );

  if (!mounted) return;
  var url=Uri.parse('https://gaalguimoney.herokuapp.com/api/pay/verificationbusinesspayslug/',);
  var result=await  httpIns.post(url,body: {'slug':qrCode});
 if(result.statusCode==200){
   var response=convert.jsonDecode(result.body);
   Navigator.of(context).pushNamed('/payementqrcode',arguments:response['id']);
 }
 else{
  showTopSnackBar(
     context,
     CustomSnackBar.error(
      message:"Erreur!Payement impossible!",),
     //  persistent: true,
    );
 }
}
     on PlatformException {
     showTopSnackBar(
     context,
     CustomSnackBar.error(
      message:"Erreur!",),
     //  persistent: true,
    );
    }
  }



  @override
  Widget build(BuildContext context) {
   
   if(loaded){
     return MyAccueilWidget(islog, context, _selectedIndex, _onItemTapped,prenom,nom,solde,
     business,professionnel,payementcodebusiness,documentverif);
   }
  else{
    return AnimatedLoad();
  }
}}

Widget MyAccueilWidget(islog, context, _selectedIndex, _onItemTapped,prenom,nom,solde,
     business,professionnel,payementcodebusiness,documentverif){
  final List<Widget>_tabcomponent=[
    MyBodyWidget(prenom,nom,solde,context,documentverif),
    MyTransactionWidget(context,payementcodebusiness),
    Historique(),
    Parametre(), 
  ];
  if(islog==true){
      return  Scaffold(
       appBar: AppBar(
     backgroundColor: Color.fromARGB(102, 248, 15, 190),
     elevation: 0,
     automaticallyImplyLeading: false,
       title: ListTile(
      leading: Icon(
      Icons.search,
       color: Colors.white,
      size: 28,
   ), title: TextField(
     decoration: InputDecoration(labelText: "Recherche",
      border: InputBorder.none,),
     
   ),
  trailing:MyTrailing(context,business,professionnel),
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
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
    } 
    else{
     Future.delayed(Duration.zero,(){
      Navigator.of(context).pushNamed('/connexion');
     }) ;
      return Container();
    }
}


Widget MyTrailing(context,business,professionnel){
  if(business){
     return  IconButton(
   icon: const Icon(Icons.notifications),
    color: Colors.white,
    onPressed: () {
    Navigator.of(context).pushNamed('/notificationbusiness');
    },
     );
    }
  if(professionnel){
    return  IconButton(
   icon: const Icon(Icons.notifications),
    color: Colors.white,
    onPressed: () {
    Navigator.of(context).pushNamed('/notificationprofessionnel');
    },
     );}
  else{
    return IconButton(
    onPressed: (){}, 
    icon:Icon(Icons.luggage),
    color: Colors.white,
    
    );
  }
}

