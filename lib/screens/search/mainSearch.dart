import 'package:flutter/material.dart';
import '../../shared/constants.dart';

class mainSearch extends StatelessWidget {

  /// TODO: 1. navigate the buttons to the respective pages
  /// TODO: 2. try to put different colours for the borders.
 
  const mainSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

//appbar
      appBar: PreferredSize(preferredSize: Size.fromHeight(40),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 77, 64,1),
          elevation: 0.0,
          title: Text("SEARCH"),
        ),
      ),

      //body
        body: Column(
            children: <Widget>[
              SizedBox(height:150),
              Center(child: Text("How do you want to find your colleague?", style: TextStyle(fontSize: 32, color:Color.fromRGBO(0, 77, 64,1)))),
              SizedBox(height: 50),
              ElevatedButton.icon(
                onPressed: () {  },
                style: searchButtonStyle.copyWith(backgroundColor: MaterialStateProperty.all(Color.fromRGBO(225, 242,226, 1))),
                label: const Text("   Find by Name", textAlign:TextAlign.left, style: TextStyle(color: Color.fromRGBO(0, 105, 92, 1),fontSize: 24)),
                icon: ImageIcon(AssetImage("name.png"), color: Color.fromRGBO(0, 77, 64,1),size:40),
              ),
              SizedBox(height:20),
              ElevatedButton.icon(
                onPressed: () {  },
                style: searchButtonStyle.copyWith(backgroundColor: MaterialStateProperty.all(Color.fromRGBO(244, 250,244, 1))),
                label: const Text("  Find by Building", textAlign:TextAlign.left, style: TextStyle(color: Color.fromRGBO(0, 105, 92, 1),fontSize: 24)),
                icon: ImageIcon(AssetImage("building.png"), color: Color.fromRGBO(0, 77, 64,1),size:45),
              ),
              SizedBox(height:20),
              ElevatedButton.icon(
                onPressed: () {  },
                style: searchButtonStyle.copyWith(backgroundColor: MaterialStateProperty.all(Colors.white)),
                label: const Text(" Find by Availability", textAlign:TextAlign.left, style: TextStyle(color: Color.fromRGBO(0, 105, 92, 1),fontSize: 24)),
                icon: Icon(Icons.access_time, color: Color.fromRGBO(0, 77, 64,1),size:40),
              ),

            ]
        )
    );
  }
}
