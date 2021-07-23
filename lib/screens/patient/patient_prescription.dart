import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';

class PatientPrescription extends StatefulWidget {
  var uID;
  PatientPrescription(this.uID);
  @override
  _PatientPrescriptionState createState() => _PatientPrescriptionState();
}

class _PatientPrescriptionState extends State<PatientPrescription> {
  var style = TextStyle(fontSize: 19);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService(uid: widget.uID).patientData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: ListView(
                children: [
                  Container(
                    height: 100,
                  ),
                  Card(
                    child: ListTile(
                      leading: Text(
                        'Diagnosis:',
                        style: style,
                      ),
                      title: Text(snapshot.data['diagnosis'] ?? 'None'),
                    ),
                  ),
                  Container(
                    height: 50,
                  ),
                  Card(
                    child: ListTile(
                      leading: Text('Medical Tests:', style: style),
                      title: Text(snapshot.data['tests'] ?? 'None'),
                    ),
                  ),
                  Container(
                    height: 50,
                  ),
                  Card(
                    child: ListTile(
                      leading: Text('Medication:', style: style),
                      title: Text(snapshot.data['medication'] ?? 'None'),
                    ),
                  )
                ],
              ),
              appBar: AppBar(
                title: Text('My prescription'),
              ),
            );
          } else {
            return Container(
                color: Colors.white,
                child: Loading(Theme.of(context).primaryColor));
          }
        });
  }
}
