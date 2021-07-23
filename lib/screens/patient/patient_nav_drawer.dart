import 'package:flutter/material.dart';

import 'package:medi_co/screens/patient/patient_profile.dart';
import 'package:medi_co/screens/patient/read_about_health.dart';
import 'package:medi_co/screens/patient/webview_amazon.dart';
import 'package:medi_co/services/auth.dart';

class PatientNavDrawer extends StatelessWidget {
  var uID;
  PatientNavDrawer(this.uID);
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
              height: 300,
              margin: EdgeInsets.only(top: 33),
              child: DrawerHeader(
                child: Text(' '),
                decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('images/stetho.png'))),
              )),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile Management'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PatientProfile(uID)));
            },
          ),
          ListTile(
            leading: Icon(Icons.mood),
            title: Text('Health and wellness products'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WebviewAmazon()))
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Consult your doctor (coming soon)'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.healing),
            title: Text('Read about Health'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReadAboutHealth()))
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              await _auth.signOut();
            },
          ),
          // Container(
          //     margin: EdgeInsets.only(top: 160, left: 20),
          //     child: Text("Made by:-\n\nAnsh\nOjas\nTanish\nJatin",
          //         style: TextStyle(fontSize: 10)))
        ],
      ),
    );
  }
}
