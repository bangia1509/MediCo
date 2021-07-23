import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';

class SearchExpanded extends StatefulWidget {
  var doctorID;
  var uid;
  var snap;
  SearchExpanded(this.uid, this.snap, this.doctorID);
  @override
  _SearchExpandedState createState() => _SearchExpandedState(uid, snap);
}

class _SearchExpandedState extends State<SearchExpanded> {
  var uid;
  var snap;
  _SearchExpandedState(this.uid, this.snap);

  var dataStyle = TextStyle(fontSize: 17);
  @override
  Widget build(BuildContext context) {
    var dataPatient = snap.data.documents.firstWhere((doc) {
      return doc.documentID == uid;
    });
    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService(uid: widget.doctorID).doctorData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                                        child:
                                            Text('Gender: ', style: dataStyle)),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: Text('Contact: ',
                                            style: dataStyle)),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child:
                                            Text('Email: ', style: dataStyle))
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
                                    '${dataPatient['firstName']} ${dataPatient['lastName']} ',
                                    style: dataStyle,
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        getGenderText(dataPatient['gender']),
                                        style: dataStyle)),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        '${dataPatient['contactNumber']}',
                                        style: dataStyle)),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('${dataPatient['email']}',
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
                          title: Text('Height'),
                          subtitle: Text(getHeight(dataPatient['height'])),
                        )),
                  ),
                  Card(
                    elevation: 2.5,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text('Weight'),
                          subtitle: Text(getWeight(dataPatient['weight'])),
                        )),
                  ),
                  Card(
                    elevation: 2.5,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text('Blood Group'),
                          subtitle:
                              Text(getBloodGroup(dataPatient['bloodGroup'])),
                        )),
                  ),
                  Card(
                    elevation: 2.5,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text('Alcoholic Habbits'),
                          subtitle: Text(getAlcohol(dataPatient['alcohol'])),
                        )),
                  ),
                  Card(
                    elevation: 2.5,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text('Smoking Habits'),
                          subtitle: Text(getSmoking(dataPatient['smoking'])),
                        )),
                  ),
                  Card(
                    elevation: 2.5,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text('Allergies'),
                          subtitle:
                              Text(getAllergies(dataPatient['allergies'])),
                        )),
                  ),
                  Card(
                    elevation: 2.5,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text('Injuries'),
                          subtitle: Text(getInjuries(dataPatient['injuries'])),
                        )),
                  ),
                  Card(
                    elevation: 2.5,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text('Surgeries'),
                          subtitle:
                              Text(getSurgeries(dataPatient['surgeries'])),
                        )),
                  )
                ],
              ),
              appBar: AppBar(
                actions: [
                  Padding(
                      child: RaisedButton(
                          child: Row(
                            children: [
                              Icon(Icons.person_add),
                              Container(
                                width: 10,
                              ),
                              Text(
                                'Add Patient',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                            ],
                          ),
                          color: Colors.white,
                          onPressed: () async {
                            int flag = 0;
                            for (var i in snapshot.data['myPatients']) {
                              if (i == uid) {
                                flag = 1;
                                break;
                              }
                            }

                            if (flag == 1) {
                              showStatus('You already have this Patient');
                            } else {
                              // var temp = snapshot.data['myPatients'];
                              var temp2 = [uid];
                              temp2.addAll(snapshot.data['myPatients']);
                              // temp.insert(0, uid);
                              await DatabaseService(uid: widget.doctorID)
                                  .updateDoctorData(
                                      firstName: snapshot.data['firstName'],
                                      lastName: snapshot.data['lastName'],
                                      gender: snapshot.data['gender'],
                                      contactNumber:
                                          snapshot.data['contactNumber'],
                                      address: snapshot.data['address'],
                                      email: snapshot.data['email'],
                                      myPatients: temp2,
                                      special: snapshot.data['special'],
                                      office: snapshot.data['office'],
                                      exp: snapshot.data['exp'],
                                      qual: snapshot.data['qual'],
                                      price: snapshot.data['price'],
                                      pending: snapshot.data['pending'],
                                      accepted: snapshot.data['accepted']);
                              showStatus('Patient was added');
                            }
                          }),
                      padding: EdgeInsets.only(top: 10, right: 15, bottom: 10))
                ],
                title: Text(
                    '${dataPatient['firstName']} ${dataPatient['lastName']}'),
              ),
            );
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

  String getHeight(var h) {
    return h != null ? '$h cm' : 'Patient has not filled their Height';
  }

  String getWeight(var h) {
    return h != null ? '$h kg' : 'Patient has not filled their Weight';
  }

  String getBloodGroup(var h) {
    return h != null ? '$h' : 'Patient has not filled their Blood Group';
  }

  String getAlcohol(var h) {
    return h != null ? '$h' : 'Patient has not filled their Alcoholic Habits';
  }

  String getSmoking(var h) {
    return h != null ? '$h' : 'Patient has not filled their Smoking Habits';
  }

  String getAllergies(var h) {
    return h != null ? '$h' : 'Patient has not filled thier Allergies';
  }

  String getInjuries(var h) {
    return h != null ? '$h' : 'Patient has not filled thier Injuries';
  }

  String getSurgeries(var h) {
    return h != null ? '$h' : 'Patient has not filled thier Surgeries';
  }
}
