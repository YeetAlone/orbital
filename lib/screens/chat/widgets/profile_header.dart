import 'package:building/models/chat_user.dart';
import 'package:flutter/material.dart';

// Header for the top of a chat conversation

class ProfileHeader extends StatefulWidget {
  final ChatUser user;
  const ProfileHeader({required this.user, Key? key}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(right: 16.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              const SizedBox(width: 2.0),
              CircleAvatar(
                backgroundImage: NetworkImage(widget.user.imageUrl),
                maxRadius: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.user.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Functionality required
                    Text(
                      "Online",
                      style:
                      TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// AppBar profileHeader({required ChatUser user, required Function onPressed}) {
//   return AppBar(
//     elevation: 0,
//     automaticallyImplyLeading: false,
//     backgroundColor: Colors.white,
//     flexibleSpace: SafeArea(
//       child: Container(
//         padding: const EdgeInsets.only(right: 16.0),
//         child: Row(
//           children: [
//             IconButton(
//               onPressed: () => onPressed,
//               icon: const Icon(Icons.arrow_back, color: Colors.black),
//             ),
//             const SizedBox(width: 2.0),
//             CircleAvatar(
//               backgroundImage: NetworkImage(user.urlAvatar),
//               maxRadius: 20,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     user.name,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   // Functionality required
//                   Text(
//                     "Online",
//                     style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
//                   ),
//                 ],
//               ),
//             ),
//             // Search reroute required
//             IconButton(
//               onPressed: () {},
//               icon: const Icon(Icons.settings, color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
