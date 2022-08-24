import 'package:flutter/material.dart';




class Partenaire extends StatefulWidget {
  const Partenaire({Key? key}) : super(key: key);

  @override
  State<Partenaire> createState() => _PartenaireState();
}

class _PartenaireState extends State<Partenaire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("partenaire"),
      ),
    );
  }
}