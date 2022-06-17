// /// Logic of the script: AppUser object passed down from main.dart using a
// /// Provider object.
// /// NOTE: Discuss transition time, delay time
// /// IF the user is not null, direct transition to profile page.
// /// ELSE transition to login screen after a 2 second delay.
//
// /// AnimatedPositioned, PositionedTransition
//
// import 'package:flutter/material.dart';
//
//
// class Logo extends StatefulWidget {
//   final bool loggedIn;
//   const Logo({Key? key, required this.loggedIn}) : super(key: key);
//
//   @override
//   State<Logo> createState() => _LogoState();
// }
//
// class _LogoState extends State<Logo> {
//   bool transition = false;
//
//   void startTransition() async {
//     Future.delayed(const Duration(seconds: 2), () =>
//         setState(() => transition = true));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     startTransition();
//     return !widget.loggedIn ? AnimatedPositioned(
//         duration: const Duration(seconds: 2),
//         top: ,
//         child: Container(
//           height: 150.0,
//           width: 300.0,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(
//               color: Colors.white,
//               width: 8,
//             ),
//           ),
//         )
//     ) :
//   }
// }
//
//

//! DEPRECATED