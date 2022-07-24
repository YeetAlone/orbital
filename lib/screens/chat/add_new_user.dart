import 'package:building/models/user.dart';
import 'package:building/services/chat/firebase_chat_storage.dart';
import 'package:building/services/cloud/firebase_cloud_storage.dart';
import 'package:building/shared/extensions.dart';
import 'package:building/shared/shared_data.dart';
import 'package:flutter/material.dart';

import '../../components/app_bar.dart';

class AddNewUser extends StatelessWidget {
  const AddNewUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          screenAppBar("Add User"),
          const SizedBox(height: 40),
          StreamBuilder<Iterable<AppUserData>>(
              stream: FirebaseCloudStorage().allUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return const Text('done');
                } else if (snapshot.hasError) {
                  return const Text('Error!');
                } else {
                  return SizedBox(
                    height: 200.0,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data!.elementAt(index).email ==
                            SharedPrefs.userEmail) {
                          return Container();
                        }
                        return ListTile(
                          title: Text(snapshot.data!
                              .elementAt(index)
                              .userName
                              .toTitleCase()),
                          onTap: () {
                            FirebaseChatStorage().createConversation(
                                sender: snapshot.data!.elementAt(index));
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  );
                }
              })
        ]),
      ),
    );
  }
}
