import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_co/services/database.dart';
import 'package:medi_co/shared/loading.dart';

class PatientExpanded extends StatefulWidget {
  var uid;
  PatientExpanded(this.uid);
  @override
  _PatientExpandedState createState() => _PatientExpandedState();
}

class _PatientExpandedState extends State<PatientExpanded> {
  var diagVal = TextEditingController();
  var testVal = TextEditingController();
  var medVal = TextEditingController();
  int selectedIndex = 0;
  var dataStyle = TextStyle(fontSize: 17);
  var pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService(uid: widget.uid).patientData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                  onTap: (value) {
                    setState(() {
                      selectedIndex = value;
                      pageController.animateToPage(value,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    });
                  },
                  currentIndex: selectedIndex,
                  items: [
                    BottomNavigationBarItem(
                        title: Text('Personal Record'),
                        icon: Icon(Icons.person_pin)),
                    BottomNavigationBarItem(
                        title: Text('Medical Record'),
                        icon: Icon(Icons.event_note))
                  ]),
              body: getPageView(snapshot),
              appBar: AppBar(
                title: Text(
                    '${snapshot.data['firstName']} ${snapshot.data['lastName']}'),
              ),
            );
          } else {
            return Container(
                color: Colors.white,
                child: Loading(Theme.of(context).primaryColor));
          }
        });
  }

  PageView getPageView(var snapshot) {
    return PageView(
      onPageChanged: (value) {
        setState(() {
          selectedIndex = value;
        });
      },
      controller: pageController,
      children: [
        getPersonal(snapshot),
        getMedical(snapshot),
      ],
    );
  }

  Widget getMedical(var snapshot) {
    diagVal.text = snapshot.data['diagnosis'] ?? '';
    testVal.text = snapshot.data['tests'] ?? '';
    medVal.text = snapshot.data['medication'] ?? '';
    return ListView(
      children: [
        Container(
          height: 15,
        ),
        Card(
          child: ListTile(
            title: TextField(
              controller: diagVal,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
              style: dataStyle,
            ),
            leading: Text(
              'Diagnosis',
              style: dataStyle,
            ),
          ),
        ),
        Container(
          height: 30,
        ),
        Card(
          child: ListTile(
            title: TextField(
              controller: testVal,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
              style: dataStyle,
            ),
            leading: Text(
              'Medical Tests',
              style: dataStyle,
            ),
          ),
        ),
        Container(
          height: 30,
        ),
        Card(
          child: ListTile(
            title: TextField(
              controller: medVal,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
              style: dataStyle,
            ),
            leading: Text(
              'Medication',
              style: dataStyle,
            ),
          ),
        ),
        Container(
          height: 75,
        ),
        Center(
            child: RaisedButton(
                child: Text(
                  'Update',
                  style: TextStyle(fontSize: 20),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  await DatabaseService(uid: widget.uid).updatePatientData(
                      firstName: snapshot.data['firstName'],
                      lastName: snapshot.data['lastName'],
                      gender: snapshot.data['gender'],
                      contactNumber: snapshot.data['contactNumber'],
                      address: snapshot.data['address'],
                      email: snapshot.data['email'],
                      height: snapshot.data['height'],
                      weight: snapshot.data['weight'],
                      bloodGroup: snapshot.data['bloodGroup'],
                      alcohol: snapshot.data['alcohol'],
                      smoking: snapshot.data['smoking'],
                      allergies: snapshot.data['allergies'],
                      injuries: snapshot.data['injuries'],
                      surgeries: snapshot.data['surgeries'],
                      diagnosis: diagVal.text.length == 0 ? null : diagVal.text,
                      tests: testVal.text.length == 0 ? null : testVal.text,
                      medication: medVal.text.length == 0 ? null : medVal.text,
                      pending: snapshot.data['pending'],
                      accepted: snapshot.data['accepted'],
                      declined: snapshot.data['declined']);

                  showStatus('Medical Record Updated');
                }))
      ],
    );
  }

  Widget getPersonal(var snapshot) {
    return ListView(
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
                              child: Text('Gender: ', style: dataStyle)),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Text('Contact: ', style: dataStyle)),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Text('Email: ', style: dataStyle))
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
                          child: Text(getGenderText(snapshot.data['gender']),
                              style: dataStyle)),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('${snapshot.data['contactNumber']}',
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
          elevation: 2.5,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Height'),
                subtitle: Text(getHeight(snapshot.data['height'])),
              )),
        ),
        Card(
          elevation: 2.5,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Weight'),
                subtitle: Text(getWeight(snapshot.data['weight'])),
              )),
        ),
        Card(
          elevation: 2.5,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Blood Group'),
                subtitle: Text(getBloodGroup(snapshot.data['bloodGroup'])),
              )),
        ),
        Card(
          elevation: 2.5,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Alcoholic Habbits'),
                subtitle: Text(getAlcohol(snapshot.data['alcohol'])),
              )),
        ),
        Card(
          elevation: 2.5,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Smoking Habits'),
                subtitle: Text(getSmoking(snapshot.data['smoking'])),
              )),
        ),
        Card(
          elevation: 2.5,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Allergies'),
                subtitle: Text(getAllergies(snapshot.data['allergies'])),
              )),
        ),
        Card(
          elevation: 2.5,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Injuries'),
                subtitle: Text(getInjuries(snapshot.data['injuries'])),
              )),
        ),
        Card(
          elevation: 2.5,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Surgeries'),
                subtitle: Text(getSurgeries(snapshot.data['surgeries'])),
              )),
        )
      ],
    );
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
