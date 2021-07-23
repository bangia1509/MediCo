import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_co/screens/patient/accepted_doctors.dart';
import 'package:medi_co/screens/patient/declined_doctors.dart';
import 'package:medi_co/screens/patient/pending_doctors.dart';
import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';

class PatientAppointments extends StatefulWidget {
  var uID;
  PatientAppointments(this.uID);
  @override
  _PatientAppointmentsState createState() => _PatientAppointmentsState();
}

class _PatientAppointmentsState extends State<PatientAppointments> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService(uid: widget.uID).patientData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              //backgroundColor: Colors.white,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return PendingDoctors(widget.uID);
                            },
                          ));
                        },
                        trailing: Container(
                          width: 50,
                          height: 55,
                          color: Theme.of(context).primaryColor,
                          child: Center(
                              child: Text('${snapshot.data['pending'].length}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900))),
                        ),
                        leading: Icon(Icons.timelapse),
                        title: Text('Awaiting appointment requests',
                            style: TextStyle(fontSize: 17)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return AcceptedDoctors(widget.uID);
                            },
                          ));
                        },
                        trailing: Container(
                          width: 50,
                          height: 55,
                          color: Theme.of(context).primaryColor,
                          child: Center(
                              child: Text('${snapshot.data['accepted'].length}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900))),
                        ),
                        leading: Icon(Icons.check),
                        title: Text('Accepted appointment requests',
                            style: TextStyle(fontSize: 17)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return DeclinedDoctors(widget.uID);
                            },
                          ));
                        },
                        trailing: Container(
                          width: 50,
                          height: 55,
                          color: Theme.of(context).primaryColor,
                          child: Center(
                              child: Text(
                            '${snapshot.data['declined'].length}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w900),
                          )),
                        ),
                        leading: Icon(Icons.cancel),
                        title: Text('Declined appointment requests',
                            style: TextStyle(fontSize: 17)),
                      ),
                    ),
                  ),
                ],
              ),
              appBar: AppBar(
                title: Text('Appointments'),
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
