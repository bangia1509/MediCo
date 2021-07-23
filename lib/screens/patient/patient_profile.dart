import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';

class PatientProfile extends StatefulWidget {
  var uID;
  PatientProfile(this.uID);
  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  var dataStyle = TextStyle(fontSize: 17);
  String valSmoking;
  String valBlood;
  var listBlood = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  var listSmoking = [
    "I don't smoke",
    'I used to',
    '1-2 per day',
    '3-5 per day',
    'more than 10 per day'
  ];
  var heightCont = TextEditingController();
  var weightCont = TextEditingController();
  var allergyCont = TextEditingController();
  var injuryCont = TextEditingController();
  var surgeryCont = TextEditingController();
  String valAlcohol;
  var listAlcohol = ['Non-Drinker', 'Rare', 'Regular', 'Heavy'];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService(uid: widget.uID).patientData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            heightCont.text = snapshot.data['height'] ?? '';
            weightCont.text = snapshot.data['weight'] ?? '';
            valBlood = snapshot.data['bloodGroup'] ?? valBlood;
            valAlcohol = snapshot.data['alcohol'] ?? valAlcohol;
            valSmoking = snapshot.data['smoking'] ?? valSmoking;
            allergyCont.text = snapshot.data['allergies'] ?? '';
            injuryCont.text = snapshot.data['injuries'] ?? '';
            surgeryCont.text = snapshot.data['surgeries'] ?? '';
            return Scaffold(
                appBar: AppBar(
                  actions: [
                    Padding(
                        child: RaisedButton(
                            child: Text(
                              'UPDATE',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                            color: Colors.white,
                            onPressed: () async {
                              await DatabaseService(uid: widget.uID)
                                  .editPatientData(
                                      height: heightCont.text.length == 0
                                          ? null
                                          : heightCont.text,
                                      weight: weightCont.text.length == 0
                                          ? null
                                          : weightCont.text,
                                      bloodGroup: valBlood,
                                      alcohol: valAlcohol,
                                      smoking: valSmoking,
                                      allergies: allergyCont.text.length == 0
                                          ? null
                                          : allergyCont.text,
                                      injuries: injuryCont.text.length == 0
                                          ? null
                                          : injuryCont.text,
                                      surgeries: surgeryCont.text.length == 0
                                          ? null
                                          : surgeryCont.text);
                              showStatus('Profile updated');
                            }),
                        padding:
                            EdgeInsets.only(top: 10, right: 15, bottom: 10))
                  ],
                  title: Text(
                    'Profile Management',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
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
                                      '${snapshot.data['firstName']} ${snapshot.data['lastName']} ',
                                      style: dataStyle,
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          getGenderText(
                                              snapshot.data['gender']),
                                          style: dataStyle)),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          '${snapshot.data['contactNumber']}',
                                          style: dataStyle)),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('${snapshot.data['email']}',
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
                      child: Column(
                        children: [
                          Padding(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: heightCont,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                    labelText: 'Height (cm)'),
                              ),
                              padding: EdgeInsets.only(
                                  top: 25, left: 20, right: 20)),
                          Padding(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: weightCont,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                    labelText: 'Weight (kg)'),
                              ),
                              padding: EdgeInsets.only(
                                  top: 25, left: 20, right: 20)),
                          Padding(
                              child: DropdownButton(
                                hint: Text('Blood Group'),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black),
                                value: valBlood,
                                items: listBlood
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    valBlood = value;
                                  });
                                },
                              ),
                              padding: EdgeInsets.only(
                                  top: 25, left: 20, right: 20)),
                          Padding(
                              child: DropdownButton(
                                hint: Text('Alcohol Consumption'),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black),
                                value: valAlcohol,
                                items: listAlcohol
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    valAlcohol = value;
                                  });
                                },
                              ),
                              padding: EdgeInsets.only(
                                  top: 25, left: 20, right: 20)),
                          Padding(
                              child: DropdownButton(
                                hint: Text('Smoking Habits'),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black),
                                value: valSmoking,
                                items: listSmoking
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    valSmoking = value;
                                  });
                                },
                              ),
                              padding: EdgeInsets.only(
                                  top: 25, left: 20, right: 20)),
                          Padding(
                              child: TextField(
                                controller: allergyCont,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                    labelText: 'Allergies'),
                              ),
                              padding: EdgeInsets.only(
                                  top: 25, left: 20, right: 20)),
                          Padding(
                              child: TextField(
                                controller: injuryCont,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                    labelText: 'Injuries'),
                              ),
                              padding: EdgeInsets.only(
                                  top: 25, left: 20, right: 20)),
                          Padding(
                              child: TextField(
                                controller: surgeryCont,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                    labelText: 'Surgeries'),
                              ),
                              padding: EdgeInsets.only(
                                  top: 25, left: 20, right: 20, bottom: 50)),
                        ],
                      ),
                    )
                  ],
                ));
          } else {
            return Container(
                color: Colors.white,
                child: Loading(Theme.of(context).primaryColor));
          }
        });
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
