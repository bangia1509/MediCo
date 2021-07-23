import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_co/models/user.dart';
import 'package:medi_co/screens/doctor/doctor_screen.dart';
import 'package:medi_co/screens/patient/patient_screen.dart';

import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';
import 'package:provider/provider.dart';

class GetHomeScreen extends StatelessWidget {
  var uid;
  GetHomeScreen(this.uid);
  @override
  Widget build(BuildContext context) {
    // final userData = Provider.of<UserData>(context);
    // if (userData.category == 'Doctor') {
    //   return DoctorScreen(userData.uid);
    // } else if (userData.category == 'Patient') {
    //   return TestPatientScreen();
    return StreamBuilder<DocumentSnapshot>(
      stream: DatabaseService(uid: uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['category'] == 'Doctor') {
            return DoctorScreen(uid);
          } else if (snapshot.data['category'] == 'Patient') {
            return PatientScreen(uid);
          }
        } else {
          return Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Colors.white,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                    stops: [0.4, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: Loading(Colors.black));
        }
      },
    );
  }
}
