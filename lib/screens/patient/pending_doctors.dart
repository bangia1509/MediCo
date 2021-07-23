import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';

class PendingDoctors extends StatefulWidget {
  var patientID;
  PendingDoctors(this.patientID);
  @override
  _PendingDoctorsState createState() => _PendingDoctorsState();
}

class _PendingDoctorsState extends State<PendingDoctors> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService(uid: widget.patientID).patientData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['pending'].length == 0) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Awaiting Requests'),
                ),
                body: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'No awaiting appointment requests',
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
                              itemCount: snapshot.data['pending'].length,
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
                          title: Text('Awaiting Requests'),
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
      if (i.documentID == snapshot.data['pending'][index]) {
        return Text('${i.data['firstName']} ${i.data['lastName']}');
      }
    }
  }
}
