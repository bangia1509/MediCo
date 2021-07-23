import 'package:flutter/material.dart';
import 'package:medi_co/services/auth.dart';
import 'package:medi_co/shared/loading.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool loading = false;
  final AuthService _auth = AuthService();

  var gendVal;
  var userType = ['Doctor', 'Patient'];
  var myUser;
  var newUserForm = GlobalKey<FormState>();
  var error = ' ';
  var emailCont = TextEditingController();
  var passCont = TextEditingController();
  var rePassCont = TextEditingController();
  var fnameCont = TextEditingController();
  var lnameCont = TextEditingController();
  var numCont = TextEditingController();
  var addressCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: newUserForm,
      child: Scaffold(
        body: loading ? showLoading() : getListView(),
        appBar: AppBar(
          actions: [
            Padding(
                child: RaisedButton(
                    child: Text(
                      'Proceed',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    color: Colors.white,
                    onPressed: () async {
                      int flag;

                      if (gendVal == null) {
                        flag = 0;
                        setState(() {
                          error = 'Please select Gender';
                        });
                      } else {
                        flag = 1;
                        setState(() {
                          error = ' ';
                        });
                      }

                      if (newUserForm.currentState.validate()) {
                        if (flag == 1) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                                  emailCont.text,
                                  passCont.text,
                                  myUser,
                                  fnameCont.text,
                                  lnameCont.text,
                                  gendVal,
                                  numCont.text,
                                  addressCont.text);
                          if (result == null) {
                            setState(() {
                              loading = false;
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      'Invalid Email OR Email already used'),
                                  content: Text('Please try again.'),
                                );
                              },
                            );
                          } else {
                            Navigator.pop(context);
                          }

                          newUserForm.currentState.validate();
                        }
                      }
                    }),
                padding: EdgeInsets.only(top: 10, right: 15, bottom: 10))
          ],
          title: Text('New User'),
        ),
      ),
    );
  }

  ListView getListView() => ListView(
        children: [
          Card(
            child: Padding(
                child: Row(
                  children: [
                    Expanded(
                        child: Icon(
                      Icons.person,
                      size: 90,
                    )),
                    Expanded(
                        child: DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return "Please Select User Type";
                              }
                            },
                            hint: Text('User Type'),
                            style: TextStyle(fontSize: 17, color: Colors.black),
                            value: myUser,
                            items: userType
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (newVal) {
                              setState(() {
                                this.myUser = newVal;
                              });
                            }))
                  ],
                ),
                padding: EdgeInsets.only(top: 20, left: 20.0, right: 25.0)),
            elevation: 5.0,
          ),
          Container(
            height: 15,
          ),
          Card(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: TextFormField(
                    controller: fnameCont,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter First Name";
                      }
                    },
                    decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 14),
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 17),
                        labelText: 'First Name'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: TextFormField(
                    controller: lnameCont,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter Last Name";
                      }
                    },
                    decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 14),
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 17),
                        labelText: 'Last Name'),
                  ),
                ),
                Padding(
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          'Gender:',
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ),
                      Row(children: [
                        Radio(
                          onChanged: (value) {
                            setState(() {
                              this.gendVal = value;
                            });
                          },
                          value: 'm',
                          groupValue: gendVal,
                        ),
                        Text(
                          'Male',
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        Radio(
                          onChanged: (value) {
                            setState(() {
                              this.gendVal = value;
                            });
                          },
                          value: 'f',
                          groupValue: gendVal,
                        ),
                        Text(
                          'Female',
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ])
                    ]),
                    padding: EdgeInsets.only(left: 20, top: 30, right: 50)),
                Padding(
                    child: Text(
                      error,
                      style: TextStyle(
                          color: Theme.of(context).errorColor, fontSize: 14),
                    ),
                    padding: EdgeInsets.only(bottom: 10))
              ],
            ),
            elevation: 5.0,
          ),
          Container(
            height: 15,
          ),
          Card(
              elevation: 5.0,
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: TextFormField(
                    controller: numCont,
                    validator: (value) {
                      if (value.length < 10) {
                        return "Please enter a valid Contact Number";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 14),
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 17),
                        labelText: 'Contact Number'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: TextFormField(
                    controller: addressCont,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter Address";
                      }
                    },
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 14),
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 17),
                        labelText: 'Address'),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 20),
                  child: TextFormField(
                    controller: emailCont,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter Email";
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 14),
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 17),
                        labelText: 'Email'),
                  ),
                ),
              ])),
          Container(
            height: 15,
          ),
          Card(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: TextFormField(
                    controller: passCont,
                    validator: (value) {
                      if (value.length < 6) {
                        return "Please enter atleast 6 characters";
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Minimum 6 characters',
                        errorStyle: TextStyle(fontSize: 14),
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 17),
                        labelText: 'Password'),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 20),
                  child: TextFormField(
                    controller: rePassCont,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please re-enter Password";
                      }
                      if (rePassCont.text != passCont.text) {
                        return "Passwords do not match";
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 14),
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 17),
                        labelText: 'Confirm Password'),
                  ),
                )
              ],
            ),
            elevation: 5.0,
          ),
          Container(
            height: 15,
          ),
        ],
      );
  Widget showLoading() {
    return Container(
      color: Colors.white,
      child: Center(child: Loading(Theme.of(context).primaryColor)),
    );
  }
}
