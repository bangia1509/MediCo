import 'package:flutter/material.dart';
import 'package:medi_co/screens/register.dart';

import 'package:medi_co/services/auth.dart';
import 'package:medi_co/shared/loading.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  // var userType = ['Doctor', 'Patient'];
  // var myUser;
  bool loading = false;
  var loginForm = GlobalKey<FormState>();
  var passCont = TextEditingController();
  var userCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return loading
        ? showLoading()
        : Form(
            key: loginForm,
            child: Scaffold(
              body: Container(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Column(
                        children: [
                          getStethoImage(),
                          Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Text(
                              'MediCo',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textScaleFactor: 3.0,
                            ),
                          ),
                          Container(
                            height: 25.0,
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.only(top: 40, left: 25.0, right: 25.0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: userCont,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter email.";
                            }
                          },
                          decoration: InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(width: 2.5, color: Colors.red)),
                            errorStyle: TextStyle(fontSize: 15),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    width: 2.5,
                                    color: Theme.of(context).errorColor)),
                            labelText: 'Email',
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 17),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(width: 2.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(width: 2.5),
                            ),
                          ),
                        )),
                    Padding(
                        padding:
                            EdgeInsets.only(top: 27, left: 25.0, right: 25.0),
                        child: TextFormField(
                          controller: passCont,
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter password.";
                            }
                          },
                          decoration: InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(width: 2.5, color: Colors.red)),
                            errorStyle: TextStyle(fontSize: 15),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    width: 2.5,
                                    color: Theme.of(context).errorColor)),
                            labelText: 'Password',
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 17),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(width: 2.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(width: 2.5),
                            ),
                          ),
                        )),
                    // Padding(
                    //     child: Center(
                    //       child: Container(
                    //         width: 130,
                    //         child: DropdownButtonFormField(
                    //             validator: (value) {
                    //               if (value == null) {
                    //                 return "Please Select User Type";
                    //               }
                    //             },
                    //             hint: Text('User Type'),
                    //             style: TextStyle(fontSize: 17, color: Colors.black),
                    //             value: myUser,
                    //             items: userType
                    //                 .map((e) =>
                    //                     DropdownMenuItem(value: e, child: Text(e)))
                    //                 .toList(),
                    //             onChanged: (newVal) {
                    //               setState(() {
                    //                 this.myUser = newVal;
                    //               });
                    //             }),
                    //       ),
                    //     ),
                    //     padding: EdgeInsets.only(top: 15)),
                    Padding(
                        child: Center(
                          child: Container(
                              width: 125.0,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 5.0,
                                  child: Text(
                                    'LOGIN',
                                    textScaleFactor: 1.3,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.black,
                                  onPressed: () async {
                                    if (loginForm.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      dynamic result = await _auth
                                          .signInWithEmailAndPassword(
                                              userCont.text, passCont.text);
                                      if (result == null) {
                                        setState(() {
                                          loading = false;
                                        });
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Invalid Username or Password'),
                                              content:
                                                  Text('Please try again.'),
                                            );
                                          },
                                        );
                                      }
                                    }
                                  })),
                        ),
                        padding: EdgeInsets.only(top: 35)),
                    Padding(
                        child: Center(
                          child: Container(
                              width: 200,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 5.0,
                                  child: Text(
                                    'New User? SIGN UP',
                                    textScaleFactor: 1.3,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()));
                                    setState(() {
                                      userCont.text = '';
                                      passCont.text = '';
                                      // myUser = null;
                                    });
                                  })),
                        ),
                        padding: EdgeInsets.only(top: 7))
                  ],
                ),
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Colors.white,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.0, 1.0),
                      stops: [0.4, 1.0],
                      tileMode: TileMode.clamp),
                ),
              ),
            ),
          );
  }

  Image getStethoImage() => Image(
        height: 150.0,
        image: AssetImage("images/stetho.png"),
      );
  Widget showLoading() {
    return Container(
      child: Loading(Colors.black),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Colors.white,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.4, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
