import 'package:flutter/material.dart';
import 'package:gaalguimoney/page/changepassword.dart';
import 'package:gaalguimoney/page/coderesetpassword.dart';
import 'package:gaalguimoney/page/confirmationsommenvoidirect.dart';
import 'package:gaalguimoney/page/finalisationinscription.dart';
import 'package:gaalguimoney/page/notification.dart';
import 'package:gaalguimoney/page/phoneverification.dart';
import 'package:gaalguimoney/page/qrcode.dart';
import 'package:gaalguimoney/page/resetpassword.dart';
import 'package:gaalguimoney/page/simplelogin.dart';
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
        return(MaterialPageRoute(builder: (_) => const Accueil()));
      case '/envoidirect':
        return MaterialPageRoute(builder: (_) => const EnvoiDirect());
      case '/envoicode':
        return MaterialPageRoute(builder: (_) => const EnvoiCode());
      case '/connexion':
        return MaterialPageRoute(builder: (_) => const Connection());
      case '/simplelogin':
        return MaterialPageRoute(builder: (_) => const SimpleLogin());
      case '/inscription':
        return MaterialPageRoute(builder: (_) => const Inscription());
      case '/phoneverification':
        return MaterialPageRoute(builder: (_) => PhoneVerification(args));
       case '/finalisationinscription':
        return MaterialPageRoute(builder: (_) => FinalisationInscription(args)); 
        case '/resetpassword':
        return MaterialPageRoute(builder: (_) =>const ResetPassword()); 
        case '/coderesetpassword':
        return MaterialPageRoute(builder: (_) => CodeResetPassword(args)); 
        case '/changepassword':
        return MaterialPageRoute(builder: (_) => ChangePassword(args)); 
       case '/notificationbusiness':
        return MaterialPageRoute(builder: (_) => NotificationBusiness());
       case '/notificationprofessionnel':
        return MaterialPageRoute(builder: (_) => NotificationProfessionnel());
      case '/confirmationsommenvoidirect':
        return MaterialPageRoute(builder: (_) => ConfirmationSommeDirect(args));
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
        return MaterialPageRoute(builder: (_) => const GaalguiPay());
      case '/application':
        return MaterialPageRoute(builder: (_) => const Application());
      case '/authentification':
        return MaterialPageRoute(builder: (_) => const Authentification());
      case '/protection':
        return MaterialPageRoute(builder: (_) => const Protection());
      case '/pointacces':
        return MaterialPageRoute(builder: (_) => const PointAcces());
      case '/gaalguimoneybusiness':
        return MaterialPageRoute(builder: (_) => const ForBusiness());
      case '/partenaire':
        return MaterialPageRoute(builder: (_) => const Partenaire());
      case '/notification':
        return MaterialPageRoute(builder: (_) => const NotificationUser());
      case '/qrcodeuser':
        return MaterialPageRoute(builder: (_) => const QrCodeUser());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }}

  
}
