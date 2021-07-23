import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';

class DeclinedDoctors extends StatefulWidget {
  var patientID;
  DeclinedDoctors(this.patientID);
  @override
  _DeclinedDoctorsState createState() => _DeclinedDoctorsState();
}

class _DeclinedDoctorsState extends State<DeclinedDoctors> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService(uid: widget.patientID).patientData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['declined'].length == 0) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Declined Requests'),
                ),
                body: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'No declined appointment requests',
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
                              itemCount: snapshot.data['declined'].length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    trailing: Wrap(
                                      spacing: 20,
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.refresh),
                                            onPressed: () async {
                                              var dataDoctor = snapshot2
                                                  .data.documents
                                                  .firstWhere((doc) {
                                                return doc.documentID ==
                                                    snapshot.data['declined']
                                                        [index];
                                              });
                                              var patientPending = List();
                                              var patientDeclined = List();
                                              var doctorPending = List();
                                              doctorPending.addAll(
                                                  dataDoctor['pending']);
                                              doctorPending
                                                  .add(widget.patientID);
                                              patientPending.addAll(
                                                  snapshot.data['pending']);
                                              patientPending.add(snapshot
                                                  .data['declined'][index]);
                                              patientDeclined.addAll(
                                                  snapshot.data['declined']);
                                              patientDeclined.remove(snapshot
                                                  .data['declined'][index]);
                                              print(doctorPending);

                                              await DatabaseService(
                                                      uid: widget.patientID)
                                                  .editPatientData(
                                                      pending: patientPending,
                                                      declined:
                                                          patientDeclined);
                                              await DatabaseService(
                                                      uid: snapshot
                                                              .data['declined']
                                                          [index])
                                                  .editDoctorData(
                                                      pending: doctorPending);
                                              showStatus('Request resent');
                                            }),
                                        IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () async {
                                              var tempDecline = List();
                                              tempDecline.addAll(
                                                  snapshot.data['declined']);
                                              tempDecline.remove(snapshot
                                                  .data['declined'][index]);
                                              await DatabaseService(
                                                      uid: widget.patientID)
                                                  .editPatientData(
                                                      declined: tempDecline);
                                            }),
                                      ],
                                    ),
                                    title: getTitle(index, snapshot, snapshot2),
                                    leading: Icon(Icons.person_outline),
                                  ),
                                );
                              },
                            ),
                            padding: EdgeInsets.only(top: 20)),
                        appBar: AppBar(
                          title: Text('Declined Requests'),
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
      if (i.documentID == snapshot.data['declined'][index]) {
        return Text('${i.data['firstName']} ${i.data['lastName']}');
      }
    }
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
}
