import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_co/models/user.dart';
import 'package:medi_co/screens/doctor/doctor_appointments.dart';
import 'package:medi_co/screens/doctor/doctor_patient.dart';
import 'package:medi_co/screens/doctor/doctor_profile.dart';
import 'package:medi_co/screens/doctor/doctor_search.dart';
import 'package:medi_co/services/auth.dart';
import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';
import 'package:provider/provider.dart';

class DoctorScreen extends StatefulWidget {
  var myUID;
  DoctorScreen(this.myUID);
  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final AuthService _auth = AuthService();
  int selectedIndex = 0;
  var pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: DatabaseService(uid: widget.myUID).doctorData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //DoctorData doctorData = snapshot.data;
          return Scaffold(
            body: getPageView(snapshot),
            bottomNavigationBar: BottomNavigationBar(
                onTap: (value) {
                  setState(() {
                    selectedIndex = value;
                    pageController.animateToPage(value,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  });
                },
                currentIndex: selectedIndex,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      title: Text('Patients'), icon: Icon(Icons.list)),
                  BottomNavigationBarItem(
                      title: Text('Search'), icon: Icon(Icons.search)),
                  BottomNavigationBarItem(
                      title: Text('Appointments'),
                      icon: Icon(Icons.event_note)),
                  BottomNavigationBarItem(
                      title: Text('Profile'), icon: Icon(Icons.person))
                ]),
            appBar: AppBar(
              actions: [
                Padding(
                    child: RaisedButton(
                        child: Text(
                          'LOGOUT',
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        color: Colors.white,
                        onPressed: () async {
                          await _auth.signOut();
                        }),
                    padding: EdgeInsets.only(top: 10, right: 15, bottom: 10))
              ],
              title: Text('Hello, ${snapshot.data['firstName']}!'),
            ),
          );
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

  PageView getPageView(var snapshot) {
    return PageView(
      onPageChanged: (value) {
        setState(() {
          selectedIndex = value;
        });
      },
      controller: pageController,
      children: [
        // DoctorPatients(doctorData.myPatients),
        DoctorPatients(snapshot.data['myPatients']),
        DoctorSearch(widget.myUID),
        DoctorAppointments(snapshot, widget.myUID),
        DoctorProfile(widget.myUID)
      ],
    );
  }
}
