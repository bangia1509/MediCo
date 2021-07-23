import 'package:flutter/material.dart';
import 'package:medi_co/screens/patient/patient_appointments.dart';
import 'package:medi_co/screens/patient/patient_prescription.dart';
import 'patient_medical_image.dart';

int count = 0;

class PatientHome extends StatefulWidget {
  var uID;
  PatientHome(this.uID);
  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                  height: 250,
                  width: 500,
                  margin: EdgeInsets.only(top: 30, left: 40, right: 40),
                  child: Card(
                      semanticContainer: true,
                      color: Colors.lightGreen,
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      shadowColor: Colors.green,
                      child: InkWell(
                          onTap: () => {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return PatientAppointments(widget.uID);
                                  },
                                ))
                              },
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch, // add this
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(3.0),
                                    bottomRight: Radius.circular(3.0)),
                                child: Image.asset('images/Appointments.jpg',
                                    // width: 300,
                                    height: 180,
                                    fit: BoxFit.fill),
                              ),
                              ListTile(
                                title: Text('Appointments',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          )))),
              Wrap(children: [
                Container(
                    height: 250,
                    width: 500,
                    margin: EdgeInsets.only(top: 30, left: 40, right: 40),
                    child: GestureDetector(
                        onTap: () {
                          print("Tapped");
                        },
                        child: Card(
                            semanticContainer: true,
                            color: Colors.lightGreen,
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            shadowColor: Colors.green,
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return PatientPrescription(widget.uID);
                                    },
                                  ));
                                },
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch, // add this
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(3.0),
                                          bottomRight: Radius.circular(3.0)),
                                      child:
                                          Image.asset('images/prescription.jpg',
                                              // width: 300,
                                              height: 180,
                                              fit: BoxFit.fill),
                                    ),
                                    ListTile(
                                      title: Text('My prescription',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                  ],
                                ))))),
                Container(
                    height: 250,
                    width: 500,
                    margin: EdgeInsets.only(
                        top: 30, left: 40, right: 40, bottom: 40),
                    child: GestureDetector(
                        onTap: () {
                          print("Tapped");
                        },
                        child: Card(
                            semanticContainer: true,
                            color: Colors.lightGreen,
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            shadowColor: Colors.green,
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PatientMedicalImage()));
                                },
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch, // add this
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(3.0),
                                          bottomRight: Radius.circular(3.0)),
                                      child: Image.asset(
                                          'images/medical_record.jpg',
                                          // width: 300,
                                          height: 180,
                                          fit: BoxFit.fill),
                                    ),
                                    ListTile(
                                      title: Text(
                                          'Medical Record (coming soon)',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ),
                                  ],
                                ))))),
              ])
            ]))));
  }
}

// ignore: non_constant_identifier_names
