import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_co/screens/doctor/search_expanded.dart';
import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';

class DoctorSearch extends StatefulWidget {
  var doctorID;
  DoctorSearch(this.doctorID);
  @override
  _DoctorSearchState createState() => _DoctorSearchState();
}

class _DoctorSearchState extends State<DoctorSearch> {
  var patientID;
  var dataStyle = TextStyle(fontSize: 17);
  bool noResult = true;
  var errorMessage = ' ';
  var searchField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: DatabaseService().patientList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: noResult == true
                  ? getNoResult(errorMessage)
                  : Container(
                      margin: EdgeInsets.only(top: 100, left: 15, right: 15),
                      height: 125,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SearchExpanded(
                                  patientID, snapshot, widget.doctorID);
                            },
                          ));
                        },
                        child: Card(
                          child: Padding(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 90,
                                  ),
                                  Container(
                                    width: 70,
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
                                            child: Text('Gender: ',
                                                style: dataStyle)),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Text('Contact: ',
                                                style: dataStyle)),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Text('Email: ',
                                                style: dataStyle))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 5,
                                  ),
                                  Expanded(child: getColumn(snapshot))
                                ],
                              ),
                              padding: EdgeInsets.only(bottom: 10, top: 20)),
                          elevation: 5.0,
                        ),
                      ),
                    ),
              appBar: AppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: GestureDetector(
                        onTap: () {
                          if (searchField.text.isEmpty) {
                            setState(() {
                              noResult = true;
                              errorMessage = "Please enter a Patient's Email";
                            });
                          } else {
                            int flag = 0;
                            for (var i in snapshot.data.documents) {
                              if (searchField.text == i.data['email']) {
                                flag = 1;
                                patientID = i.documentID;
                                break;
                              }
                            }
                            if (flag == 0) {
                              setState(() {
                                noResult = true;
                                errorMessage = 'Patient was not found';
                              });
                            } else {
                              setState(() {
                                noResult = false;
                                errorMessage = ' ';
                              });
                            }
                          }
                        },
                        child: Icon(Icons.search)),
                  )
                ],
                backgroundColor: Colors.white,
                title: Column(children: [
                  Container(
                    height: 3,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: searchField,
                    decoration:
                        InputDecoration(labelText: 'Search Patients by Email'),
                  ),
                ]),
              ),
            );
          } else {
            return Container(
                color: Colors.white,
                child: Loading(Theme.of(context).primaryColor));
          }
        });
  }

  Container getNoResult(String message) {
    return Container(
      child: Center(
        child: Text(
          message,
          style: TextStyle(fontSize: 25, color: Colors.grey),
        ),
      ),
      color: Colors.white,
    );
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

  Column getColumn(var snapshot) {
    var doc = snapshot.data.documents.firstWhere((doc) {
      return doc.documentID == patientID;
    });
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '${doc['firstName']} ${doc['lastName']} ',
            style: dataStyle,
          ),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(getGenderText(doc['gender']), style: dataStyle)),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('${doc['contactNumber']}', style: dataStyle)),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('${doc['email']}', style: dataStyle))
      ],
    );
  }
}
