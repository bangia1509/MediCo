import 'package:flutter/material.dart';
import 'package:medi_co/models/user.dart';
import 'package:medi_co/screens/doctor/doctor_screen.dart';
import 'package:medi_co/screens/wrapper.dart';
import 'package:medi_co/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.lightGreen),
        title: 'MediCo',
        home: Wrapper(),
      ),
    );
  }
}

// class MyApp2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.lightGreen),
//       home: DoctorScreen(),
//     );
//   }
// }
