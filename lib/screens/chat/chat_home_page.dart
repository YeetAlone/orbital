import 'package:building/models/chat_convo.dart';
import 'package:building/models/user.dart';
import 'package:building/screens/chat/add_new_user.dart';
import 'package:building/screens/chat/widgets/chat_home_body.dart';
import 'package:building/services/chat/firebase_chat_storage.dart';
import 'package:building/shared/shared_data.dart';
import 'package:flutter/material.dart';
import 'package:building/components/app_bar.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({Key? key}) : super(key: key);

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final users = Users.initUsers;
    // for (ChatUser user in users) {
    //   if (user.userId != '11') {
    //     FirebaseChatAPI().addUser(user);
    //   }
    // }
    return Scaffold(
        backgroundColor: const Color.fromRGBO(244, 250, 244, 100),
        body: FutureBuilder<AppUserData>(
            future: Future.value(SharedPrefs.userData),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    screenAppBar("CHAT"),
                    SafeArea(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(flex: 5, child: SizedBox()),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 2, bottom: 2),
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.pink[50],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddNewUser(
                                                receiverEmail: "",
                                              )));
                                },
                                child: Row(
                                  children: const <Widget>[
                                    Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "Add New",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.all(8),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100)),
                        ),
                      ),
                    ),
                    SafeArea(
                        child: FutureBuilder<List<ChatConversation>>(
                      future: FirebaseChatStorage().getChatsFromEveryone(),
                      builder: (context, snapshot) {
                        // if (snapshot.hasError) {
                        //   return Text('Error: ${snapshot.error}');
                        // }
                        final users = snapshot.data;
                        if (users == null || users.isEmpty) {
                          return const Text("No users found, add a few");
                        } else {
                          return ChatBody(
                            users: users,
                          );
                        }
                      },
                    ))
                  ],
                ),
              );
            }));
  }
}
