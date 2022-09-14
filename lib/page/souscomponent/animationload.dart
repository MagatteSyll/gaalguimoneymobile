import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class AnimatedLoad extends StatelessWidget {
  const AnimatedLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     decoration:const BoxDecoration(color: Colors.white),
     child:const SpinKitSquareCircle(
     color: Colors.purple,
     size: 250.0,
     duration: Duration(milliseconds: 1000),
)
    );
    
  }
}

// ignore: non_constant_identifier_names
Widget EnvoiAnimate(){
  return Container(
     decoration:const BoxDecoration(color: Colors.white),
     child: const SpinKitPouringHourGlass(
     color: Colors.red,
     size: 250.0,
     duration: Duration(milliseconds: 1000),
)
    );
}

Widget HistoriqueAnimate(){
  return Container(
     decoration:const BoxDecoration(color: Colors.white),
     child:const Center(
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
     decoration:const BoxDecoration(color: Colors.white),
     child:const Center(
       child: SpinKitFoldingCube(
       color: Colors.blue,
       size: 100.0,
       duration: Duration(milliseconds: 1000),
),
     )
    );

}