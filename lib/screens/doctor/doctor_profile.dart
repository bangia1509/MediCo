import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';

class DoctorProfile extends StatefulWidget {
  var uID;
  DoctorProfile(this.uID);
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  var specialData = TextEditingController();
  var officeData = TextEditingController();
  var expData = TextEditingController();
  var qualData = TextEditingController();
  var priceData = TextEditingController();
  var dataStyle = TextStyle(fontSize: 17);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService(uid: widget.uID).doctorData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            specialData.text = snapshot.data['special'] ?? '';
            officeData.text = snapshot.data['office'] ?? '';
            expData.text = snapshot.data['exp'] ?? '';
            qualData.text = snapshot.data['qual'] ?? '';
            priceData.text = snapshot.data['price'] ?? '';
            return ListView(children: [
              Card(
                child: Padding(
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 90,
                        ),
                        Container(
                          width: 10,
                        ),
                        Container(
                            width: 75,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Name: ',
                                    style: dataStyle,
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('Gender: ', style: dataStyle)),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('Contact: ', style: dataStyle)),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('Email: ', style: dataStyle))
                              ],
                            )),
                        Container(
                          width: 5,
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${snapshot.data['firstName']} ${snapshot.data['lastName']} ',
                                style: dataStyle,
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    getGenderText(snapshot.data['gender']),
                                    style: dataStyle)),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text('${snapshot.data['contactNumber']}',
                                    style: dataStyle)),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text('${snapshot.data['email']}',
                                    style: dataStyle))
                          ],
                        ))
                      ],
                    ),
                    padding: EdgeInsets.only(bottom: 10, top: 20)),
                elevation: 5.0,
              ),
              Container(
                height: 15,
              ),
              Card(
                child: Column(
                  children: [
                    Padding(
                        child: TextField(
                          controller: specialData,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 17),
                              labelText: 'Specialization'),
                        ),
                        padding: EdgeInsets.only(top: 25, left: 20, right: 20)),
                    Padding(
                        child: TextField(
                          controller: officeData,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 17),
                              labelText: 'Current Office'),
                        ),
                        padding: EdgeInsets.only(top: 25, left: 20, right: 20)),
                    Padding(
                        child: TextField(
                          controller: expData,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 17),
                              labelText: 'Work Experience'),
                        ),
                        padding: EdgeInsets.only(top: 25, left: 20, right: 20)),
                    Padding(
                        child: TextField(
                          controller: qualData,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 17),
                              labelText: 'Qualification'),
                        ),
                        padding: EdgeInsets.only(top: 25, left: 20, right: 20)),
                    Padding(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: priceData,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 17),
                              labelText: 'OPD Rate (in Rupees)'),
                        ),
                        padding: EdgeInsets.only(
                            top: 25, left: 20, right: 20, bottom: 20))
                  ],
                ),
              ),
              Container(
                height: 5,
              ),
              Center(
                child: RaisedButton(
                    child: Text(
                      'Update',
                      style: TextStyle(fontSize: 20),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      await DatabaseService(uid: widget.uID).updateDoctorData(
                          firstName: snapshot.data['firstName'],
                          lastName: snapshot.data['lastName'],
                          gender: snapshot.data['gender'],
                          contactNumber: snapshot.data['contactNumber'],
                          address: snapshot.data['address'],
                          email: snapshot.data['email'],
                          myPatients: snapshot.data['myPatients'],
                          special: specialData.text.length == 0
                              ? null
                              : specialData.text,
                          office: officeData.text.length == 0
                              ? null
                              : officeData.text,
                          exp: expData.text.length == 0 ? null : expData.text,
                          qual:
                              qualData.text.length == 0 ? null : qualData.text,
                          price: priceData.text.length == 0
                              ? null
                              : priceData.text,
                          pending: snapshot.data['pending'],
                          accepted: snapshot.data['accepted']);
                      showStatus('Profile updated');
                    }),
              ),
              Container(
                height: 25,
              ),
            ]);
          } else {
            return Container(
                color: Colors.white,
                child: Loading(Theme.of(context).primaryColor));
          }
        });
  }

  void showStatus(String message) {
    showDialog(
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        },
        context: context);
  }

  String getGenderText(var g) {
    switch (g) {
      case 'm':
        return 'Male';
        break;
      case 'f':
        return 'Female';
        break;
    }
  }
}
