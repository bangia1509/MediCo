import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientMaps extends StatefulWidget {
  @override
  _PatientMapsState createState() => _PatientMapsState();
}

class _PatientMapsState extends State<PatientMaps> {
  openurl() {
    String urll =
        'https://www.google.com/maps/search/nearby+pharmacy/@30.9158389,75.8302039,14z';
    launch(urll);
  }

  openurl2() {
    String urll =
        'https://www.google.com/maps/search/nearby+hospitals/@30.9158389,75.8302039,14z';
    launch(urll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: 700,
          child: SingleChildScrollView(
              child: Wrap(
            children: [
              Container(
                  height: 250,
                  width: 500,
                  margin: EdgeInsets.only(top: 80, left: 40, right: 40),
                  child: Card(
                      semanticContainer: true,
                      color: Colors.lightGreen,
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      shadowColor: Colors.green,
                      child: InkWell(
                          onTap: () {
                            openurl();
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
                                child: Image.asset('images/pharmacy.jpg',
                                    // width: 300,
                                    height: 180,
                                    fit: BoxFit.fill),
                              ),
                              ListTile(
                                title: Text('Pharmacies near me',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          )))),
              Container(
                  height: 250,
                  width: 500,
                  margin: EdgeInsets.only(top: 80, left: 40, right: 40),
                  child: Card(
                      semanticContainer: true,
                      color: Colors.lightGreen,
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      shadowColor: Colors.green,
                      child: InkWell(
                          onTap: () {
                            openurl2();
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
                                child: Image.asset('images/hospitals.jpg',
                                    // width: 300,
                                    height: 180,
                                    fit: BoxFit.fill),
                              ),
                              ListTile(
                                title: Text('Hospitals near me',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ))))
            ],
          ))),
    );
  }
}
