import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';

class AcceptedDoctors extends StatefulWidget {
  var patientID;
  AcceptedDoctors(this.patientID);
  @override
  _AcceptedDoctorsState createState() => _AcceptedDoctorsState();
}

class _AcceptedDoctorsState extends State<AcceptedDoctors> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService(uid: widget.patientID).patientData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['accepted'].length == 0) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Accepted Requests'),
                ),
                body: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'No accepted appointment requests',
                      style: TextStyle(fontSize: 25, color: Colors.grey),
                    ),
                  ),
                ),
              );
            } else {
              return StreamBuilder<QuerySnapshot>(
                  stream: DatabaseService().doctorList,
                  builder: (context, snapshot2) {
                    if (snapshot2.hasData) {
                      return Scaffold(
                        body: Padding(
                            child: ListView.builder(
                              itemCount: snapshot.data['accepted'].length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: getTitle(index, snapshot, snapshot2),
                                    leading: Icon(Icons.person_outline),
                                  ),
                                );
                              },
                            ),
                            padding: EdgeInsets.only(top: 20)),
                        appBar: AppBar(
                          title: Text('Accepted Requests'),
                        ),
                      );
                    } else {
                      return Container(
                          color: Colors.white,
                          child: Loading(Theme.of(context).primaryColor));
                    }
                  });
            }
          } else {
            return Container(
                color: Colors.white,
                child: Loading(Theme.of(context).primaryColor));
          }
        });
  }

  Text getTitle(int index, var snapshot, var snapshot2) {
    for (var i in snapshot2.data.documents) {
      if (i.documentID == snapshot.data['accepted'][index]) {
        return Text('${i.data['firstName']} ${i.data['lastName']}');
      }
    }
  }
}
