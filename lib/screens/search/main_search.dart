import 'package:flutter/material.dart';
import '../../shared/constants.dart';

class MainSearch extends StatelessWidget {

  /// TODO: 1. navigate the buttons to the respective pages
  /// TODO: 2. try to put different colours for the borders.
 
  const MainSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

//appbar
      appBar: PreferredSize(preferredSize: const Size.fromHeight(40),
        child: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(0, 77, 64,1),
          elevation: 0.0,
          title: const Text("SEARCH"),
        ),
      ),

      //body
        body: Column(
            children: <Widget>[
              const SizedBox(height:150),
              const Center(
                  child: Text(
                      "How do you want to find your colleague?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          color:Color.fromRGBO(0, 77, 64,1)
                      )
                  )
              ),
              const SizedBox(height: 50),
              ElevatedButton.icon(
                onPressed: () {

                },
                style: searchButtonStyle.copyWith(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(225, 242,226, 1)
                    )
                ),
                label: const Text(
                    "   Find by Name",
                    textAlign:TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 105, 92, 1),
                        fontSize: 24)
                ),
                icon: const ImageIcon(
                    AssetImage("assets/name.png"),
                    color: Color.fromRGBO(0, 77, 64,1), size:40),
              ),
              const SizedBox(height:20),
              ElevatedButton.icon(
                onPressed: () {  },
                style: searchButtonStyle.copyWith(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(244, 250,244, 1)
                    )
                ),
                label: const Text(
                    "  Find by Building",
                    textAlign:TextAlign.left,
                    style: TextStyle(color: Color.fromRGBO(0, 105, 92, 1),
                        fontSize: 24)
                ),
                icon: const ImageIcon(
                    AssetImage("assets/building.png"),
                    color: Color.fromRGBO(0, 77, 64,1),
                    size:45),
              ),
              const SizedBox(height:20),
              ElevatedButton.icon(
                onPressed: () {  },
                style: searchButtonStyle.copyWith(
                    backgroundColor: MaterialStateProperty.all(Colors.white)
                ),
                label: const Text(
                    " Find by Availability",
                    textAlign:TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 105, 92, 1),
                        fontSize: 24)
                ),
                icon: const Icon(
                    Icons.access_time,
                    color: Color.fromRGBO(0, 77, 64,1),
                    size:40),
              ),

            ]
        )
    );
  }
}
