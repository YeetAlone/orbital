import 'package:flutter/material.dart';

import '../../models/user.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  final AppUserData user = AppUserData(
      email: "dummy@gmail.com",
      firstName: "dummy",
      lastName: "dummy",
      userID: "dummy",
      profilePictureURL: "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg");
  @override
  Widget build(BuildContext context) {

    /// TODO: 1. Create navigation bar class to add below
    /// TODO: 2. create department for user class to display
    /// TODO: 3. Create buttons for syncing with calendars
    /// TODO: 4. Set placement of everything properly

    return Scaffold(

      // AppBar
        backgroundColor: const Color.fromRGBO(0, 105,92, 1),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            centerTitle: true,
            backgroundColor: const Color.fromRGBO(0, 77, 64, 1),
            elevation: 0.0,

            title: const Text("PROFILE"),
          ),
        ),

      //Main body of profile page
      body:Padding(
        padding:const EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          children: <Widget>[
            Center(
              child: CircleAvatar(backgroundColor: const Color.fromRGBO(165, 214, 167, 100),backgroundImage: NetworkImage(user.profilePictureURL),radius: 40.0,),
            ),
            const SizedBox(height:70),
            const Padding(
              padding: EdgeInsets.fromLTRB(0,0,450,0),
              child: Text("NAME",style: TextStyle(color: Colors.white,letterSpacing: 2.0,),),
            ),
            const SizedBox(height:10.0),
            Container(
              color: const Color.fromRGBO(165, 214, 167, 65),height: 54.0,width: 500,
              child: Text("\n ${user.firstName} ${user.lastName}",style: const TextStyle(color: Colors.white,letterSpacing: 2.0,fontSize: 16.0,),),
            ),
            const SizedBox(height:30.0),
            const Padding(
              padding: EdgeInsets.fromLTRB(0,0,450,0),
              child: Text("DEPARTMENT",style: TextStyle(color: Colors.white,letterSpacing: 2.0,),),
            ),
            const SizedBox(height:10.0),
            Container(
              color: const Color.fromRGBO(165, 214, 167, 65),height: 54.0,width: 500,
              child: const Text("\n Dummy",style: TextStyle(color: Colors.white,letterSpacing: 2.0,fontSize: 16.0,),),
            ),
            const SizedBox(height:70.0),
            Container(
                decoration: const BoxDecoration(color: Color.fromRGBO(165, 214, 167, 0.6),borderRadius: BorderRadius.all(Radius.circular(40.0))),
                height:47,width:510,
                child: Row(
                  children: [
                    const Text("\n sync with google calendar?",style: TextStyle(color: Colors.white, letterSpacing: 2.0, fontSize: 16.0,)),
                    const SizedBox(width:170),
                  ],)
            ),
            const SizedBox(height:20),
            Container(
                decoration: const BoxDecoration(color: Color.fromRGBO(165, 214, 167, 0.6),borderRadius: BorderRadius.all(Radius.circular(40.0))),
                height:47,width:510,
                child: Row(
                  children: const [
                    Text("\n sync with outlook calendar?",style: TextStyle(color: Colors.white, letterSpacing: 2.0, fontSize: 16.0,)),
                    SizedBox(width:170),
                  ],)
            ),
          ]
        )
      )
    );
  }
}
