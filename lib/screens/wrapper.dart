import 'package:flutter/material.dart';
import 'package:medi_co/models/user.dart';
import 'package:medi_co/screens/authenticate.dart';
import 'package:medi_co/screens/get_home_screen.dart';

import 'package:medi_co/services/database.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      print('HELLOOOOOOOOO');
      return GetHomeScreen(user.uid);
      // return StreamProvider<UserData>.value(
      //     value: DatabaseService(uid: user.uid).userData,
      //     child: GetHomeScreen());
    }
  }
}
