import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_co/screens/patient/patient_search_expanded.dart';
import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';

class PatientSearch extends StatefulWidget {
  var pUID;

  PatientSearch(this.pUID);
  @override
  _PatientSearchState createState() => _PatientSearchState();
}

class _PatientSearchState extends State<PatientSearch> {
  var dataStyle = TextStyle(fontSize: 17);
  var docID;
  bool showError = true;
  String message = ' ';
  // var searchField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: DatabaseService().doctorList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                Container(
                    //height: 500,
                    padding: EdgeInsets.only(top: 40, left: 15, right: 15),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      onSubmitted: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            showError = true;
                            message = "Please enter a Doctor's email";
                          });
                        } else {
                          int flag = 0;
                          for (var i in snapshot.data.documents) {
                            if (value == i.data['email']) {
                              flag = 1;
                              docID = i.documentID;
                              break;
                            }
                          }
                          if (flag == 0) {
                            setState(() {
                              showError = true;
                              message = 'Doctor was not found';
                            });
                          } else {
                            setState(() {
                              showError = false;
                              message = ' ';
                            });
                          }
                        }
                      },
                      //controller: searchField,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(
                            color: Colors.teal,
                          )),
                          hintText: ' ',
                          helperText:
                              'Search doctors for appointments by email. ',
                          labelText: 'Search',
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.green,
                          ),
                          prefixText: ' ',
                          suffixStyle: const TextStyle(color: Colors.green)),
                    )),
                getSearch(snapshot)
              ],
            );
          } else {
            return Container(
                color: Colors.white,
                child: Loading(Theme.of(context).primaryColor));
          }
        });
  }

  Widget getSearch(var snapshot) {
    if (showError == true) {
      return Container(
        margin: EdgeInsets.only(top: 100),
        child: Center(
          child: Text(
            message,
            style: TextStyle(fontSize: 25, color: Colors.grey),
          ),
        ),
        color: Colors.white,
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 100, left: 15, right: 15),
        height: 125,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return PatientSearchExpanded(docID, snapshot, widget.pUID);
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
                              child: Text('Gender: ', style: dataStyle)),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Text('Contact: ', style: dataStyle)),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Text('Email: ', style: dataStyle))
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
      );
    }
  }

  Column getColumn(var snapshot) {
    var doc = snapshot.data.documents.firstWhere((doc) {
      return doc.documentID == docID;
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
