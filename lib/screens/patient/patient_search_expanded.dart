import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';

class PatientSearchExpanded extends StatefulWidget {
  var docID;
  var snapshot;
  var pID;
  PatientSearchExpanded(this.docID, this.snapshot, this.pID);
  @override
  _PatientSearchExpandedState createState() => _PatientSearchExpandedState();
}

class _PatientSearchExpandedState extends State<PatientSearchExpanded> {
  var dataStyle = TextStyle(fontSize: 17);
  @override
  Widget build(BuildContext context) {
    var dataDoctor = widget.snapshot.data.documents.firstWhere((doc) {
      return doc.documentID == widget.docID;
    });
    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService(uid: widget.pID).patientData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<DocumentSnapshot>(
                stream: DatabaseService(uid: widget.docID).doctorData,
                builder: (context, snapshot2) {
                  return Scaffold(
                    body: ListView(
                      children: [
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
                                          '${dataDoctor['firstName']} ${dataDoctor['lastName']} ',
                                          style: dataStyle,
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              getGenderText(
                                                  dataDoctor['gender']),
                                              style: dataStyle)),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              '${dataDoctor['contactNumber']}',
                                              style: dataStyle)),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('${dataDoctor['email']}',
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
                          elevation: 2.5,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text('Specialization'),
                                subtitle:
                                    Text(getSpecial(dataDoctor['special'])),
                              )),
                        ),
                        Card(
                          elevation: 2.5,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text('Current Office'),
                                subtitle: Text(getOffice(dataDoctor['office'])),
                              )),
                        ),
                        Card(
                          elevation: 2.5,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text('Work Experience'),
                                subtitle: Text(getExp(dataDoctor['exp'])),
                              )),
                        ),
                        Card(
                          elevation: 2.5,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text('Qualification'),
                                subtitle: Text(getQual(dataDoctor['qual'])),
                              )),
                        ),
                        Card(
                          elevation: 2.5,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text('OPD Rate'),
                                subtitle: Text(getPrice(dataDoctor['price'])),
                              )),
                        ),
                      ],
                    ),
                    appBar: AppBar(
                      actions: [
                        Padding(
                            child: RaisedButton(
                              child: Text(
                                'Request Appointment',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
                              ),

                              color: Colors.white,
                              onPressed: () async {
                                int flagP = 0;
                                int flagA = 0;
                                int flagD = 0;
                                var tempD = List();
                                var tempP = List();
                                var tempDocP = List();
                                for (var i in snapshot.data['pending']) {
                                  if (i == widget.docID) {
                                    flagP = 1;
                                    break;
                                  }
                                }
                                for (var i in snapshot.data['accepted']) {
                                  if (i == widget.docID) {
                                    flagA = 1;
                                    break;
                                  }
                                }
                                for (var i in snapshot.data['declined']) {
                                  if (i == widget.docID) {
                                    flagD = 1;
                                    break;
                                  }
                                }
                                if (flagP == 1) {
                                  showStatus('Apointment already requested');
                                } else {
                                  if (flagA == 1) {
                                    showStatus('Appointment already due');
                                  } else {
                                    if (flagD == 1) {
                                      tempD.addAll(snapshot.data['declined']);
                                      tempD.remove(widget.docID);
                                    } else {
                                      tempD.addAll(snapshot.data['declined']);
                                    }
                                    tempP.addAll(snapshot.data['pending']);
                                    tempP.add(widget.docID);
                                    tempDocP.addAll(snapshot2.data['pending']);
                                    tempDocP.add(widget.pID);
                                    await DatabaseService(uid: widget.pID)
                                        .updatePatientData(
                                            firstName:
                                                snapshot.data['firstName'],
                                            lastName: snapshot.data['lastName'],
                                            gender: snapshot.data['gender'],
                                            contactNumber:
                                                snapshot.data['contactNumber'],
                                            address: snapshot.data['address'],
                                            email: snapshot.data['email'],
                                            height: snapshot.data['height'],
                                            weight: snapshot.data['weight'],
                                            bloodGroup:
                                                snapshot.data['bloodGroup'],
                                            alcohol: snapshot.data['alcohol'],
                                            smoking: snapshot.data['smoking'],
                                            allergies:
                                                snapshot.data['allergies'],
                                            injuries: snapshot.data['injuries'],
                                            surgeries:
                                                snapshot.data['surgeries'],
                                            diagnosis:
                                                snapshot.data['diagnosis'],
                                            tests: snapshot.data['tests'],
                                            medication:
                                                snapshot.data['medication'],
                                            accepted: snapshot.data['accepted'],
                                            pending: tempP,
                                            declined: tempD);
                                    await DatabaseService(uid: widget.docID)
                                        .updateDoctorData(
                                            firstName:
                                                snapshot2.data['firstName'],
                                            lastName:
                                                snapshot2.data['lastName'],
                                            gender: snapshot2.data['gender'],
                                            contactNumber:
                                                snapshot2.data['contactNumber'],
                                            address: snapshot2.data['address'],
                                            email: snapshot2.data['email'],
                                            myPatients:
                                                snapshot2.data['myPatients'],
                                            special: snapshot2.data['special'],
                                            office: snapshot2.data['office'],
                                            exp: snapshot2.data['exp'],
                                            qual: snapshot2.data['qual'],
                                            price: snapshot2.data['price'],
                                            accepted:
                                                snapshot2.data['accepted'],
                                            pending: tempDocP);
                                    showStatus('Appointment requested');
                                  }
                                }
                              },
                              // onPressed: () async {
                              //   int flag = 0;
                              //   for (var i in snapshot.data['myPatients']) {
                              //     if (i == uid) {
                              //       flag = 1;
                              //       break;
                              //     }
                              //   }

                              //   if (flag == 1) {
                              //     showStatus('You already have this Patient');
                              //   } else {
                              //     // var temp = snapshot.data['myPatients'];
                              //     var temp2 = [uid];
                              //     temp2.addAll(snapshot.data['myPatients']);
                              //     // temp.insert(0, uid);
                              //     await DatabaseService(uid: widget.doctorID)
                              //         .updateDoctorData(
                              //             firstName: snapshot.data['firstName'],
                              //             lastName: snapshot.data['lastName'],
                              //             gender: snapshot.data['gender'],
                              //             contactNumber:
                              //                 snapshot.data['contactNumber'],
                              //             address: snapshot.data['address'],
                              //             email: snapshot.data['email'],
                              //             myPatients: temp2,
                              //             special: snapshot.data['special'],
                              //             office: snapshot.data['office'],
                              //             exp: snapshot.data['exp'],
                              //             qual: snapshot.data['qual'],
                              //             price: snapshot.data['price'],
                              //             pending: snapshot.data['pending'],
                              //             accepted: snapshot.data['accepted']);
                              //     showStatus('Patient was added');
                              //   }
                              // }),
                            ),
                            padding:
                                EdgeInsets.only(top: 10, right: 15, bottom: 10))
                      ],
                      title: Text(
                          '${dataDoctor['firstName']} ${dataDoctor['lastName']}'),
                    ),
                  );
                });
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

  String getSpecial(var h) {
    return h != null ? '$h' : 'Doctor has not filled their Specialization';
  }

  String getOffice(var h) {
    return h != null ? '$h' : 'Doctor has not filled their Current Office';
  }

  String getExp(var h) {
    return h != null ? '$h' : 'Doctor has not filled their Work Experience';
  }

  String getQual(var h) {
    return h != null ? '$h' : 'Doctor has not filled their Qualification';
  }

  String getPrice(var h) {
    return h != null ? 'Rs. $h' : 'Doctor has not filled their OPD Rate';
  }
}
