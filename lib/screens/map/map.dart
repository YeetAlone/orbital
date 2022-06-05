import 'package:flutter/material.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(title: Text("MAP", style: TextStyle(color:Colors.white)), elevation:0,centerTitle: true,backgroundColor: Color.fromRGBO(0, 77, 64, 1) ,)),
    );
  }
}
