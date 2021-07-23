import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:medi_co/screens/doctor/patient_expanded.dart';

import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';

class DoctorPatients extends StatefulWidget {
  List myPatients;
  // DoctorPatients(this.myPatients);
  //String myUID;
  DoctorPatients(this.myPatients);
  @override
  _DoctorPatientsState createState() => _DoctorPatientsState();
}

class _DoctorPatientsState extends State<DoctorPatients> {
  //List<PatientRecord> patientRecords;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: DatabaseService().patientList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (widget.myPatients.length == 0) {
              return Container(
                child: Center(
                  child: Text(
                    'You do not have any Patients',
                    style: TextStyle(fontSize: 25, color: Colors.grey),
                  ),
                ),
                color: Colors.white,
              );
            } else {
              return Padding(
                  child:

                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     'Your patients:',
                      //     style: TextStyle(fontSize: 17),
                      //   ),
                      // ),
                      // Container(
                      //   height: 20,
                      // ),
                      ListView.builder(
                    itemCount: widget.myPatients.length,
                    //itemCount: widget.myPatients.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.person_outline),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return PatientExpanded(widget.myPatients[index]);
                            }));
                          },
                          title: getTitle(index, snapshot),
                        ),
                      );
                    },
                  ),
                  padding: EdgeInsets.only(
                    top: 20,
                  ));
            }
          } else {
            return Container(
                color: Colors.white,
                child: Loading(Theme.of(context).primaryColor));
          }
        });
  }

  Text getTitle(int index, var snapshot) {
    for (var i in snapshot.data.documents) {
      if (i.documentID == widget.myPatients[index]) {
        return Text('${i.data['firstName']} ${i.data['lastName']}');
      }
    }
  }
}
