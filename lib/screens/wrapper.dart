import 'package:building/authenticate/authenticate.dart';
import 'package:building/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../models/user.dart';


class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool isLoggedIn = true;

  Future startTransition() async {
    return Future.delayed(const Duration(seconds: 2), () {});
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -0.4))
            .animate(_controller);
    _controller.forward().whenComplete(() =>
    isLoggedIn ? Get.to(() => Profile()) : Get.to(() => const Authenticate())
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      setState(() => isLoggedIn = false);
    }

    /// Sending the user to the profile page
    /// TODO: send to map
    return FutureBuilder(
        initialData: startTransition(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting :

            /// Return logo
              return Container(
                height: 150.0,
                width: 300.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                    width: 8,
                  ),
                ),
              );

          /// Return animation
            default :
              return SlideTransition(
                position: _animation,
                child: Container(
                  height: 150.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                      width: 8,
                    ),
                  ),
                ),

              );
          //   return AnimatedPositioned(
          //     duration: const Duration(seconds: 2),
          //     top: transition ? 20 : ,
          //     child: Container(
          //       height: 150.0,
          //       width: 300.0,
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         border: Border.all(
          //           color: Colors.white,
          //           width: 8,
          //         ),
          //       ),
          //     )
          // );  // Return animation
          }
        }
    );
  }
}
