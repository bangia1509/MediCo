import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';

class AcceptedPatients extends StatefulWidget {
  var docID;
  AcceptedPatients(this.docID);
  @override
  _AcceptedPatientsState createState() => _AcceptedPatientsState();
}

class _AcceptedPatientsState extends State<AcceptedPatients> {
  var dataStyle = TextStyle(fontSize: 17);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: DatabaseService().patientList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<DocumentSnapshot>(
              stream: DatabaseService(uid: widget.docID).doctorData,
              builder: (context, snapshot2) {
                if (snapshot2.hasData) {
                  if (snapshot2.data['accepted'].length == 0) {
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
                    return Scaffold(
                      body: Padding(
                          child: ListView.builder(
                            itemCount: snapshot2.data['accepted'].length,
                            itemBuilder: (context, index) {
                              return Card(
                                  child: ListTile(
                                      onTap: () {
                                        var dataPatient = snapshot
                                            .data.documents
                                            .firstWhere((doc) {
                                          return doc.documentID ==
                                              snapshot2.data['accepted'][index];
                                        });
                                        return showDialog(
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Padding(
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
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child: Text(
                                                                    'Name: ',
                                                                    style:
                                                                        dataStyle,
                                                                  ),
                                                                ),
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    child: Text(
                                                                        'Gender: ',
                                                                        style:
                                                                            dataStyle)),
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    child: Text(
                                                                        'Contact: ',
                                                                        style:
                                                                            dataStyle)),
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    child: Text(
                                                                        'Email: ',
                                                                        style:
                                                                            dataStyle))
                                                              ],
                                                            )),
                                                        Container(
                                                          width: 5,
                                                        ),
                                                        Expanded(
                                                            child: Column(
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                '${dataPatient['firstName']} ${dataPatient['lastName']} ',
                                                                style:
                                                                    dataStyle,
                                                              ),
                                                            ),
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    getGenderText(
                                                                        dataPatient[
                                                                            'gender']),
                                                                    style:
                                                                        dataStyle)),
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    '${dataPatient['contactNumber']}',
                                                                    style:
                                                                        dataStyle)),
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    '${dataPatient['email']}',
                                                                    style:
                                                                        dataStyle))
                                                          ],
                                                        ))
                                                      ],
                                                    ),
                                                    padding: EdgeInsets.only(
                                                        bottom: 10, top: 20)),
                                              );
                                            },
                                            context: context);
                                      },
                                      leading: Icon(Icons.person_outline),
                                      title:
                                          getTitle(index, snapshot, snapshot2),
                                      trailing: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                          ),
                                          onPressed: () async {
                                            var tempAccepted = List();
                                            var pAccepted = List();
                                            var dataPatient = snapshot
                                                .data.documents
                                                .firstWhere((doc) {
                                              return doc.documentID ==
                                                  snapshot2.data['accepted']
                                                      [index];
                                            });

                                            tempAccepted.addAll(
                                                snapshot2.data['accepted']);
                                            pAccepted.addAll(
                                                dataPatient['accepted']);
                                            tempAccepted.remove(snapshot2
                                                .data['accepted'][index]);
                                            pAccepted.remove(widget.docID);
                                            await DatabaseService(
                                                    uid: widget.docID)
                                                .updateDoctorData(
                                                    firstName: snapshot2
                                                        .data['firstName'],
                                                    lastName: snapshot2
                                                        .data['lastName'],
                                                    gender: snapshot2
                                                        .data['gender'],
                                                    contactNumber: snapshot2
                                                        .data['contactNumber'],
                                                    address: snapshot2
                                                        .data['address'],
                                                    email:
                                                        snapshot2.data['email'],
                                                    myPatients: snapshot2
                                                        .data['myPatients'],
                                                    special: snapshot2
                                                        .data['special'],
                                                    office: snapshot2
                                                        .data['office'],
                                                    exp: snapshot2.data['exp'],
                                                    qual:
                                                        snapshot2.data['qual'],
                                                    price:
                                                        snapshot2.data['price'],
                                                    pending: snapshot2
                                                        .data['pending'],
                                                    accepted: tempAccepted);
                                            await DatabaseService(
                                                    uid: snapshot2
                                                            .data['accepted']
                                                        [index])
                                                .editPatientData(
                                                    accepted: pAccepted);
                                          })));
                            },
                          ),
                          padding: EdgeInsets.only(top: 20)),
                      appBar: AppBar(
                        title: Text('Accepted Requests'),
                      ),
                    );
                  }
                } else {
                  return Container(
                      color: Colors.white,
                      child: Loading(Theme.of(context).primaryColor));
                }
              },
            );
          } else {
            return Container(
                color: Colors.white,
                child: Loading(Theme.of(context).primaryColor));
          }
        });
  }

  // void showStatus(String message) {
  //   showDialog(
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text(message),
  //         );
  //       },
  //       context: context);
  // }

  Text getTitle(int index, var snapshot, snapshot2) {
    for (var i in snapshot.data.documents) {
      if (i.documentID == snapshot2.data['accepted'][index]) {
        return Text('${i.data['firstName']} ${i.data['lastName']}');
      }
    }
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
