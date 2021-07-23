import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';

class PendingPatients2 extends StatefulWidget {
  var doctorID;
  PendingPatients2(this.doctorID);

  @override
  _PendingPatients2State createState() => _PendingPatients2State();
}

class _PendingPatients2State extends State<PendingPatients2> {
  var dataStyle = TextStyle(fontSize: 17);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: DatabaseService().patientList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<DocumentSnapshot>(
                stream: DatabaseService(uid: widget.doctorID).doctorData,
                builder: (context, snapshot2) {
                  if (snapshot2.hasData) {
                    if (snapshot2.data['pending'].length != 0) {
                      return Scaffold(
                        body: Padding(
                            child: ListView.builder(
                              itemCount: snapshot2.data['pending'].length,
                              itemBuilder: (context, index) {
                                return Card(
                                    child: ListTile(
                                  onTap: () {
                                    var dataPatient = snapshot.data.documents
                                        .firstWhere((doc) {
                                      return doc.documentID ==
                                          snapshot2.data['pending'][index];
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
                                                    // Container(
                                                    //   width: 10,
                                                    // ),
                                                    Container(
                                                        width: 75,
                                                        child: Column(
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                'Name: ',
                                                                style:
                                                                    dataStyle,
                                                              ),
                                                            ),
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                    'Gender: ',
                                                                    style:
                                                                        dataStyle)),
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                    'Contact: ',
                                                                    style:
                                                                        dataStyle)),
                                                            Align(
                                                                alignment: Alignment
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
                                                            style: dataStyle,
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
                                                    )),
                                                  ],
                                                ),
                                                padding: EdgeInsets.only(
                                                    bottom: 10, top: 20)),
                                          );
                                        },
                                        context: context);
                                  },
                                  leading: Icon(Icons.person_outline),
                                  title: getTitle(index, snapshot, snapshot2),
                                  trailing: Wrap(
                                    spacing: 20,
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          ),
                                          onPressed: () async {
                                            var dataPatient = snapshot
                                                .data.documents
                                                .firstWhere((doc) {
                                              return doc.documentID ==
                                                  snapshot2.data['pending']
                                                      [index];
                                            });
                                            String message = ' ';
                                            int flag = 0;
                                            var tempPatients = List();
                                            var tempAccepted = List();
                                            var tempPending = List();
                                            var accP = List();
                                            var penP = List();
                                            for (var i in snapshot2
                                                .data['myPatients']) {
                                              if (i ==
                                                  snapshot2.data['pending']
                                                      [index]) {
                                                flag = 1;
                                                break;
                                              }
                                            }
                                            if (flag == 1) {
                                              tempPatients.addAll(
                                                  snapshot2.data['myPatients']);
                                              message = ' ';
                                            } else {
                                              tempPatients.add(snapshot2
                                                  .data['pending'][index]);
                                              tempPatients.addAll(
                                                  snapshot2.data['myPatients']);
                                              message =
                                                  'Patient added to your Patients List';
                                            }

                                            tempAccepted.addAll(
                                                snapshot2.data['accepted']);
                                            accP.addAll(
                                                dataPatient['accepted']);
                                            tempAccepted.add(snapshot2
                                                .data['pending'][index]);
                                            accP.add(widget.doctorID);
                                            tempPending.addAll(
                                                snapshot2.data['pending']);
                                            penP.addAll(dataPatient['pending']);
                                            tempPending.remove(snapshot2
                                                .data['pending'][index]);
                                            penP.remove(widget.doctorID);
                                            await DatabaseService(
                                                    uid: widget.doctorID)
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
                                                    myPatients: tempPatients,
                                                    special: snapshot2
                                                        .data['special'],
                                                    office: snapshot2
                                                        .data['office'],
                                                    exp: snapshot2.data['exp'],
                                                    qual:
                                                        snapshot2.data['qual'],
                                                    price:
                                                        snapshot2.data['price'],
                                                    pending: tempPending,
                                                    accepted: tempAccepted);
                                            await DatabaseService(
                                                    uid: snapshot2
                                                        .data['pending'][index])
                                                .editPatientData(
                                                    pending: penP,
                                                    accepted: accP);
                                            showStatus2('Appointment Accepted',
                                                message);
                                          }),
                                      IconButton(
                                          icon: Icon(Icons.cancel,
                                              color: Colors.red),
                                          onPressed: () async {
                                            var dataPatient = snapshot
                                                .data.documents
                                                .firstWhere((doc) {
                                              return doc.documentID ==
                                                  snapshot2.data['pending']
                                                      [index];
                                            });
                                            var tempPending = List();
                                            var pendingPatient = List();
                                            var decPatient = List();
                                            decPatient.addAll(
                                                dataPatient['declined']);
                                            decPatient.add(widget.doctorID);

                                            tempPending.addAll(
                                                snapshot2.data['pending']);
                                            pendingPatient
                                                .addAll(dataPatient['pending']);
                                            tempPending.remove(snapshot2
                                                .data['pending'][index]);
                                            pendingPatient
                                                .remove(widget.doctorID);
                                            await DatabaseService(
                                                    uid: widget.doctorID)
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
                                                    pending: tempPending,
                                                    accepted: snapshot2
                                                        .data['accepted']);
                                            await DatabaseService(
                                                    uid: snapshot2
                                                        .data['pending'][index])
                                                .editPatientData(
                                                    pending: pendingPatient,
                                                    declined: decPatient);
                                            showStatus(
                                              'Appointment Declined',
                                            );
                                          })
                                    ],
                                  ),
                                ));
                              },
                            ),
                            padding: EdgeInsets.only(top: 20)),
                        appBar: AppBar(
                          title: Text('Pending Requests'),
                        ),
                      );
                    } else {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text('Pending Requests'),
                        ),
                        body: Container(
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              'No pending appointment requests',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.grey),
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    return Container(
                        color: Colors.white,
                        child: Loading(Theme.of(context).primaryColor));
                  }
                });
            //CHECK

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

  void showStatus2(String message1, String message2) {
    showDialog(
        builder: (context) {
          return AlertDialog(
            content: Text(message2),
            title: Text(message1),
          );
        },
        context: context);
  }

  Text getTitle(int index, var snapshot, var snapshot2) {
    for (var i in snapshot.data.documents) {
      if (i.documentID == snapshot2.data['pending'][index]) {
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
