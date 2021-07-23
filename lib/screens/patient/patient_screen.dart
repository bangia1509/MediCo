import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_co/screens/patient/patient_home.dart';
import 'package:medi_co/screens/patient/patient_maps.dart';
import 'package:medi_co/screens/patient/patient_nav_drawer.dart';
import 'package:medi_co/screens/patient/patient_search.dart';
import 'package:medi_co/services/auth.dart';
import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';

class PatientScreen extends StatefulWidget {
  var uID;
  PatientScreen(this.uID);
  @override
  _PatientScreenState createState() => _PatientScreenState(uID);
}

class _PatientScreenState extends State<PatientScreen> {
  var pageController = PageController(initialPage: 0);
  var pUID;
  _PatientScreenState(this.pUID);

  int _currentIndex = 0;
  //  List<Widget> _children = [
  //   PatientHome(),
  //   PatientSearch(pUID),
  //   PatientMaps()
  // ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;

      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService(uid: widget.uID).patientData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              drawer: PatientNavDrawer(widget.uID),
              appBar: AppBar(
                backgroundColor: Colors.lightGreen,
                title: Text('Hello, ${snapshot.data['firstName']}!'),
              ),
              // body: _children[_currentIndex],
              body: getPageView(),
              bottomNavigationBar: BottomNavigationBar(
                onTap: onTabTapped, // new
                currentIndex: _currentIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.home),
                    title: new Text('Home'),
                  ),
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.search),
                    title: new Text('Search'),
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.location_on), title: Text('Nearby'))
                ],
              ),
            );
          } else {
            return Container(
                color: Colors.white,
                child: Loading(Theme.of(context).primaryColor));
          }
        });
  }

  PageView getPageView() {
    return PageView(
      onPageChanged: (value) {
        setState(() {
          _currentIndex = value;
        });
      },
      controller: pageController,
      children: [PatientHome(pUID), PatientSearch(pUID), PatientMaps()],
    );
  }
}
