import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class AnimatedLoad extends StatelessWidget {
  const AnimatedLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     decoration: BoxDecoration(color: Colors.white),
     child: SpinKitSquareCircle(
     color: Colors.purple,
     size: 250.0,
     duration: Duration(milliseconds: 1000),
)
    );
    
  }
}

Widget EnvoiAnimate(){
  return Container(
     decoration: BoxDecoration(color: Colors.white),
     child: SpinKitPouringHourGlass(
     color: Colors.yellow,
     size: 250.0,
     duration: Duration(milliseconds: 1000),
)
    );
}

Widget HistoriqueAnimate(){
  return Container(
     decoration: BoxDecoration(color: Colors.white),
     child: Center(
       child: SpinKitFadingGrid(
       color: Colors.green,
       size: 100.0,
       duration: Duration(milliseconds: 1000),
),
     )
    );

}

Widget ConfirmationPhoneAnimate(){
   return Container(
     decoration: BoxDecoration(color: Colors.white),
     child: Center(
       child: SpinKitFoldingCube(
       color: Colors.blue,
       size: 100.0,
       duration: Duration(milliseconds: 1000),
),
     )
    );

}