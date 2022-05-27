import 'package:building/authenticate/authenticate.dart';
import 'package:building/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser?>(context);

    /// Sending the user to the profile page
    /// TODO: send to map
    return user == null ? const Authenticate() : Profile();
  }
}
