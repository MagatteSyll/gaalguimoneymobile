import 'package:flutter/material.dart';
import './page/confirmationphone.dart';
import './page/partenaire.dart';
import './page/gaalguimoneybusiness.dart';
import './page/pointacces.dart';
import './page/gaalguimoneypay.dart';
import './page/application.dart';
import './page/authentification.dart';
import './page/protection.dart';
import './page/confirmationcode.dart';
import './page/Inscription.dart';
import './page/recucode.dart';
import './page/accueil.dart';
import './page/connexion.dart';
import './page/historiqueoneanuulationcommande.dart';
import './page/historiqueonecode.dart';
import './page/historiqueonedepot.dart';
import './page/historiqueonedirect.dart';
import './page/historiqueonepayement.dart';
import './page/historiqueonereception.dart';
import './page/historiqueoneretrait.dart';
import './page/payementqrcode.dart';
import './page/recupayement.dart';
import './page/envoidirect.dart';
import './page/envoiviacode.dart';
import './page/confirmationenvoidirect.dart';
import './page/recudirect.dart';
import './page/notificationbusiness.dart';
import './page/notificationprofessionnel.dart';




class RouteGenerator  {
 

  static Route<dynamic> generateRoute(RouteSettings settings) {
   final  args=settings.arguments;
    switch (settings.name) {
      case '/': 
        return(MaterialPageRoute(builder: (_) => Accueil()));
      case '/envoidirect':
        return MaterialPageRoute(builder: (_) => EnvoiDirect());
      case '/envoicode':
        return MaterialPageRoute(builder: (_) => EnvoiCode());
      case '/connexion':
        return MaterialPageRoute(builder: (_) => Connection());
      case '/inscription':
        return MaterialPageRoute(builder: (_) => Inscription());
      case '/confirmationphone':
        return MaterialPageRoute(builder: (_) => ConfirmationPhone(args));
       case '/notificationbusiness':
        return MaterialPageRoute(builder: (_) => NotificationBusiness());
       case '/notificationprofessionnel':
        return MaterialPageRoute(builder: (_) => NotificationProfessionnel());
      case '/confirmationenvoi':
        return MaterialPageRoute(builder: (_) => ConfirmationDirect(args));
      case '/recudirect':
        return MaterialPageRoute(builder: (_) => RecuDirect(args));
      case '/confirmationcode':
        return MaterialPageRoute(builder: (_) => ConfirmationCode(args));
      case '/recucode':
        return MaterialPageRoute(builder: (_) => RecuCode(args));
      case '/historiqueonedirect':
        return MaterialPageRoute(builder: (_) => HistoriqueOneDirect(args));
      case '/historiqueonecode':
        return MaterialPageRoute(builder: (_) => HistoriqueOneCode(args));
      case '/historiqueonedepot':
        return MaterialPageRoute(builder: (_) => HistoriqueOneDepot(args));
      case '/historiqueoneretrait':
        return MaterialPageRoute(builder: (_) => HistoriqueOneRetrait(args));
      case '/historiqueonereception':
        return MaterialPageRoute(builder: (_) => HistoriqueOneReception(args));
      case '/historiqueonepayement':
        return MaterialPageRoute(builder: (_) => HistoriqueOnePayement(args));
      case '/annulationcommandegaalguishop':
        return MaterialPageRoute(builder: (_) => AnnulationCommandeGaalguiShop(args));
      case '/payementqrcode':
        return MaterialPageRoute(builder: (_) => PayementCode(args));
      case '/recupayementqrcode':
        return MaterialPageRoute(builder: (_) => RecuPayement(args));
      case '/gaalguimoneypay':
        return MaterialPageRoute(builder: (_) => GaalguiPay());
      case '/application':
        return MaterialPageRoute(builder: (_) => Application());
      case '/authentification':
        return MaterialPageRoute(builder: (_) => Authentification());
      case '/protection':
        return MaterialPageRoute(builder: (_) => Protection());
      case '/pointacces':
        return MaterialPageRoute(builder: (_) => PointAcces());
      case '/gaalguimoneybusiness':
        return MaterialPageRoute(builder: (_) => ForBusiness());
      case '/partenaire':
        return MaterialPageRoute(builder: (_) => Partenaire());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }}

  
}
