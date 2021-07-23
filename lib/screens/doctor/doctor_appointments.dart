import 'package:flutter/material.dart';
import 'package:medi_co/screens/doctor/accepted_patients.dart';

import 'package:medi_co/screens/doctor/pending_patients_2.dart';

class DoctorAppointments extends StatefulWidget {
  var snapshot;
  var docID;
  DoctorAppointments(this.snapshot, this.docID);
  @override
  _DoctorAppointmentsState createState() => _DoctorAppointmentsState();
}

class _DoctorAppointmentsState extends State<DoctorAppointments> {
  var style = TextStyle(
    fontSize: 17,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Container(
        //   height: 100,
        // ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return PendingPatients2(widget.docID);
                      },
                    ));
                  },
                  child: Container(
                      height: 100,
                      child: Column(
                        children: [
                          Expanded(
                              child: Center(
                            child: Text(
                              'Appointments',
                              style: style,
                            ),
                          )),
                          Expanded(
                              child: Text(
                            'Pending',
                            style: style,
                          )),
                          Expanded(
                              child: Text(
                            '${widget.snapshot.data['pending'].length}',
                            style: style,
                          ))
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Container(
                width: 10,
              ),
              Expanded(
                  child: Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
              ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
              )),
              Container(
                width: 10,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return AcceptedPatients(widget.docID);
                      },
                    ));
                  },
                  child: Container(
                      height: 100,
                      child: Column(
                        children: [
                          Expanded(
                              child: Center(
                            child: Text(
                              'Appointments',
                              style: style,
                            ),
                          )),
                          Expanded(
                              child: Center(
                                  child: Text('Accepted', style: style))),
                          Expanded(
                              child: Center(
                                  child: Text(
                                      '${widget.snapshot.data['accepted'].length}',
                                      style: style)))
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
